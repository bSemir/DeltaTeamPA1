import 'package:delta_team/features/auth/login/loginmobile_body.dart';
import 'package:delta_team/features/auth/login/loginweb_body.dart';
import 'package:delta_team/home.dart';
import 'package:flutter/foundation.dart';
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
        theme: ThemeData(primaryColor: Colors.red),
        home: defaultTargetPlatform == TargetPlatform.iOS ||
                defaultTargetPlatform == TargetPlatform.android
            ? const MyMobileBody()
            : const MyDesktopBody(),
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
        });
  }
}
