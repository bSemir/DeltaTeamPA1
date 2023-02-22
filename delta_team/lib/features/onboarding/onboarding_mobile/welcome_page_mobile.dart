import 'package:delta_team/common/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'mobile_widgets/custom_footer_mobile.dart';
import 'onboarding_screen_mobile.dart';

class WelcomePage extends StatefulWidget {
  static const routeName = 'welcome-screen';

  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.secondaryColor3,
        title: Container(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          height: 55,
          child: SvgPicture.asset('assets/images/pa_logo_white.svg'),
        ),
      ),
      body: Container(
        height: mediaQuery.size.height * 0.82,
        width: double.infinity,
        color: AppColors.primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: mediaQuery.size.height * 0.16,
            ),
            RichText(
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
            SizedBox(
              height: mediaQuery.size.height * 0.16,
            ),
            Container(
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
                    key: const Key('NavigateToOnboardingButtonKey'),
                    child: SvgPicture.asset(
                        'assets/images/arrow_forward_24px.svg'),
                    // Image.asset('assets/images/arrow_forward_24px.svg'),
                    onPressed: () {
                      Navigator.pushNamed(context, OnboardingScreen.routeName);
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const CustomFooter(),
    );
  }
}
