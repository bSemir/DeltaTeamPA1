import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:delta_team/features/Home_welcome_mobile/lectures/single_lecture_screen.dart';
import 'package:delta_team/features/Home_welcome_mobile/lectures/widgets/lecture_card.dart';

import "package:flutter/material.dart";

class LecturesScreen extends StatefulWidget {
  final String role;
  const LecturesScreen({super.key, required this.role});

  @override
  State<LecturesScreen> createState() => _LecturesScreenState();
}

class _LecturesScreenState extends State<LecturesScreen> {
  @override
  void initState() {
    super.initState();
    getUserLectures();
  }

  Map<String, dynamic> lectures = {};
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
      // responseMap.forEach((key, value) {
      //   print("$key: $value");
      // });
      // prin(responseMap.values);
      return responseMap;
    } on ApiException catch (e) {
      throw Exception('Failed to load lectures: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    print(widget.role);
    List<Map<String, dynamic>> lecs = [];
    if (lectures.isNotEmpty) {
      List<dynamic> lecturesList = lectures["lectures"];
      for (int i = 0; i < lecturesList.length; i++) {
        Map<String, dynamic> lecture = lecturesList[i];
        print(lecture);
        dynamic role = lecture['roles'];
        if (role.toString().contains("backend") && widget.role == "backend") {
          lecs.add(lecture);
        }
        if (role.toString().contains("productManager") &&
            widget.role == "productManager") {
          lecs.add(lecture);
        }
        if (role.toString().contains("fullstack") &&
            widget.role == "fullstack") {
          lecs.add(lecture);
        }
        if (role.toString().contains("uiux") && widget.role == "uiux") {
          lecs.add(lecture);
        }
        if (role.toString().contains("qa") && widget.role == "qa") {
          lecs.add(lecture);
        }
      }
    }

    return Scaffold(
      body: lecs.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: lecs.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(top: 12.0, left: 32.0, right: 32.0),
                  child: GestureDetector(
                    onTap: () {
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(
                      //     content: Text('Lesson clicked!'),
                      //   ),
                      // );
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SingleLectureScreen(
                              lectures: lecs[index], index: index),
                        ),
                      );
                    },
                    child: LectureCard(
                      imageSrc: lecs[index]['imageSrc'],
                      name: lecs[index]['name'],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
