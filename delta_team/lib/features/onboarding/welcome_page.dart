import 'package:delta_team/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'onboardingScreen.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: 627,
        color: AppColors.primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 200),
            Expanded(
              flex: 4,
              child: RichText(
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Dobrodošli!\n',
                  style: GoogleFonts.notoSans(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: AppColors.backgroundColor),
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          'Pred Vama je mali upitnik, koji je\nneophodno popuniti kako bi\n nastavili dalje.',
                      style: GoogleFonts.notoSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.backgroundColor),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 202),
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.only(left: 80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Ne zaboravite da odvojite vrijeme i pažljivo\npročitajte svako pitanje. Sretno!',
                      style: GoogleFonts.notoSans(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: AppColors.backgroundColor),
                      textAlign: TextAlign.center,
                    ),
                    MaterialButton(
                      child: SvgPicture.asset(
                          'assets/images/arrow_forward_24px.svg'),
                      // Image.asset('assets/images/arrow_forward_24px.svg'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OnboardingScreen()),
                        );
                      },
                    )
                  ],
                ),
              ),
            )
            // ElevatedButton(
            //   child: const Text(
            //     '-->',
            //     style: TextStyle(color: AppColors.primaryColor),
            //   ),
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => const OnboardingScreen()),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
