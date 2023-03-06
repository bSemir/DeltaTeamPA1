import 'dart:async';

import 'package:delta_team/features/auth/signup/signup_mobile/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../login/loadingScreens/loadingscreen_mobile.dart';

class ConfirmationMessage extends StatelessWidget {
  const ConfirmationMessage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFFE9E9E9),
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
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 55,
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: (30 / 360) * width,
                          right: (30 / 360) * width,
                          bottom: 8),
                      child: Row(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              key: const Key('routed_to_loadingScreen'),
                              onTap: () async {
                                Navigator.pushNamed(
                                    context, LoadingScreenMobile.routeName);
                                // Navigate to privacy page
                              },
                              child: Text(
                                "Privacy",
                                style: GoogleFonts.notoSans(
                                  fontWeight: FontWeight.w400,
                                  color:
                                      const Color.fromARGB(255, 142, 142, 142),
                                  fontSize: 13.0,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                "© Credits, 2023, Product Arena",
                                style: GoogleFonts.notoSans(
                                    fontWeight: FontWeight.w400,
                                    color: const Color.fromARGB(
                                        255, 142, 142, 142),
                                    fontSize: 12.0),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              key: const Key('routed_to_LoadingScreen'),
                              onTap: () async {
                                Navigator.pushNamed(
                                    context, LoadingScreenMobile.routeName);
                                // Navigate to privacy page
                              },
                              child: Text(
                                "Terms",
                                style: GoogleFonts.notoSans(
                                    fontWeight: FontWeight.w400,
                                    color: const Color.fromARGB(
                                        255, 142, 142, 142),
                                    fontSize: 13.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
