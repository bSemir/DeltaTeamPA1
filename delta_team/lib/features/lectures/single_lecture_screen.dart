import 'package:delta_team/common/colors.dart';
import 'package:delta_team/features/lectures/providers/lectures_provider_mobile.dart';
import 'package:delta_team/features/lectures/widgets/lecture_indicator.dart';
import 'package:delta_team/features/lectures/widgets/lecture_video.dart';
import 'package:delta_team/features/onboarding/onboarding_mobile/mobile_widgets/form_buttons_mobile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SingleLectureScreen extends StatefulWidget {
  const SingleLectureScreen({super.key});

  @override
  State<SingleLectureScreen> createState() => _SingleLectureScreenState();
}

class _SingleLectureScreenState extends State<SingleLectureScreen> {
  final PageController pageController = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    var provider = Provider.of<LectureListProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            children: [
              // Lesson Indicator
              Expanded(
                  flex: 1,
                  child: LectureIndicator(
                    currentPage: currentIndex + 1,
                    lenght: provider.lectures.length,
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: SizedBox(
                  height: mediaQuery.height * 0.70,
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: provider.lectures.length,
                    onPageChanged: (index) {
                      setState(
                        () {
                          currentIndex = index;
                        },
                      );
                    },
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      final lecture = provider.lectures[index];
                      final name = lecture['name'];
                      final description = lecture['description'];
                      final contentLink = lecture['contentLink'];

                      return Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.only(top: 22.0),
                            child: Text(
                              '${index + 1}. ' + name,
                              style: GoogleFonts.notoSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF000000),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: LectureVideo(contentLink: contentLink),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 18),
                            child: Text(
                              description,
                              style: GoogleFonts.notoSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF000000),
                              ),
                            ),
                          )
                        ],
                      );
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
                      currentIndex == provider.lectures.length - 1
                          ? const SizedBox(height: 0, width: 0)
                          : FormButton(
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
