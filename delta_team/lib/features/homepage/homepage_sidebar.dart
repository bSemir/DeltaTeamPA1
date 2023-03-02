import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

Map<String, dynamic> lectures = {};
List varijablaRola = [];

bool isSelectedHome = true;
bool isSelectedRecent = false;
bool isSelectedContact = false;
bool isSelectedFirstRole = false;
bool isSelectedSecondRole = false;
int selectedIndex = -1;

class _SidebarState extends State<Sidebar> {
  Future<Map<String, dynamic>> getUserLectures() async {
    // signInUser();
    try {
      final restOperation = Amplify.API.get('/api/user/lectures',
          apiName: 'getUserLectures',
          queryParameters: {
            'paDate': 'Jan2023'
            // , 'name': 'Flutter widgets'
          });
      final response = await restOperation.response;

      Map<String, dynamic> responseMap = jsonDecode(response.decodeBody());

      setState(() {
        lectures = responseMap;
      });

      List temp = [];
      responseMap['lectures'].forEach((lecture) {
        temp.addAll(lecture['roles']);
      });

      Set<String> set = Set<String>.from(temp);
      List<String> roles = set.toList();

      setState(() {
        varijablaRola = roles;
      });
      return responseMap;
    } on ApiException catch (e) {
      throw Exception('Failed to load lectures: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getUserLectures();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 62, right: 24, left: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset("assets/images/sidebar_logo.png"),
          const SizedBox(
            height: 80,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/homescreen');
              setState(() {
                isSelectedHome = true;
                isSelectedContact = false;
                isSelectedRecent = false;
                isSelectedFirstRole = false;
                isSelectedSecondRole = false;
                selectedIndex = -1;
              });
            },
            child: Row(
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/Homescreen.png',
                    color: isSelectedHome ? Colors.green : Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Homescreen',
                  style: TextStyle(
                      fontSize: 16,
                      color: isSelectedHome ? Colors.green : Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: varijablaRola.length,
              itemBuilder: (context, index) {
                var res = varijablaRola[index];
                String image = "assets/images/backendBijela.png";

                String str = "";

                if (res == "backend") {
                  str = "Backend Development";
                  image = "assets/images/backendBijela.png";
                }
                if (res == "fullstack") {
                  str = "Fullstack Development";
                  image = "assets/images/fullstackBijela.png";
                }
                if (res == "productManager") {
                  str = "Project Manager";
                  image = "assets/images/homepage_manager.png";
                }
                if (res == "uiux") {
                  str = "UI/UX Design";
                  image = "assets/images/homepageui.png";
                }
                if (res == "qa") {
                  str = "QA";
                  image = "assets/images/homepageqa.png";
                }

                return GestureDetector(
                  onTap: () async {
                    Map<String, dynamic> lecturesList = lectures;
                    if (lectures.isNotEmpty) {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setString('myMap', jsonEncode(lecturesList));
                      setState(() {
                        selectedIndex = index;
                      });
                      if (index == 0) {
                        setState(() {
                          isSelectedRecent = false;
                          isSelectedHome = false;
                          isSelectedContact = false;
                          isSelectedFirstRole = true;
                          isSelectedSecondRole = false;
                        });
                      } else if (index == 1) {
                        setState(() {
                          isSelectedRecent = false;
                          isSelectedHome = false;
                          isSelectedContact = false;
                          isSelectedFirstRole = false;
                          isSelectedSecondRole = true;
                        });
                      }

                      await prefs.setString("role", res);
                    }

                    Navigator.pushNamed(context, '/lecturesPage');
                  },
                  child: Row(
                    children: [
                      Image.asset(image,
                          width: 24,
                          height: 24,
                          color: selectedIndex == index
                              ? Colors.green
                              : Colors.white),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        str,
                        style: TextStyle(
                            fontSize: 16,
                            color: selectedIndex == index
                                ? Colors.green
                                : Colors.white),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 20,
                );
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/recentLectures');
              setState(() {
                isSelectedRecent = true;
                isSelectedHome = false;
                isSelectedContact = false;
                isSelectedFirstRole = false;
                isSelectedSecondRole = false;
                selectedIndex = -1;
              });
            },
            child: Row(
              children: [
                Image.asset(
                  'assets/images/recent_icon.png',
                  color: isSelectedRecent ? Colors.green : Colors.white,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Recent Lectures',
                  style: TextStyle(
                      color: isSelectedRecent ? Colors.green : Colors.white,
                      fontSize: 16),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/contactUs');
              setState(() {
                isSelectedRecent = false;
                isSelectedHome = false;
                isSelectedContact = true;
                isSelectedFirstRole = false;
                isSelectedSecondRole = false;
                selectedIndex = -1;
              });
            },
            child: Row(
              children: [
                Image.asset(
                  'assets/images/contact_icon.png',
                  color: isSelectedContact ? Colors.green : Colors.white,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Contact us!',
                  style: TextStyle(
                      color: isSelectedContact ? Colors.green : Colors.white,
                      fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}