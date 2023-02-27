import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:auth/auth.dart';
import 'package:delta_team/amplifyconfiguration.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:delta_team/features/Home_welcome_mobile/recentLessonTest.dart';
import 'package:delta_team/features/Home_welcome_mobile/roleScreentest.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../auth/login/amplify_auth.dart';
import '../auth/login/login_mobile/loginmobile_body.dart';
import 'backendWidgetTest.dart';
import 'contactUsTest.dart';
import 'fullstackWidgetTest.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  List<String> roles = [];
  @override
  void initState() {
    super.initState();
    getUserAttributes();
    getUserRoles().then((value) {
      setState(() {
        roles = value;
      });

      //Lecture count
      // getLectureCounts();
    });
  }

  Map<String, dynamic> lectures = {};
  Future<List<String>> getUserRoles() async {
    try {
      final restOperation = Amplify.API.get('/api/user/lectures',
          apiName: "getUserLectures", queryParameters: {'paDate': 'Jan2023'});

      final response = await restOperation.response;

      Map<String, dynamic> responseMap = jsonDecode(response.decodeBody());
      setState(() {
        lectures = responseMap;
      });

      List<String> roles = [];
      responseMap['lectures'].forEach((lecture) {
        List<dynamic> lectureRoles = lecture['roles'];
        roles.addAll(lectureRoles.map((role) => role.toString()));
      });
      Map<String, int> lectureCountByRole = {};

      print(lectureCountByRole);

      Set<String> set = Set<String>.from(roles);
      List<String> mergedArr = set.toList();
      print(mergedArr);

      // Modify the role names in mergedArr
      Map<String, String> roleNamesMap = {
        'fullstack': 'Fullstack Development',
        'backend': 'Backend Development',
        'uiux': 'UI/UX Design',
        'qa': 'Quality Assurance',
        'productManager': 'Project Management',
      };
      List<String> modifiedRoles =
          mergedArr.map((role) => roleNamesMap[role] ?? role).toList();
      print(modifiedRoles);

      return modifiedRoles;
    } on ApiException catch (e) {
      throw Exception('Failed to load roles: $e');
    }
  }
