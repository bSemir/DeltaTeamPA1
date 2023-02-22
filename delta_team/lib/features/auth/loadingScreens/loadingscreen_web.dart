import 'package:delta_team/home_mobile.dart';
import 'package:delta_team/home_web.dart';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:google_fonts/google_fonts.dart';

class LoadingScreenWeb extends StatefulWidget {
  static const routeName = '/loadingweb';
  const LoadingScreenWeb({
    super.key,

    // required this.suffixIcon
  });

  @override
  _LoadingScreenWebState createState() => _LoadingScreenWebState();
}

class _LoadingScreenWebState extends State<LoadingScreenWeb> {
  @override
  void initState() {
    super.initState();
    startTimeout();
  }

  startTimeout() async {
    var duration = const Duration(seconds: 20);
    return Timer(duration, navigateToHomeScreen);
  }

  navigateToHomeScreen() {
    Navigator.pushReplacementNamed(context, HomeScreenWeb.routeName);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // SizedBox(
            //   height: 200,
            //   width: (200 / 1440) * width,
            //   child: Image.asset('assets/your_logo.png'),
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            const SizedBox(
              width: 150,
              height: 150,
              child: CircularProgressIndicator(
                backgroundColor: Color(0xFFFF4086),
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF22E974)),
                strokeWidth: 25.0,
              ),
            ),
            const SizedBox(height: 25),
            Text(
              "Loading...",
              style: GoogleFonts.notoSans(
                fontWeight: FontWeight.w400,
                color: const Color(0xFF000000),
                fontSize: 48.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
