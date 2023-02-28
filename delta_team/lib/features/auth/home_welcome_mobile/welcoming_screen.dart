import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../loadingScreens/loadingscreen_mobile.dart';

class WelcomingScreen extends StatelessWidget {
  const WelcomingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(children: <Widget>[
      Container(
        color: Color.fromRGBO(238, 233, 233, 1),
        child: Center(
          child: Column(
            key: const Key('home_welcome_mesagge'),
            children: [
              const SizedBox(
                height: 60,
              ),
              SvgPicture.asset("assets/images/UX.svg"),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Welcome to",
                style: TextStyle(fontSize: 32),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Product Arena",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Our goal is to recognise persistence,\nmotivation and adaptability, that’s why we\n encourage you to dive into these materials\n and wish you the best of luck in your\n studies.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Once you have gone through all the lessons\n you'll be able to take a test to show us what\n you have learned!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(
                height: 108,
              ),
              Container(
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
                              color: const Color.fromARGB(255, 142, 142, 142),
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
                                color: const Color.fromARGB(255, 142, 142, 142),
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
                                color: const Color.fromARGB(255, 142, 142, 142),
                                fontSize: 13.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