//Orginal Working version for roles
  // Map<String, dynamic> lectures = {};
  // Future<List<String>> getUserRoles() async {
  //   try {
  //     final restOperation = Amplify.API.get('/api/user/lectures',
  //         apiName: "getUserLectures", queryParameters: {'paDate': 'Jan2023'});

  //     final response = await restOperation.response;

  //     Map<String, dynamic> responseMap = jsonDecode(response.decodeBody());
  //     setState(() {
  //       lectures = responseMap;
  //     });

  //     List<String> roles = [];
  //     responseMap['lectures'].forEach((lecture) {
  //       List<dynamic> lectureRoles = lecture['roles'];
  //       roles.addAll(lectureRoles.map((role) => role.toString()));
  //     });
  //     Map<String, int> lectureCountByRole = {};

  //     print(lectureCountByRole);

  //     Set<String> set = Set<String>.from(roles);
  //     List<String> mergedArr = set.toList();
  //     print(mergedArr);
  //     // Modify the role names in mergedArr

  //     return mergedArr;
  //   } on ApiException catch (e) {
  //     throw Exception('Failed to load roles: $e');
  //   }
  // }

  ////////
  // Future<Map<String, int>> getLectureCounts() async {
  //   try {
  //     final restOperation = Amplify.API.get(
  //       '/api/user/lectures',
  //       apiName: 'getUserLectures',
  //       queryParameters: {'paDate': 'Jan2023'},
  //     );

  //     final response = await restOperation.response;

  //     Map<String, dynamic> responseMap = jsonDecode(response.decodeBody());
  //     setState(() {
  //       lectures = responseMap;
  //     });

  //     Map<String, int> roleCounts = {};
  //     responseMap['lectures'].forEach((lecture) {
  //       List<dynamic> lectureRoles = lecture['roles'];
  //       lectureRoles.forEach((role) {
  //         String roleName = role.toString();
  //         roleCounts[roleName] = (roleCounts[roleName] ?? 0) + 1;
  //       });
  //     });
  //     print("ovo je role Counssssssssssss $roleCounts");
  //     return roleCounts;
  //   } on ApiException catch (e) {
  //     throw Exception('Failed to load lecture counts: $e');
  //   }
  // }

  String _userName = '';
  String _userEmail = '';
  void getUserAttributes() async {
    try {
      List<AuthUserAttribute> userAttributes =
          await Amplify.Auth.fetchUserAttributes();

      Map<String, String> attributeMap = {};
      userAttributes.forEach((attribute) {
        attributeMap[attribute.userAttributeKey.toJson()] = attribute.value;
        // print("this is atribute value : $attribute");
      });

      String email = attributeMap['email'] ?? '';
      String givenName = attributeMap['given_name'] ?? '';
      String familyName = attributeMap['family_name'] ?? '';

      // print(" this is atribute map$attributeMap");
      // print('attributeMap: $attributeMap');
      setState(() {
        _userEmail = email;
        _userName = '$givenName $familyName';
      });
    } on AuthException catch (e) {
      print('Failed to fetch user attributes: ${e.message}');
    }
  }

  final Map<String, String> roleIcons = {
    'UI/UX Design': "assets/images/uiuxDesigner.svg",
    'Fullstack Development': "assets/images/fullstackIcon.svg",
    'Backend Development': "assets/images/backendIcon.svg",
    "Project Management": "assets/images/projMengIcon.svg",
    "Quality Assurance": "assets/images/qaIcon.svg",
    // add more mappings as needed
  };

  bool isSelected = false;
  String? selectedRole;
  bool isSelectedRecentLessons = false;
  bool isSelectedContactUs = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      child: Drawer(
        shadowColor: Colors.black,
        child: Container(
          color: Colors.black,
          child: ListView(
            children: <Widget>[
              const SizedBox(
                height: 17,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _userName,
                      style: const TextStyle(
                          color: Color.fromRGBO(34, 233, 116, 1),
                          fontSize: 32,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset("assets/images/user-line.svg"),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          _userEmail,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset("assets/images/uiuxDesigner.svg"),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "2/22 Lessons",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: Colors.white,
                thickness: 1,
                endIndent: 18,
                indent: 18,
              ),
              for (var role in roles)
                Padding(
                  padding: const EdgeInsets.only(left: 21),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isSelected = true;
                        selectedRole = role;
                      });

                      switch (role) {
                        case 'Fullstack Development':
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FullstackWidget()),
                          ).then((value) {
                            setState(() {
                              isSelected = false;
                              selectedRole = null;
                            });
                          });
                          break;
                        case 'Backend Development':
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BackendWidget()),
                          ).then((value) {
                            setState(() {
                              isSelected = false;
                              selectedRole = null;
                            });
                          });
                          break;
                        case 'UI/UX Design':
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BackendWidget()),
                          ).then((value) {
                            setState(() {
                              isSelected = false;
                              selectedRole = null;
                            });
                          });
                          break;
                        case 'Project Management':
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BackendWidget()),
                          ).then((value) {
                            setState(() {
                              isSelected = false;
                              selectedRole = null;
                            });
                          });
                          break;
                        case 'Quality Assurance':
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BackendWidget()),
                          ).then((value) {
                            setState(() {
                              isSelected = false;
                              selectedRole = null;
                            });
                          });
                          break;
                        // add more cases for other roles if needed
                        default:
                          // handle invalid role
                          break;
                      }
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          roleIcons[role]!,
                          width: 19,
                          height: 19,
                        ),
                        const SizedBox(
                          width: 10,
                          height: 55,
                        ),
                        Text(
                          role,
                          style: TextStyle(
                            color: isSelected && selectedRole == role
                                ? Color.fromRGBO(34, 233, 116, 1)
                                : Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/images/recent-lesson.svg",
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isSelectedRecentLessons = true;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RecentLessonsScreen()),
                        ).then((value) {
                          setState(() {
                            isSelectedRecentLessons = false;
                          });
                        });
                      },
                      child: Text(
                        "Recent Lessons",
                        style: TextStyle(
                          color: isSelectedRecentLessons
                              ? Color.fromRGBO(34, 233, 116, 1)
                              : Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 35),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/images/Vector.svg"),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isSelectedContactUs = true;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ContactUsScreen()),
                        ).then((value) {
                          setState(() {
                            isSelectedContactUs = false;
                          });
                        });
                      },
                      child: Text(
                        "Contact us",
                        style: TextStyle(
                          color: isSelectedContactUs
                              ? Color.fromRGBO(34, 233, 116, 1)
                              : Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 90,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.of(context).pop();
                      try {
                        signOutCurrentUser(null, null, context);
                        safePrint('User Signed Out');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreenMobile(),
                          ),
                        );
                      } on AmplifyException catch (e) {
                        print(e.message);
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.0),
                      side: BorderSide(color: Colors.white),
                    ),
                  ),
                  child: const Text(
                    "Log out",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// return ListView.builder(
//   itemCount: roles.length,
//   itemBuilder: (context, index) {
//     return ListTile(
//       title: Text(roles[index]),
//     );
//   },
// );

// Container(
//       width: 400,
//       child: Drawer(
//         child: Container(
//           color: Colors.black,
//           child: Padding(
//             padding: const EdgeInsets.only(top: 50, left: 20),
//             child: Column(
//               // crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   _userName,
//                   style: TextStyle(
//                       color: Color.fromARGB(255, 0, 255, 42),
//                       fontSize: 32,
//                       fontWeight: FontWeight.w700),
//                 ),
//                 SizedBox(
//                   height: 25,
//                 ),
//                 Row(
//                   children: [
//                     SvgPicture.asset("assets/images/user-line.svg"),
//                     SizedBox(
//                       width: 15,
//                     ),
//                     Text(
//                       _userEmail,
//                       style: TextStyle(color: Colors.white, fontSize: 16),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 25,
//                 ),
//                 Row(
//                   children: [
//                     SvgPicture.asset("assets/images/uiuxDesigner.svg"),
//                     SizedBox(
//                       width: 15,
//                     ),
//                     Text(
//                       "2/22 Lessons",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 const Divider(
//                   color: Colors.white,
//                   thickness: 1,
//                   endIndent: 20,
//                 ),
//                 Row(
//                   children: [
//                     SvgPicture.asset("assets/images/uiuxDesigner.svg"),
//                     SizedBox(
//                       width: 15,
//                     ),
//                     Text(
//                       "UI/UX Design",
//                       style: TextStyle(color: Colors.white, fontSize: 16),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 25,
//                 ),
//                 Row(
//                   children: [
//                     SvgPicture.asset("assets/images/recent-lesson.svg"),
//                     SizedBox(
//                       width: 15,
//                     ),
//                     Text(
//                       "Recent Lessons",
//                       style: TextStyle(color: Colors.white, fontSize: 16),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 25,
//                 ),
//                 Row(
//                   children: [
//                     SvgPicture.asset("assets/images/Vector.svg"),
//                     SizedBox(
//                       width: 15,
//                     ),
//                     Text(
//                       "Contact us",
//                       style: TextStyle(color: Colors.white, fontSize: 16),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 25,
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
// Padding(
//   padding: const EdgeInsets.only(top: 100, left: 135),
//   child: ElevatedButton(
//     onPressed: () async {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         Navigator.of(context).pop();
//         try {
//           signOutCurrentUser(null, null, context);
//           safePrint('User Signed Out');
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const LoginScreenMobile(),
//             ),
//           );
//         } on AmplifyException catch (e) {
//           print(e.message);
//         }
//       });
//     },
//     style: ElevatedButton.styleFrom(
//       foregroundColor: Colors.white,
//       backgroundColor: Colors.black,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(2.0),
//         side: BorderSide(color: Colors.white),
//       ),
//     ),
//     child: Text("Logout"),
//   ),
// ),
//           ],
//         ),
//       ),
//     ),
//   ),
// );

//  Container(
//       width: 500,
//       child: Drawer(
//         shadowColor: Colors.black,
//         child: Container(
//           color: Colors.black,
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: <Widget>[
//               SizedBox(
//                 height: 20,
//               ),
//               DrawerHeader(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'John Doe',
//                       style: TextStyle(
//                           fontSize: 32, color: Color.fromARGB(255, 0, 255, 76)),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           'John Doe',
//                           style: TextStyle(fontSize: 16, color: Colors.white),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           'John Doe',
//                           style: TextStyle(fontSize: 16, color: Colors.white),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );

// Widget buildHeader(BuildContext context) => Container(
//       padding: EdgeInsets.only(top: 40, left: 20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "John Doe",
//             style: TextStyle(
//                 color: Color.fromARGB(255, 0, 255, 42),
//                 fontSize: 32,
//                 fontWeight: FontWeight.w700),
//           ),
//           SizedBox(
//             height: 25,
//           ),
//           Row(
//             children: [
//               Icon(
//                 Icons.account_box,
//                 color: Colors.white,
//               ),
//               Text(
//                 "Email",
//                 style: TextStyle(color: Colors.white, fontSize: 16),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 25,
//           ),
//           Row(
//             children: [
//               Icon(
//                 Icons.play_lesson_outlined,
//                 color: Colors.white,
//               ),
//               Text(
//                 "Lessons",
//                 style: TextStyle(color: Colors.white),
//               ),
//             ],
//           ),
//           ListTile(
//             title: Text("Favoriz"),
//           ),
//           ListTile(
//             title: Text("Favoriz"),
//           ),
//           ListTile(
//             title: Text("Favoriz"),
//           ),
//           ListTile(
//             title: Text("Favoriz"),
//           ),
//           ListTile(
//             title: Text("Favoriz"),
//           ),
//         ],
//       ),
//     );
