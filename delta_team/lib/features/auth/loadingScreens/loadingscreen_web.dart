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
          children: const <Widget>[
            // SizedBox(
            //   height: 200,
            //   width: (200 / 1440) * width,
            //   child: Image.asset('assets/your_logo.png'),
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            SizedBox(
              width: 98,
              height: 98,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Color.fromARGB(255, 44, 250, 51)),
                strokeWidth: 13.0,
              ),
            ),
            SizedBox(height: 20),
            Text("Loading...",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w700))
          ],
        ),
      ),
    );
  }
}
