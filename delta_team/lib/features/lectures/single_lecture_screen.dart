import 'package:delta_team/common/colors.dart';
import 'package:delta_team/features/lectures/widgets/detailed_lecture.dart';
import 'package:delta_team/features/lectures/widgets/lecture_indicator.dart';
import 'package:delta_team/features/onboarding/onboarding_mobile/mobile_widgets/form_buttons_mobile.dart';
import 'package:flutter/material.dart';

class SingleLectureScreen extends StatefulWidget {
  final Map<String, dynamic> lectures;
  final int index;

  const SingleLectureScreen({
    super.key,
    required this.lectures,
    required this.index,
  });

  @override
  State<SingleLectureScreen> createState() => _SingleLectureScreenState();
}

class _SingleLectureScreenState extends State<SingleLectureScreen> {
  final PageController pageController = PageController();
  @override
  void initState() {
    super.initState();
    // getUserLectures();
  }

  int currentIndex = 0;
  // Map<String, dynamic> lectures = {};

  // Future<Map<String, dynamic>> getUserLectures() async {
  //   // signInUser();
  //   try {
  //     final restOperation = Amplify.API.get('/api/user/lectures',
  //         apiName: 'getUserLectures',
  //         queryParameters: {
  //           'paDate': 'Jan2023'
  //           // , 'name': 'Flutter widgets'
  //         });
  //     final response = await restOperation.response;
  //     Map<String, dynamic> responseMap = jsonDecode(response.decodeBody());
  //     setState(() {
  //       lectures = responseMap;
  //     });
  //     // responseMap.forEach((key, value) {
  //     //   print("$key: $value");
  //     // });
  //     // prin(responseMap.values);
  //     print(responseMap);
  //     print(lectures);
  //     return responseMap;
  //   } on ApiException catch (e) {
  //     throw Exception('Failed to load lectures: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            children: [
              Expanded(
                  flex: 1,
                  child: LectureIndicator(
                    currentPage: currentIndex + 1,
                    lenght: widget.lectures.length,
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: widget.lectures.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                        height: mediaQuery.height * 0.90,
                        child: PageView.builder(
                          controller: pageController,
                          itemCount: widget.lectures.length,
                          onPageChanged: (index) {
                            setState(
                              () {
                                currentIndex = index;
                              },
                            );
                          },
                          //     itemBuilder: (BuildContext context, int index) {
                          //   return pages[index % pages.length];
                          // },
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return DetailedLecture(
                              name: widget.lectures['name'],
                              contentLink: widget.lectures['contentLink'],
                              description: widget.lectures['description'],
                              index: widget.index,
                            );

                            // return Column(
                            //   children: [
                            //     Container(
                            //       alignment: Alignment.topLeft,
                            //       padding: const EdgeInsets.only(top: 22.0),
                            //       child: Text(
                            //         '${widget.index + 1}. ' +
                            //             widget.lectures['name'],
                            //         style: GoogleFonts.notoSans(
                            //           fontSize: 16,
                            //           fontWeight: FontWeight.w700,
                            //           color: const Color(0xFF000000),
                            //         ),
                            //       ),
                            //     ),
                            //     Padding(
                            //       padding: const EdgeInsets.only(top: 16),
                            //       child: LectureVideo(
                            //           contentLink:
                            //               widget.lectures['contentLink']),
                            //     ),
                            //     Container(
                            //       padding: const EdgeInsets.only(top: 18),
                            //       child: Text(
                            //         widget.lectures['description'],
                            //         style: GoogleFonts.notoSans(
                            //           fontSize: 14,
                            //           fontWeight: FontWeight.w400,
                            //           color: const Color(0xFF000000),
                            //         ),
                            //       ),
                            //     )
                            //   ],
                            // );
                          },
                        ),
                      ),
              ),
              Container(
                alignment: const Alignment(0, 0.80),
                child: Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      currentIndex == 0
                          ? const SizedBox(height: 0, width: 0)
                          : FormButton(
                              backgroundColor: AppColors.secondaryColor3,
                              textColor: AppColors.primaryColor,
                              text: 'Back',
                              borderColor: AppColors.primaryColor,
                              onPressed: () {
                                pageController.previousPage(
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeIn);
                              },
                              buttonWidth: 100,
                              buttonHeight: 42,
                            ),
                      // currentIndex == lectures.length - 1
                      //     ? const SizedBox(height: 0, width: 0)
                      //     :
                      FormButton(
                        backgroundColor: AppColors.primaryColor,
                        textColor: AppColors.secondaryColor3,
                        text: 'Next',
                        borderColor: AppColors.primaryColor,
                        onPressed: () {
                          pageController.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeIn);
                        },
                        buttonWidth: 100,
                        buttonHeight: 42,
                      )
                    ],
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
