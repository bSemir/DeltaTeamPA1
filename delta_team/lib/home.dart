import 'package:delta_team/features/onboarding/widgets/custom_footer.dart';
import 'package:delta_team/features/onboarding/widgets/custom_navbar.dart';
import 'package:delta_team/features/onboarding/welcome_page.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const [
            CustomNavbar(),
            WelcomePage(),
            CustomFooter(),
          ],
        ),
      ),
    );
  }
}
