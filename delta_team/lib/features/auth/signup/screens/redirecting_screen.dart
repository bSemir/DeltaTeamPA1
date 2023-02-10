import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RedirectingScreen extends StatefulWidget {
  const RedirectingScreen({super.key});

  @override
  State<RedirectingScreen> createState() => _RedirectingScreenState();
}

class _RedirectingScreenState extends State<RedirectingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(243, 243, 249, 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset("assets/images/redirecting_logo.png"),
          const SpinKitRing(
            color: Color.fromRGBO(34, 233, 116, 1),
            size: 120.0,
            lineWidth: 14,
          ),
          Container(),
        ],
      ),
    );
  }
}
