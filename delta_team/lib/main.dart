import 'package:delta_team/features/onboarding/onboardingScreen.dart';
import 'package:delta_team/features/onboarding/providers/answer.dart';
import 'package:delta_team/features/onboarding/providers/error_provider.dart';
import 'package:delta_team/features/onboarding/providers/provider.dart';
import 'package:delta_team/features/onboarding/providers/role_provider.dart';
import 'package:delta_team/features/onboarding/welcome_page.dart';
import 'package:delta_team/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
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
    ],
    child: const MyApp(),
  ));
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
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        WelcomePage.routeName: (context) => const WelcomePage(),
        OnboardingScreen.routeName: (context) => const OnboardingScreen()
      },
      home: const HomeScreen(),
    );
  }
}
