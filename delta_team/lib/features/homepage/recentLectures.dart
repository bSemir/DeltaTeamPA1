import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:delta_team/features/homepage/homepage_sidebar.dart';
import 'package:delta_team/features/homepage/provider/youtube_link_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../amplifyconfiguration.dart';
import '../auth/login/providers/userLecturesProvider.dart';
import 'account_modal.dart';

class RecentLectures extends StatefulWidget {
  const RecentLectures({super.key});

  @override
  State<RecentLectures> createState() => _RecentLecturesState();
}

class _RecentLecturesState extends State<RecentLectures> {
  @override
  void initState() {
    super.initState();
    // _loadPrefs();
    // getUserLectures();
  }

  bool showModal = false;
  Map<String, dynamic> lectures = {};
  String selectedRole = "";

  Future<void> _loadPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('myMap');
    final role = prefs.getString('role');

    setState(() {
      lectures = jsonDecode(jsonString!);
      selectedRole = role!;
    });
  }

  Future<void> _configureAmplify() async {
    // Add any Amplify plugins you want to use
    final authPlugin = AmplifyAuthCognito();
    final api = AmplifyAPI();
    await Amplify.addPlugins([authPlugin, api]);
    try {
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      safePrint(
          'Tried to reconfigure Amplify; this can occur when your app restarts on Android.');
    }
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
      setState(() {
        lectures = responseMap;
      });
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
    final userLecturesProvider =
        Provider.of<LecturesProvider>(context, listen: false);
    bool removeDescription = false;
    if (MediaQuery.of(context).size.width < 970) {
      removeDescription = true;
    }
    final youtubeProvider =
        Provider.of<YoutubeLinkProvider>(context, listen: false);
    String role = "";
    List<Map<String, dynamic>> lecs = [];
    if (userLecturesProvider.lectures.isNotEmpty) {
      List<dynamic> lecturesList = userLecturesProvider.lectures["lectures"];

      for (int i = 0; i < 3; i++) {
        Map<String, dynamic> lecture = lecturesList[i];

        lecs.add(lecture);
      }
    }

    return Scaffold(
      body: Row(
        children: [
          Container(
              color: Colors.black,
              width: removeDescription
                  ? MediaQuery.of(context).size.width * 0.40
                  : MediaQuery.of(context).size.width * 0.25,
              child: const Sidebar()),
          SizedBox(
            width: removeDescription
                ? MediaQuery.of(context).size.width * 0.60
                : MediaQuery.of(context).size.width * 0.75,
            child: Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Stack(
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
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
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 30,
                            bottom: 30,
                          ),
                          child: !removeDescription
                              ? ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: lecs.length,
                                  itemBuilder: ((context, index) {
                                    return Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.30,
                                                    child: Text(
                                                      "${index + 1}. ${lecs[index]['name']}",
                                                      style: GoogleFonts.outfit(
                                                          fontSize: 32),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 27,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.32,
                                                    child: Text(
                                                      lecs[index]
                                                          ['description'],
                                                      style:
                                                          GoogleFonts.notoSans(
                                                              fontSize: 16),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 100,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Total time: ",
                                                            style: GoogleFonts
                                                                .notoSans(
                                                                    fontSize:
                                                                        16),
                                                          ),
                                                          Text(
                                                            "23:17",
                                                            style: GoogleFonts
                                                                .notoSans(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Remaining time: ",
                                                            style: GoogleFonts
                                                                .notoSans(
                                                                    fontSize:
                                                                        16),
                                                          ),
                                                          Text(
                                                            "12:14",
                                                            style: GoogleFonts
                                                                .notoSans(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Status: ",
                                                            style: GoogleFonts
                                                                .notoSans(
                                                                    fontSize:
                                                                        16),
                                                          ),
                                                          Text(
                                                            "Ongoing",
                                                            style: GoogleFonts
                                                                .notoSans(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              key:
                                                  const Key("lectureVideo_key"),
                                              onTap: () async {
                                                final prefs =
                                                    await SharedPreferences
                                                        .getInstance();

                                                await prefs.setString('title',
                                                    lecs[index]['name']);
                                                await prefs.setInt(
                                                    'index', index);
                                                await prefs.setString(
                                                    'description',
                                                    lecs[index]['description']);
                                                if (lecs[index]
                                                        ['contentLink'] !=
                                                    null) {
                                                  await prefs.setString(
                                                      'ytLink',
                                                      YoutubePlayer
                                                          .convertUrlToId(lecs[
                                                                  index][
                                                              'contentLink'])!);
                                                  youtubeProvider.setLink(
                                                      YoutubePlayer
                                                          .convertUrlToId(lecs[
                                                                  index][
                                                              'contentLink'])!);
                                                }

                                                Navigator.pushNamed(
                                                    context, '/homepagevideo');
                                              },
                                              child: Image.network(
                                                lecs[index]['imageSrc'],
                                                width: 280,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Divider(
                                          color:
                                              Color.fromRGBO(202, 196, 208, 1),
                                        ),
                                      ],
                                    );
                                  }),
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const SizedBox(
                                      height: 60,
                                    );
                                  },
                                )
                              : ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: lecs.length,
                                  itemBuilder: ((context, index) {
                                    return Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.30,
                                                    child: Text(
                                                      "${index + 1}. ${lecs[index]['name']}",
                                                      style: GoogleFonts.outfit(
                                                          fontSize: 32),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 27,
                                                  ),
                                                  InkWell(
                                                    key: const Key(
                                                        "lectureVideo_key"),
                                                    onTap: () async {
                                                      final prefs =
                                                          await SharedPreferences
                                                              .getInstance();

                                                      await prefs.setString(
                                                          'title',
                                                          lecs[index]['name']);
                                                      await prefs.setInt(
                                                          'index', index);
                                                      await prefs.setString(
                                                          'description',
                                                          lecs[index]
                                                              ['description']);
                                                      if (lecs[index]
                                                              ['contentLink'] !=
                                                          null) {
                                                        await prefs.setString(
                                                            'ytLink',
                                                            YoutubePlayer
                                                                .convertUrlToId(
                                                                    lecs[index][
                                                                        'contentLink'])!);
                                                        youtubeProvider.setLink(
                                                            YoutubePlayer
                                                                .convertUrlToId(
                                                                    lecs[index][
                                                                        'contentLink'])!);
                                                      }

                                                      Navigator.pushNamed(
                                                          context,
                                                          '/homepagevideo');
                                                    },
                                                    child: Image.network(
                                                      lecs[index]['imageSrc'],
                                                      width: 280,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 100,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Total time: ",
                                                            style: GoogleFonts
                                                                .notoSans(
                                                                    fontSize:
                                                                        16),
                                                          ),
                                                          Text(
                                                            "23:17",
                                                            style: GoogleFonts
                                                                .notoSans(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Remaining time: ",
                                                            style: GoogleFonts
                                                                .notoSans(
                                                                    fontSize:
                                                                        16),
                                                          ),
                                                          Text(
                                                            "12:14",
                                                            style: GoogleFonts
                                                                .notoSans(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Status: ",
                                                            style: GoogleFonts
                                                                .notoSans(
                                                                    fontSize:
                                                                        16),
                                                          ),
                                                          Text(
                                                            "Ongoing",
                                                            style: GoogleFonts
                                                                .notoSans(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Divider(
                                          color:
                                              Color.fromRGBO(202, 196, 208, 1),
                                        ),
                                      ],
                                    );
                                  }),
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const SizedBox(
                                      height: 60,
                                    );
                                  },
                                ),
                        ),
                      ),
                    ],
                  ),
                  !showModal ? Container() : const AccountModal(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
