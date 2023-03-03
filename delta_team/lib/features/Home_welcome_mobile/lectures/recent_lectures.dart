import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:delta_team/features/Home_welcome_mobile/lectures/providers/lectures_provider_mobile.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RecentLectures extends StatefulWidget {
  const RecentLectures({super.key});

  @override
  State<RecentLectures> createState() => _RecentLecturesState();
}

class _RecentLecturesState extends State<RecentLectures> {
  @override
  void initState() {
    super.initState();
    getUserLectures();
    print("recent" + recentLectures.toString());
    print("recent" + lectures.toString());
  }

  List recentLectures = [];
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

      // responseMap.forEach((key, value) {
      //   print("$key: $value");
      // });
      // prin(responseMap.values);

      setState(() {
        lectures = responseMap;
      });
      return responseMap;
    } on ApiException catch (e) {
      throw Exception('Failed to load lectures: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    String role = "";
    List<Map<String, dynamic>> lecs = [];
    if (lectures.isNotEmpty) {
      List<dynamic> lecturesList = lectures["lectures"];
      for (int i = 0; i < 3; i++) {
        Map<String, dynamic> lecture = lecturesList[i];
        lecs.add(lecture);
      }
    }
    print(lectures.toString());
    print(recentLectures.toString());
    print(lecs.toString());
    var provider = Provider.of<LectureListProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 12.0),
          child: Column(
            children: [
              Text(
                'Recent Lessons',
                style: GoogleFonts.notoSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF000000),
                ),
              ),
              lectures.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: lecs.length,
                      itemBuilder: (BuildContext context, int index) {
                        // final lectures = lecs[index];
                        // final name = lectures['name'];
                        // final image = lectures['imageSrc'];
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              border:
                                  Border.all(color: Colors.black, width: 0.5)),
                          child: Column(
                            children: [
                              //Video Player
                              SizedBox(
                                width: mediaQuery.width * 0.8,
                                height: mediaQuery.height * 0.2,
                                child: Image.network(
                                  lecs[index]['imageSrc'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                width: mediaQuery.width * 0.4,
                                alignment: Alignment.topLeft,
                                padding: const EdgeInsets.only(
                                  left: 7,
                                  top: 5,
                                ),
                                child: Text(
                                  lecs[index]['name'],
                                  maxLines: 2,
                                  overflow: TextOverflow.clip,
                                  style: GoogleFonts.notoSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF000000),
                                  ),
                                ),
                              ),
                              Container(
                                width: mediaQuery.width * 0.1,
                                alignment: Alignment.topRight,
                                padding: const EdgeInsets.only(
                                  left: 7,
                                  top: 5,
                                ),
                                child: SvgPicture.asset(
                                    'assets/images/arrow_lecture.svg'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
