import 'dart:convert';

import 'package:amplify_core/amplify_core.dart';
import 'package:delta_team/features/homepage/account_modal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homepage_sidebar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showModal = false;
  @override
  void initState() {
    super.initState();
    // _loadPrefs();
  }

  String selectedRole = "";

  Future<void> _loadPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final role = prefs.getString('role');

    setState(() {
      selectedRole = role!;
    });
  }

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
      // responseMap.forEach((key, value) {
      //   print("$key: $value");
      // });

      // print(responseMap.values);
      return responseMap;
    } on ApiException catch (e) {
      throw Exception('Failed to load lectures: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool removePhoto = false;
    bool increaseSizebar = false;

    if (MediaQuery.of(context).size.width < 970) {
      increaseSizebar = true;
      removePhoto = true;
    }

    return Scaffold(
      body: Row(
        children: [
          Container(
              color: Colors.black,
              width: increaseSizebar
                  ? MediaQuery.of(context).size.width * 0.35
                  : MediaQuery.of(context).size.width * 0.25,
              child: const Sidebar()),
          SingleChildScrollView(
            child: Container(
              width: increaseSizebar
                  ? MediaQuery.of(context).size.width * 0.65
                  : MediaQuery.of(context).size.width * 0.75,
              color: Colors.white,
              child: Stack(
                children: [
                  Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, right: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            key: const Key("user_icon_key"),
                            onTap: () {
                              setState(() {
                                showModal = !showModal;
                              });
                            },
                            child: const Icon(
                              Icons.account_circle_rounded,
                              color: Colors.green,
                              size: 50,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //container za sliku profile
                    Padding(
                      padding: EdgeInsets.only(
                        left: (950 / 1440) * MediaQuery.of(context).size.width,
                        top: 30,
                      ),
                      // child: Container(
                      //   color: Colors.red,
                      //   child: Image.asset('assets/images/homepageui.png'),
                      // ),
                    ),

                    //container za sliku koja trci
                    removePhoto
                        ? Column(
                            children: const [
                              Text(
                                'Welcome to',
                                style: TextStyle(fontSize: 45),
                              ),
                              Text(
                                'Product Arena',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 50),
                              )
                            ],
                          )
                        : Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 60),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.252,
                                  height: MediaQuery.of(context).size.height *
                                      0.235,
                                  child: Image.asset(
                                      'assets/images/homepageui.png'),
                                ),
                              ),
                              Column(
                                children: const [
                                  Text(
                                    'Welcome to',
                                    style: TextStyle(fontSize: 45),
                                  ),
                                  Text(
                                    'Product Arena',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 50),
                                  )
                                ],
                              ),
                            ],
                          ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right:
                              (90 / 1440) * MediaQuery.of(context).size.width),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.437,
                        child: const Text(
                          'Our goal is to recognise persistence, motivation and adaptability, thats why we encourage you to dive into these materials and wish you the best of luck in your studies.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.08,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right:
                              (90 / 1440) * MediaQuery.of(context).size.width),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.50,
                        child: const Text(
                          'Once you have gone through all the lessons you ll be able to take a test to show us what you have learned!',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25, fontFamily: 'Outfit'),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),

                    Padding(
                      padding: EdgeInsets.only(
                          left:
                              (400 / 1440) * MediaQuery.of(context).size.width),
                      child: Image.asset('assets/images/homepageqa.png'),
                    ),
                  ]),
                  !showModal ? Container() : const AccountModal(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
