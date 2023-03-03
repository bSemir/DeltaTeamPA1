import 'package:delta_team/home_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common/footer/footer.dart';
import '../../../auth/login/login_mobile/loginmobile_body.dart';
import '../../../onboarding/onboarding_mobile/welcome_page_mobile.dart';

class Onboardingredirecting extends StatefulWidget {
  const Onboardingredirecting({super.key});

  @override
  State<Onboardingredirecting> createState() => _OnboardingredirectingState();
}

class _OnboardingredirectingState extends State<Onboardingredirecting> {
  @override
  void initState() {
    super.initState();
    startTimeout();
  }

  startTimeout() async {
    var duration = const Duration(seconds: 10);
    return Timer(duration, navigateToLogin);
  }

  navigateToLogin() {
    Navigator.pushReplacementNamed(context, LoginScreenMobile.routeName);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: SvgPicture.asset("assets/images/navbar_logo.svg",
            semanticsLabel: 'Confirmation SVG'),
      ),
      backgroundColor: const Color(0xFFF3F3F9),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              const SizedBox(
                height: 245,
              ),
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
              const SizedBox(
                height: 245,
              ),
              const Footer(),
            ])),
      ),
    );
  }
}
