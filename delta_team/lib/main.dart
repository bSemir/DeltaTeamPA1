import 'package:delta_team/features/auth/signup/screens/ConfirmationMessage.dart';
import 'package:delta_team/features/auth/signup/screens/confirmation_screen.dart';
import 'package:delta_team/features/auth/signup/screens/signupScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignupScreen(),
      routes: {
        '/signup': (context) => const SignupScreen(),
        '/confirmation': (context) => const ConfirmationScreen(),
        '/confirmationMessage': (context) => const ConfirmationMessage(),
      },
    );
  }
}
