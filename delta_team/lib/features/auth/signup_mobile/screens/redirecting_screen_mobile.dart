import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';

import '../../../onboarding/onboarding_mobile/welcome_page_mobile.dart';

class RedirectingScreen extends StatefulWidget {
  const RedirectingScreen({super.key});

  @override
  State<RedirectingScreen> createState() => _RedirectingScreenState();
}

class _RedirectingScreenState extends State<RedirectingScreen> {
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
    Navigator.pushReplacementNamed(context, WelcomePage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
            const SizedBox(
              height: 80,
            ),
            SizedBox(
              height: 61.26,
              width: (80 / 360) * width,
              child: Image.asset('assets/images/footer_logo.png'),
            ),
            const SizedBox(
              height: 154.74,
            ),
            Stack(alignment: Alignment.center, children: [
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 65, right: 0, bottom: 0, left: 0),
                    child: Column(
                      children: [
                        const SizedBox(height: 5),
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
                            text: "brewing up...",
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
              ),
              SizedBox(
                width: (150 / 360) * width,
                height: 150,
                child: const CircularProgressIndicator(
                  backgroundColor: Color(0xffffffff),
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(255, 44, 250, 51)),
                  strokeWidth: 13.0,
                ),
              ),
            ]),
            Column()
          ])),
    );
  }
}
