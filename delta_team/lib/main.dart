import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:delta_team/amplifyconfiguration.dart';
import 'package:delta_team/features/auth/loadingScreens/loadingscreen_mobile.dart';
import 'package:delta_team/features/auth/loadingScreens/loadingscreen_web.dart';
import 'package:delta_team/features/auth/login/login_mobile/loginmobile_body.dart';
import 'package:delta_team/features/auth/login/login_web/loginweb_body.dart';
import 'package:delta_team/home_mobile.dart';
import 'package:delta_team/landing_pageweb.dart';
import 'package:flutter/foundation.dart';
import 'package:delta_team/features/auth/signup/provider/auth_provider.dart';
import 'package:delta_team/features/auth/signup/screens/confirmation_screen.dart';
import 'package:delta_team/features/auth/signup/screens/redirecting_screen.dart';
import 'package:delta_team/features/auth/signup/screens/signupScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'features/auth/signup/screens/confirmation_message.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _configureAmplify();
  runApp(const MyApp());
}

Future<void> _configureAmplify() async {
  try {
    final auth = AmplifyAuthCognito();
    await Amplify.addPlugin(auth);
    await Amplify.configure(amplifyconfig);
  } on AmplifyAlreadyConfiguredException catch (e) {
    safePrint('Amplify was already configured: $e');
  } catch (e) {
    safePrint('An error occurred while configuring Amplify: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => MyEmail()),
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
            home: defaultTargetPlatform == TargetPlatform.iOS ||
                    defaultTargetPlatform == TargetPlatform.android
                ? const SignupScreenMobile()
                : const MyDesktopBody(),
            routes: {
              MyMobileBody.routeName: (context) => const MyMobileBody(),
              LandingPage.routeName: (context) => const LandingPage(),
              HomeScreenMobile.routeName: (context) => const HomeScreenMobile(),
              LoadingScreenMobile.routeName: (context) =>
                  const LoadingScreenMobile(),
              LoadingScreenWeb.routeName: (context) => const LoadingScreenWeb(),
              '/signup': (context) => const SignupScreenMobile(),
              '/confirmation': (context) => const ConfirmationScreen(),
              '/confirmationMessage': (context) => const ConfirmationMessage(),
              '/redirectingScreen': (context) => const RedirectingScreen(),
            }));
  }
}
