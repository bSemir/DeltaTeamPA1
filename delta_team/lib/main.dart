import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:delta_team/features/auth/signup/emailVerified_screen.dart';
import 'package:delta_team/features/auth/signup/loadingPage.dart';
import 'package:delta_team/features/auth/signup/signupScreen.dart';
import 'package:delta_team/features/auth/signup/signupVerification_Screen.dart';
import 'package:delta_team/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'amplifyconfiguration.dart';
import 'features/auth/signup/provider/auth_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyEmail()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  Future<void> _configureAmplify() async {
    try {
      final auth = AmplifyAuthCognito();
      await Amplify.addPlugin(auth);

      // call Amplify.configure to use the initialized categories in your app
      await Amplify.configure(amplifyconfig);
    } on Exception catch (e) {
      safePrint('An error occurred configuring Amplify: $e');
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(
          errorStyle: GoogleFonts.notoSans(
            fontSize: 10,
            color: const Color.fromRGBO(179, 38, 30, 1),
            fontWeight: FontWeight.w400,
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(179, 38, 30, 1),
            ),
          ),
        ),
      ),
      home: HomeScreen(),
      routes: {
        '/signup': (context) => const SignupScreen(),
        '/confirmation': (context) => const SignupVerificationScreen(),
        '/confirmationMessage': (context) => const EmailVerifiedScreen(),
        '/loadingPage': (context) => const LoadingPage(),
      },
    );
  }
}
