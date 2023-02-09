import 'package:delta_team/home.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class LoadingScreenMobile extends StatefulWidget {
  const LoadingScreenMobile({
    super.key,

    // required this.suffixIcon
  });

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
    var duration = const Duration(seconds: 3);
    return Timer(duration, navigateToHomeScreen);
  }

  navigateToHomeScreen() {
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
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
            SizedBox(
              height: 200,
              width: (200 / 360) * width,
              child: Image.asset('assets/images/logotop.png'),
            ),
            const SizedBox(
              height: 20,
            ),
            const CircularProgressIndicator(
              color: Colors.green,
              semanticsLabel: "we're brewing up",
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingScreenWeb extends StatefulWidget {
  const LoadingScreenWeb({
    super.key,

    // required this.suffixIcon
  });

  @override
  _LoadingScreenWebState createState() => _LoadingScreenWebState();
}

class _LoadingScreenWebState extends State<LoadingScreenMobile> {
  @override
  void initState() {
    super.initState();
    startTimeout();
  }

  startTimeout() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, navigateToHomeScreen);
  }

  navigateToHomeScreen() {
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
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
            CircularProgressIndicator(
              color: Colors.green,
              semanticsLabel: "we're brewing up",
            ),
          ],
        ),
      ),
    );
  }
}
