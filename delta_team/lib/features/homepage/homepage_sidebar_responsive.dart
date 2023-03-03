// import 'dart:convert';

// import 'package:amplify_api/amplify_api.dart';
// import 'package:amplify_core/amplify_core.dart';
// import 'package:delta_team/features/homepage/provider/selectedRoleProvider.dart';
// import 'package:delta_team/features/onboarding/onboarding_mobile/mobile_models/role_mobile.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../auth/login/providers/userLecturesProvider.dart';

// class ResponsiveSidebar extends StatefulWidget {
//   const ResponsiveSidebar({super.key});

//   @override
//   State<ResponsiveSidebar> createState() => _ResponsiveSidebarState();
// }

// List varijablaRola = [];

// bool isSelectedHome = true;
// bool isSelectedRecent = false;
// bool isSelectedContact = false;
// bool isSelectedFirstRole = false;
// bool isSelectedSecondRole = false;
// int selectedIndex = -1;

// class _ResponsiveSidebarState extends State<ResponsiveSidebar> {
//   @override
//   void initState() {
//     super.initState();
//     // getUserLectures();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Set<String> uniqueRoles = {};
//     List<String> roleTemp = [];
//     final userLecturesProvider =
//         Provider.of<LecturesProvider>(context, listen: false);
//     final selectedRoleProvider =
//         Provider.of<SelectedRoleProvider>(context, listen: false);
//     if (userLecturesProvider.lectures.isNotEmpty) {
//       List<dynamic> lecturesList = userLecturesProvider.lectures["lectures"];
//       for (int i = 0; i < lecturesList.length; i++) {
//         Map<String, dynamic> lecture = lecturesList[i];
//         List<String> roles = lecture['roles'].cast<String>();

//         for (String role in roles) {
//           roleTemp.add(role);
//         }
//       }
//       for (String role in roleTemp) {
//         uniqueRoles.add(role);
//       }
//       for (String role in uniqueRoles) {
//         if (!varijablaRola.contains(role)) {
//           varijablaRola.add(role);
//         }
//       }
//     }

//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Padding(
//         padding: const EdgeInsets.only(top: 62, right: 24, left: 24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(child: Image.asset("assets/images/sidebar_logo.png")),
//             const SizedBox(
//               height: 80,
//             ),
//             GestureDetector(
//               key: const Key("homescreen_key"),
//               onTap: () {
//                 Navigator.pushNamed(context, '/homescreen');
//                 setState(() {
//                   isSelectedHome = true;
//                   isSelectedContact = false;
//                   isSelectedRecent = false;
//                   isSelectedFirstRole = false;
//                   isSelectedSecondRole = false;
//                   selectedIndex = -1;
//                 });
//               },
//               child: Row(
//                 children: [
//                   Image.asset(
//                     'assets/images/Homescreen.png',
//                     color: Colors.white,
//                   ),
//                   const SizedBox(
//                     width: 5,
//                   ),
//                   const Text(
//                     'Homescreen',
//                     style: TextStyle(fontSize: 16, color: Colors.white),
//                   )
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             SizedBox(
//               child: ListView.separated(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: varijablaRola.length,
//                 itemBuilder: (context, index) {
//                   var res = varijablaRola[index];
//                   String image = "assets/images/backendBijela.png";

//                   String str = "";

//                   if (res == "backend") {
//                     str = "Backend Development";
//                     image = "assets/images/backendBijela.png";
//                   }
//                   if (res == "fullstack") {
//                     str = "Fullstack Development";
//                     image = "assets/images/fullstackBijela.png";
//                   }
//                   if (res == "productManager") {
//                     str = "Project Manager";
//                     image = "assets/images/homepage_manager.png";
//                   }
//                   if (res == "uiux") {
//                     str = "UI/UX Design";
//                     image = "assets/images/homepageui.png";
//                   }
//                   if (res == "qa") {
//                     str = "QA";
//                     image = "assets/images/homepageqa.png";
//                   }

//                   return GestureDetector(
//                     key: const Key("getlectures_key"),
//                     onTap: () async {
//                       Map<String, dynamic> lecturesList =
//                           userLecturesProvider.lectures;
//                       if (userLecturesProvider.lectures.isNotEmpty) {
//                         // final prefs = await SharedPreferences.getInstance();
//                         // await prefs.setString('myMap', jsonEncode(lecturesList));
//                         setState(() {
//                           selectedIndex = index;
//                         });
//                         if (index == 0) {
//                           setState(() {
//                             isSelectedRecent = false;
//                             isSelectedHome = false;
//                             isSelectedContact = false;
//                             isSelectedFirstRole = true;
//                             isSelectedSecondRole = false;
//                           });
//                         } else if (index == 1) {
//                           setState(() {
//                             isSelectedRecent = false;
//                             isSelectedHome = false;
//                             isSelectedContact = false;
//                             isSelectedFirstRole = false;
//                             isSelectedSecondRole = true;
//                           });
//                         }

//                         selectedRoleProvider.setRole(res);
//                         // await prefs.setString("role", res);
//                       }

//                       Navigator.pushNamed(context, '/lecturesPage');
//                     },
//                     child: Row(
//                       children: [
//                         Image.asset(image,
//                             width: 24, height: 24, color: Colors.white),
//                         const SizedBox(
//                           width: 5,
//                         ),
//                         Text(
//                           str,
//                           style: TextStyle(fontSize: 16, color: Colors.white),
//                         )
//                       ],
//                     ),
//                   );
//                 },
//                 separatorBuilder: (BuildContext context, int index) {
//                   return const SizedBox(
//                     height: 20,
//                   );
//                 },
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             GestureDetector(
//               key: const Key("recentlectures_key"),
//               onTap: () {
//                 Navigator.pushNamed(context, '/recentLectures');
//                 setState(() {
//                   isSelectedRecent = true;
//                   isSelectedHome = false;
//                   isSelectedContact = false;
//                   isSelectedFirstRole = false;
//                   isSelectedSecondRole = false;
//                   selectedIndex = -1;
//                 });
//               },
//               child: Row(
//                 children: [
//                   Image.asset(
//                     'assets/images/recent_icon.png',
//                     color: Colors.white,
//                   ),
//                   const SizedBox(
//                     width: 5,
//                   ),
//                   Text(
//                     'Recent Lectures',
//                     style: TextStyle(color: Colors.white, fontSize: 16),
//                   )
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             GestureDetector(
//               key: const Key("contact_key"),
//               onTap: () {
//                 Navigator.pushNamed(context, '/contactUs');
//                 setState(() {
//                   isSelectedRecent = false;
//                   isSelectedHome = false;
//                   isSelectedContact = true;
//                   isSelectedFirstRole = false;
//                   isSelectedSecondRole = false;
//                   selectedIndex = -1;
//                 });
//               },
//               child: Row(
//                 children: [
//                   Image.asset(
//                     'assets/images/contact_icon.png',
//                     color: Colors.white,
//                   ),
//                   const SizedBox(
//                     width: 5,
//                   ),
//                   Text(
//                     'Contact us!',
//                     style: TextStyle(color: Colors.white, fontSize: 16),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }