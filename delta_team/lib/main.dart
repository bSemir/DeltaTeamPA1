import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:delta_team/amplifyconfiguration.dart';
import 'package:delta_team/features/auth/loadingScreens/loading_Screen.dart';
import 'package:delta_team/features/auth/loadingScreens/loadingscreen_web.dart';
import 'package:delta_team/features/auth/login/login_mobile/loginmobile_body.dart';
import 'package:delta_team/features/auth/login/login_web/loginweb_body.dart';
import 'package:delta_team/home_mobile.dart';
import 'package:delta_team/home_web.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _configureAmplify();
  runApp(const MyApp());
}

Future<void> _configureAmplify() async {
  try {
    final amplifyAuthCognito = AmplifyAuthCognito();
    await Amplify.addPlugins([amplifyAuthCognito]);

    await Amplify.configure(amplifyconfig);
  } catch (e) {
    safePrint('An error occurred while configuring Amplify: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.red),
        home: defaultTargetPlatform == TargetPlatform.iOS ||
                defaultTargetPlatform == TargetPlatform.android
            ? const MyMobileBody()
            : const MyDesktopBody(),
        routes: {
          HomeScreenWeb.routeName: (context) => const HomeScreenWeb(),
          HomeScreenMobile.routeName: (context) => const HomeScreenMobile(),
          LoadingScreenMobile.routeName: (context) =>
              const LoadingScreenMobile(),
          LoadingScreenWeb.routeName: (context) => const LoadingScreenWeb(),
        });
  }
}
