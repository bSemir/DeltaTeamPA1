import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:delta_team/amplifyconfiguration.dart';
import 'package:delta_team/features/auth/loadingScreens/loadingscreen_mobile.dart';
import 'package:delta_team/features/auth/loadingScreens/loadingscreen_web.dart';
import 'package:delta_team/features/auth/login/login_mobile/loginmobile_body.dart';
import 'package:delta_team/features/auth/login/login_web/loginweb_body.dart';

import 'package:delta_team/features/auth/signup/signup_web/Web_emailVerified_screen.dart';
import 'package:delta_team/features/auth/signup/signup_web/Web_loadingPage.dart';
import 'package:delta_team/features/auth/signup/signup_web/Web_signupScreen.dart';
import 'package:delta_team/features/auth/signup/signup_web/Web_signupVerification_Screen.dart';

import 'package:delta_team/features/onboarding_web/onboardingScreen.dart';
import 'package:delta_team/home_mobile.dart';
import 'package:delta_team/home_web.dart';

import 'package:flutter/foundation.dart';
import 'package:delta_team/features/auth/signup/provider/auth_provider_mobile.dart';
import 'package:delta_team/features/auth/signup/provider/Web_auth_provider.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'features/auth/signup_mobile/screens/confirmation_message_mobile.dart';
import 'features/auth/signup_mobile/screens/confirmation_screen_mobile.dart';
import 'features/auth/signup_mobile/screens/redirecting_screen_mobile.dart';
import 'features/auth/signup_mobile/screens/signupScreen_mobile.dart';
import 'features/onboarding/onboarding_mobile/mobile_providers/answer_mobile.dart';
import 'features/onboarding/onboarding_mobile/mobile_providers/error_provider_mobile.dart';
import 'features/onboarding/onboarding_mobile/mobile_providers/provider_mobile.dart';
import 'features/onboarding/onboarding_mobile/mobile_providers/role_provider_mobile.dart';
import 'features/onboarding/onboarding_mobile/onboarding_screen_mobile.dart';
import 'features/onboarding/onboarding_mobile/welcome_page_mobile.dart';
import 'features/onboarding_web/errorMsg-web.dart';
import 'features/onboarding_web/modelRole.dart';
import 'features/onboarding_web/modelmyItem.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => MyEmailWeb()),
          ChangeNotifierProvider(create: (_) => MyEmail()),
          ChangeNotifierProvider<MyProvider>(
            create: (_) => MyProvider(),
          ),
          ChangeNotifierProvider<AnswerProvider>(
            create: (_) => AnswerProvider(),
          ),
          ChangeNotifierProvider<ErrorMessage>(
            create: (_) => ErrorMessage(),
          ),
          ChangeNotifierProvider<MyItem>(
            create: (_) => MyItem(),
          ),
          ChangeNotifierProvider(create: (_) => ErrorMessageWeb()),
          ChangeNotifierProvider(create: (_) => MyItemWeb())
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
                : const SignUpScreenWeb(),
            routes: {
              LoginScreenWeb.routeName: (context) => const LoginScreenWeb(),
              LoginScreenMobile.routeName: (context) =>
                  const LoginScreenMobile(),
              HomeScreenWeb.routeName: (context) => const HomeScreenWeb(),
              HomeScreenMobile.routeName: (context) => const HomeScreenMobile(),
              LoadingScreenMobile.routeName: (context) =>
                  const LoadingScreenMobile(),
              LoadingScreenWeb.routeName: (context) => const LoadingScreenWeb(),
              '/signup': (context) => const SignupScreenMobile(),
              '/confirmation': (context) => const ConfirmationScreen(),
              '/confirmationMessage': (context) => const ConfirmationMessage(),
              '/redirectingScreen': (context) => const RedirectingScreen(),
              WelcomePage.routeName: (context) => const WelcomePage(),
              OnboardingScreen.routeName: (context) => const OnboardingScreen(),
              OnboardingWeb.routeName: (context) => OnboardingWeb(
                    role: listaRola.first,
                  ),
              '/signupWeb': (context) => const SignUpScreenWeb(),
              '/confirmationWeb': (context) => const SignupVerificationScreen(),
              '/confirmationMessageWeb': (context) =>
                  const EmailVerifiedScreen(),
              '/loadingPage': (context) => const LoadingPage()
            }));
  }
}
