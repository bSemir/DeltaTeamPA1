import 'package:delta_team/features/auth/signup/signupScreen.dart';
import 'package:delta_team/features/auth/signup/signupVerification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final Size screenSize = MediaQuery.of(context).size;
    // final double defaultHeight = screenSize.height / 10;
    // final double defaultWidth = screenSize.width / 5;
    //return LayoutBuilder(
    //builder: (context, constraints) {
    return Scaffold(
      body: Container(
        // height: defaultHeight * 10,
        // width: defaultWidth * 5,
        // child: SingleChildScrollView(child: SignupScreen()),
        child: SingleChildScrollView(child: SignupScreen()),
      ),
      // child: SignupScreen(),
    );

    // },
    //);
  }
}
