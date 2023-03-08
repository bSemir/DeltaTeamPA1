import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:delta_team/features/homepage/homescreen.dart';
import 'package:delta_team/features/homepage/provider/selectedRoleProvider.dart';
import 'package:delta_team/features/onboarding/onboarding_mobile/mobile_models/role_mobile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/login/providers/userLecturesProvider.dart';
import 'homepage_video_screen.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

List varijablaRola = [];
bool isSelectedHome = true;
bool isSelectedRecent = false;
bool isSelectedContact = false;
bool isSelectedFirstRole = false;
bool isSelectedSecondRole = false;
int selectedIndex = -1;

class _SidebarState extends State<Sidebar> {
  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Map<String, dynamic> lectures = {};

  Future<void> _loadPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final lecturesString = prefs.getString('lecturesPrefs');
    final selectedHomePref = prefs.getBool('isSelectedHome');
    final selectedContactPref = prefs.getBool('isSelectedContact');
    final selectedRecentPref = prefs.getBool('isSelectedRecent');
    final selectedFirstRole = prefs.getBool('isSelectedFirstRole');
    final selectedSecondRole = prefs.getBool('isSelectedSecondRole');
    final indexSelectedPref = prefs.getInt("selectedIndex");
    setState(() {
      lectures = json.decode(lecturesString!);
      isSelectedHome = selectedHomePref ?? true;
      isSelectedContact = selectedContactPref ?? false;
      isSelectedRecent = selectedRecentPref ?? false;
      isSelectedFirstRole = selectedFirstRole ?? false;
      isSelectedSecondRole = selectedSecondRole ?? false;
      selectedIndex = indexSelectedPref ?? -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool removeText = false;

    if (MediaQuery.of(context).size.width > 750) {
      removeText = true;
    }

    if (MediaQuery.of(context).size.height < 500) {
      return Container();
    }

    bool isScreenSmall = false;
    if (MediaQuery.of(context).size.width < 650) {
      isScreenSmall = true;
    }

    Set<String> uniqueRoles = {};
    List<String> roleTemp = [];

    if (lectures.isNotEmpty) {
      List<dynamic> lecturesList = lectures["lectures"];
      for (int i = 0; i < lecturesList.length; i++) {
        Map<String, dynamic> lecture = lecturesList[i];
        List<String> roles = lecture['roles'].cast<String>();

        for (String role in roles) {
          roleTemp.add(role);
        }
      }
      for (String role in roleTemp) {
        uniqueRoles.add(role);
      }
      for (String role in uniqueRoles) {
        if (!varijablaRola.contains(role)) {
          varijablaRola.add(role);
        }
      }
    }

    return isScreenSmall
        ? Scaffold(
            backgroundColor: Colors.black,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 62, right: 24, left: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Image.asset("assets/images/sidebar_logo.png")),
                    const SizedBox(
                      height: 80,
                    ),
                    GestureDetector(
                      key: const Key("homescreen_key"),
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        prefs.setBool('isSelectedHome', true);
                        prefs.setBool('isSelectedContact', false);
                        prefs.setBool('isSelectedRecent', false);
                        prefs.setBool('isSelectedFirstRole', false);
                        prefs.setBool('isSelectedSecondRole', false);
                        prefs.setInt("selectedIndex", -1);
                        Navigator.pushReplacementNamed(context, '/homescreen');
                        // setState(() {
                        //   isSelectedHome = true;
                        //   isSelectedContact = false;
                        //   isSelectedRecent = false;
                        //   isSelectedFirstRole = false;
                        //   isSelectedSecondRole = false;
                        //   selectedIndex = -1;
                        // });
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/Homescreen.png',
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Homescreen',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          )
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
                            key: const Key("getlectures_key"),
                            onTap: () async {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              if (lectures.isNotEmpty) {
                                //

                                if (index == 0) {
                                  prefs.setBool('isSelectedHome', false);
                                  prefs.setBool('isSelectedContact', false);
                                  prefs.setBool('isSelectedRecent', false);
                                  prefs.setBool('isSelectedFirstRole', true);
                                  prefs.setBool('isSelectedSecondRole', false);
                                  prefs.setInt("selectedIndex", index);

                                  // setState(() {
                                  //   isSelectedRecent = false;
                                  //   isSelectedHome = false;
                                  //   isSelectedContact = false;
                                  //   isSelectedFirstRole = true;
                                  //   isSelectedSecondRole = false;
                                  // });
                                } else if (index == 1) {
                                  prefs.setBool('isSelectedHome', false);
                                  prefs.setBool('isSelectedContact', false);
                                  prefs.setBool('isSelectedRecent', false);
                                  prefs.setBool('isSelectedFirstRole', false);
                                  prefs.setBool('isSelectedSecondRole', true);
                                  prefs.setInt("selectedIndex", index);

                                  // setState(() {
                                  //   isSelectedRecent = false;
                                  //   isSelectedHome = false;
                                  //   isSelectedContact = false;
                                  //   isSelectedFirstRole = false;
                                  //   isSelectedSecondRole = true;
                                  // });
                                }

                                await prefs.setString("role", res);
                              }
                              Navigator.pushReplacementNamed(
                                  context, '/lecturesPage');
                            },
                            child: Row(
                              children: [
                                Image.asset(image,
                                    width: 24, height: 24, color: Colors.white),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  str,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                )
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
                      key: const Key("recentlectures_key"),
                      onTap: () async {
                        Navigator.pushReplacementNamed(
                            context, '/recentLectures');
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setBool('isSelectedHome', false);
                        prefs.setBool('isSelectedContact', false);
                        prefs.setBool('isSelectedRecent', true);
                        prefs.setBool('isSelectedFirstRole', false);
                        prefs.setBool('isSelectedSecondRole', false);
                        prefs.setInt("selectedIndex", -1);

                        // setState(() {
                        //   isSelectedRecent = true;
                        //   isSelectedHome = false;
                        //   isSelectedContact = false;
                        //   isSelectedFirstRole = false;
                        //   isSelectedSecondRole = false;
                        //   selectedIndex = -1;
                        // });
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/recent_icon.png',
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Recent Lectures',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      key: const Key("contact_key"),
                      onTap: () async {
                        Navigator.pushReplacementNamed(context, '/contactUs');

                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setBool('isSelectedHome', false);
                        prefs.setBool('isSelectedContact', true);
                        prefs.setBool('isSelectedRecent', false);
                        prefs.setBool('isSelectedFirstRole', false);
                        prefs.setBool('isSelectedSecondRole', false);
                        prefs.setInt("selectedIndex", -1);
                        // setState(() {
                        //   isSelectedRecent = false;
                        //   isSelectedHome = false;
                        //   isSelectedContact = true;
                        //   isSelectedFirstRole = false;
                        //   isSelectedSecondRole = false;
                        //   selectedIndex = -1;
                        // });
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/contact_icon.png',
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Contact us!',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.only(top: 62, right: 24, left: 24),
                child: Column(
                  children: [
                    Center(
                        child: Image.asset("assets/images/sidebar_logo.png")),
                    const SizedBox(
                      height: 80,
                    ),
                    GestureDetector(
                      key: const Key("homescreen_key2"),
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        prefs.setBool('isSelectedHome', true);
                        prefs.setBool('isSelectedContact', false);
                        prefs.setBool('isSelectedRecent', false);
                        prefs.setBool('isSelectedFirstRole', false);
                        prefs.setBool('isSelectedSecondRole', false);
                        prefs.setInt("selectedIndex", -1);
                        Navigator.pushReplacementNamed(context, '/homescreen');

                        // setState(() {
                        //   isSelectedHome = true;
                        //   isSelectedContact = false;
                        //   isSelectedRecent = false;
                        //   isSelectedFirstRole = false;
                        //   isSelectedSecondRole = false;
                        //   selectedIndex = -1;
                        // });
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: removeText
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/Homescreen.png',
                            color: isSelectedHome ? Colors.green : Colors.white,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          removeText
                              ? Flexible(
                                  child: Text(
                                    'Homescreen',
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontSize: 16,
                                        color: isSelectedHome
                                            ? Colors.green
                                            : Colors.white),
                                  ),
                                )
                              : Container(),
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
                            key: const Key("getlectures_key2"),
                            onTap: () async {
                              final prefs =
                                  await SharedPreferences.getInstance();

                              if (lectures.isNotEmpty) {
                                // setState(() {
                                //   selectedIndex = index;
                                // });
                                if (index == 0) {
                                  prefs.setBool('isSelectedHome', false);
                                  prefs.setBool('isSelectedContact', false);
                                  prefs.setBool('isSelectedRecent', false);
                                  prefs.setBool('isSelectedFirstRole', true);
                                  prefs.setBool('isSelectedSecondRole', false);
                                  prefs.setInt("selectedIndex", index);

                                  // setState(() {
                                  //   isSelectedRecent = false;
                                  //   isSelectedHome = false;
                                  //   isSelectedContact = false;
                                  //   isSelectedFirstRole = true;
                                  //   isSelectedSecondRole = false;
                                  // });
                                } else if (index == 1) {
                                  prefs.setBool('isSelectedHome', false);
                                  prefs.setBool('isSelectedContact', false);
                                  prefs.setBool('isSelectedRecent', false);
                                  prefs.setBool('isSelectedFirstRole', false);
                                  prefs.setBool('isSelectedSecondRole', true);
                                  prefs.setInt("selectedIndex", index);

                                  // setState(() {
                                  //   isSelectedRecent = false;
                                  //   isSelectedHome = false;
                                  //   isSelectedContact = false;
                                  //   isSelectedFirstRole = false;
                                  //   isSelectedSecondRole = true;
                                  // });
                                }

                                await prefs.setString("role", res);
                              }
                              Navigator.pushReplacementNamed(
                                  context, '/lecturesPage');
                            },
                            child: Row(
                              mainAxisAlignment: removeText
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.center,
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
                                removeText
                                    ? Flexible(
                                        child: Text(
                                          str,
                                          style: TextStyle(
                                              decoration: TextDecoration.none,
                                              fontSize: 16,
                                              color: selectedIndex == index
                                                  ? Colors.green
                                                  : Colors.white),
                                        ),
                                      )
                                    : Container(),
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
                      key: const Key("recentlectures_key2"),
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        Navigator.pushReplacementNamed(
                            context, '/recentLectures');
                        prefs.setBool('isSelectedHome', false);
                        prefs.setBool('isSelectedContact', false);
                        prefs.setBool('isSelectedRecent', true);
                        prefs.setBool('isSelectedFirstRole', false);
                        prefs.setBool('isSelectedSecondRole', false);
                        prefs.setInt("selectedIndex", -1);

                        // setState(() {
                        //   isSelectedRecent = true;
                        //   isSelectedHome = false;
                        //   isSelectedContact = false;
                        //   isSelectedFirstRole = false;
                        //   isSelectedSecondRole = false;
                        //   selectedIndex = -1;
                        // });
                      },
                      child: Row(
                        mainAxisAlignment: removeText
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/recent_icon.png',
                            color:
                                isSelectedRecent ? Colors.green : Colors.white,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          removeText
                              ? Flexible(
                                  child: Text(
                                    'Recent Lectures',
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        color: isSelectedRecent
                                            ? Colors.green
                                            : Colors.white,
                                        fontSize: 16),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      key: const Key("contact_key2"),
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setBool('isSelectedHome', false);
                        prefs.setBool('isSelectedContact', true);
                        prefs.setBool('isSelectedRecent', false);
                        prefs.setBool('isSelectedFirstRole', false);
                        prefs.setBool('isSelectedSecondRole', false);
                        prefs.setInt("selectedIndex", -1);

                        // setState(() {
                        //   isSelectedRecent = false;
                        //   isSelectedHome = false;
                        //   isSelectedContact = true;
                        //   isSelectedFirstRole = false;
                        //   isSelectedSecondRole = false;
                        //   selectedIndex = -1;
                        // });
                        Navigator.pushReplacementNamed(context, '/contactUs');
                      },
                      child: Row(
                        mainAxisAlignment: removeText
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/contact_icon.png',
                            color:
                                isSelectedContact ? Colors.green : Colors.white,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          removeText
                              ? Flexible(
                                  child: Text(
                                    'Contact us!',
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        color: isSelectedContact
                                            ? Colors.green
                                            : Colors.white,
                                        fontSize: 16),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
