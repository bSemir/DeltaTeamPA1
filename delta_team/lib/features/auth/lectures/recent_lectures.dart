import 'package:delta_team/features/auth/lectures/providers/lectures_provider_mobile.dart';
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
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
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
              ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  final lecture = provider.lectures[index];
                  final name = lecture['name'];
                  final image = lecture['imageSrc'];
                  return Container(
                    color: Colors.amber,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(color: Colors.black, width: 0.5)),
                    child: Column(
                      children: [
                        //Video Player
                        Container(
                          width: mediaQuery.width * 0.4,
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(
                            left: 7,
                            top: 5,
                          ),
                          child: Text(
                            'name',
                            maxLines: 2,
                            textDirection: TextDirection.ltr,
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
