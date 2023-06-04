import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:delta_team/features/auth/login/providers/userAttributesProvider.dart';
import 'package:delta_team/home_mobile.dart';

import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/auth/login/loadingScreens/loadingscreen_mobile.dart';
import 'features/auth/login/loadingScreens/loadingscreen_web.dart';
import 'features/auth/login/login_mobile/loginmobile_body.dart';
import 'features/auth/login/providers/userLecturesProvider.dart';
import 'features/auth/signup/provider/Web_auth_provider.dart';
import 'features/auth/signup/provider/auth_provider_mobile.dart';
import 'features/auth/signup/signup_mobile/screens/confirmation_message_mobile.dart';
import 'features/auth/signup/signup_mobile/screens/confirmation_screen_mobile.dart';
import 'features/auth/signup/signup_mobile/screens/redirecting_screen_mobile.dart';
import 'features/auth/signup/signup_mobile/screens/signupScreen_mobile.dart';
import 'features/onboarding_web/provider/emailPasswProvider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
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
    _loadPrefs();
  }

  dynamic token = '';
  bool isLoggedIn = false;

  Future<void> _loadPrefs() async {
    dynamic tokenStr = await FlutterSession().get("token");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool log = prefs.getBool("isLoggedIn")!;

    setState(() {
      token = tokenStr;
      isLoggedIn = log;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyEmailWeb()),
        ChangeNotifierProvider(create: (_) => MyEmail()),
        ChangeNotifierProvider(
          create: (_) => EmailPasswordProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LecturesProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserAttributesProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
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
        home: const SignupScreenMobile(),

        // LoginScreenWeb(),
        routes: {
          LoginScreenMobile.routeName: (context) => const LoginScreenMobile(),
          HomeScreenMobile.routeName: (context) => const HomeScreenMobile(),
          LoadingScreenMobile.routeName: (context) =>
              const LoadingScreenMobile(),
          '/loadingScreenWeb': (context) => const LoadingScreenWeb(),
          '/signup': (context) => const SignupScreenMobile(),
          '/confirmation': (context) => const ConfirmationScreen(),
          '/confirmationMessage': (context) => const ConfirmationMessage(),
          '/redirectingScreen': (context) => const RedirectingScreen(),
        },
      ),
    );
  }
}
