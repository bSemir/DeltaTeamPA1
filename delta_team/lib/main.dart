import 'dart:convert';

import 'package:delta_team/features/auth/login/loginScreen.dart';
import 'package:delta_team/features/onboarding/errorMsg.dart';
import 'package:delta_team/features/onboarding/modelRole.dart';
import 'package:delta_team/features/onboarding/modelRoleWhite.dart';
import 'package:delta_team/features/onboarding/onboardingScreen.dart';
import 'package:delta_team/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/onboarding/modelmyItem.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ErrorMessage()),
        ChangeNotifierProvider(create: (_) => MyItem())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.white),
        home: Onboarding(role: listaRola.first),
      ),
    );
  }
}
