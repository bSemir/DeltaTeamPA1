import 'package:delta_team/features/auth/signup/signup_mobile/screens/signupScreen_mobile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../features/auth/login/loadingScreens/loadingscreen_mobile.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      height: 55,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(
          left: (30 / 360) * width,
          right: (30 / 360) * width,
          bottom: 8,
        ),
        child: Row(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                key: const Key('routed_to_signupscreen'),
                onTap: () async {
                  Navigator.pushNamed(context, "/signup");
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
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                key: const Key('routed_to_signupscreen'),
                onTap: () async {
                  Navigator.pushNamed(context, "/signup");
                  // Navigate to privacy page
                },
                child: Text(
                  "Terms",
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 142, 142, 142),
                    fontSize: 13.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
