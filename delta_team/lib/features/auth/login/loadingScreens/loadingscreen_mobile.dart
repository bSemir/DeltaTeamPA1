import 'package:delta_team/home_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';

import '../../../Home_welcome_mobile/welcoming_message_screen.dart';

class LoadingScreenMobile extends StatefulWidget {
  static const routeName = '/loadingscreen';
  const LoadingScreenMobile({super.key});

  @override
  State<LoadingScreenMobile> createState() => _LoadingScreenMobileState();
}

class _LoadingScreenMobileState extends State<LoadingScreenMobile> {
  @override
  void initState() {
    super.initState();
    startTimeout();
  }

  startTimeout() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, navigateToHomeScreen);
  }

  navigateToHomeScreen() {
    Navigator.pushReplacementNamed(context, WelcomingScreen.routeName2);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
            const SizedBox(
              height: 74.9,
            ),
            SizedBox(
              height: 61.26,
              width: (80 / 360) * width,
              child: SvgPicture.asset('assets/images/footer_logo.svg'),
            ),
            const SizedBox(height: 138.74),
            Stack(alignment: Alignment.center, children: [
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // const SizedBox(height: 5),
                      RichText(
                        text: TextSpan(
                          text: "We're",
                          style: GoogleFonts.notoSans(
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF000000),
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: "brewing up",
                          style: GoogleFonts.notoSans(
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF000000),
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 150,
                height: 150,
                child: CircularProgressIndicator(
                  backgroundColor: Color(0xffffffff),
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(255, 44, 250, 51)),
                  strokeWidth: 13.0,
                ),
              ),
            ]),
          ])),
    );
  }
}
