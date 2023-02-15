import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

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
          const SizedBox(
            height: 26,
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
