import 'dart:async';

import 'package:delta_team/home_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingPageOnboarding extends StatefulWidget {
  const LoadingPageOnboarding({super.key});

  @override
  State<LoadingPageOnboarding> createState() => _LoadingPageOnboardingState();
}

class _LoadingPageOnboardingState extends State<LoadingPageOnboarding> {
  @override
  void initState() {
    super.initState();
    startTimeout();
  }

  startTimeout() async {
    var duration = const Duration(seconds: 10);
    return Timer(duration, navigateToHome);
  }

  navigateToHome() {
    Navigator.pushNamed(context, "/homeweb");
  }

  @override
  Widget build(BuildContext context) {
    double ringSize = 150.0;
    double fontSize = 48;

    if (MediaQuery.of(context).size.width < 900) {
      ringSize = 120;
    }

    if (MediaQuery.of(context).size.width < 400) {
      fontSize = 36;
    }

    return Container(
      color: const Color.fromRGBO(255, 255, 255, 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SpinKitRing(
            color: const Color.fromRGBO(34, 233, 116, 1),
            size: ringSize,
            lineWidth: 14,
          ),
          Text(
            "Loading...",
            style: GoogleFonts.notoSans(
                fontSize: fontSize,
                decoration: TextDecoration.none,
                color: Colors.black,
                fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
