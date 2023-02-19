import 'package:delta_team/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Container(
      padding: const EdgeInsets.all(2.0),
      width: double.infinity,
      height: mediaQuery.size.height * 0.08,
      color: AppColors.secondaryColor3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.only(top: 10.0),
              alignment: Alignment.topCenter,
              height: mediaQuery.size.height * 0.20,
              width: mediaQuery.size.width * 0.18,
              child: Text(
                key: const Key('PrivacyTextKey'),
                "Privacy",
                style: GoogleFonts.notoSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: AppColors.footerColor),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              padding: const EdgeInsets.all(10.0),
              alignment: Alignment.bottomCenter,
              height: mediaQuery.size.height * 0.13,
              width: mediaQuery.size.width * 0.50,
              child: Text(
                key: const Key('CreditsTextKey'),
                "© Credits, 2023, Product Arena",
                style: GoogleFonts.notoSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: AppColors.footerColor),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                alignment: Alignment.topCenter,
                height: mediaQuery.size.height * 0.10,
                width: mediaQuery.size.width * 0.18,
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
          ),
        ],
      ),
    );
  }
}
