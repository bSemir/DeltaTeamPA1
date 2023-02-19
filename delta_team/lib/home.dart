import 'package:delta_team/common/colors.dart';
import 'package:delta_team/features/onboarding/widgets/custom_footer.dart';
import 'package:delta_team/features/onboarding/widgets/custom_navbar.dart';
import 'package:delta_team/features/onboarding/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: AppColors.secondaryColor3,
          title: Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            height: 55,
            child: SvgPicture.asset('assets/images/pa_logo_white.svg'),
          ),
        ),
        body: const WelcomePage(),
        bottomNavigationBar: const CustomFooter(),
      ),
    );
  }
}
