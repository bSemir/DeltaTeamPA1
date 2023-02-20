import 'dart:async';

import 'package:delta_team/features/auth/signup/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmationMessage extends StatelessWidget {
  const ConfirmationMessage({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 5),
        () => Navigator.pushNamed(context, "/redirectingScreen"));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: SvgPicture.asset("assets/images/navbar_logo.svg",
            semanticsLabel: 'Confirmation SVG'),
      ),
      body: Container(
        color: const Color.fromRGBO(243, 243, 249, 1),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 123,
              ),
              SvgPicture.asset("assets/images/check_circle.svg",
                  semanticsLabel: 'Confirmation SVG'),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Email Verified",
                style: GoogleFonts.outfit(
                  fontSize: 32,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                "Your email is successfully verified",
                style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromRGBO(96, 93, 102, 1)),
              ),
              const SizedBox(
                height: 246,
              ),
              SvgPicture.asset("assets/images/footer_logo.svg",
                  semanticsLabel: 'Confirmation SVG'),
              const SizedBox(
                height: 36,
              ),
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
