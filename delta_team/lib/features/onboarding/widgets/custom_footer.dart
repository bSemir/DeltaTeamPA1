import 'package:delta_team/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.secondaryColor3,
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            height: 70,
            width: 100,
            child: Text(
              key: const Key('PrivacyTextKey'),
              "Privacy",
              style: GoogleFonts.notoSans(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: AppColors.footerColor),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            height: 70,
            width: 190,
            child: Text(
              key: const Key('CreditsTextKey'),
              "© Credits, 2023, Product Arena",
              style: GoogleFonts.notoSans(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: AppColors.footerColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
              alignment: Alignment.center,
              height: 70,
              width: 100,
              child: Text(
                key: const Key('TermsTextKey'),
                "Terms",
                style: GoogleFonts.notoSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: AppColors.footerColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
