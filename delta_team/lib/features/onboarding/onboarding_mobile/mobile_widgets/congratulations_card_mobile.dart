import 'dart:async';

import 'package:flutter/material.dart';

class CongratsCard extends StatelessWidget {
  static const routeName = 'congrate';
  const CongratsCard({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 5),
        () => Navigator.pushNamed(context, "/OnboardingredirectingScreen"));
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('name'),
          const Text('Congratulations'),
          const Text('You’ve successfully created an account'),
        ],
      ),
    );
  }
}
