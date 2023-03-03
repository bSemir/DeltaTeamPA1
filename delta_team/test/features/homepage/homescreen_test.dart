import 'package:delta_team/features/auth/login/login_web/loginform_web.dart';
import 'package:delta_team/features/auth/login/providers/userAttributesProvider.dart';
import 'package:delta_team/features/auth/login/providers/userLecturesProvider.dart';
import 'package:delta_team/features/auth/signup/provider/Web_auth_provider.dart';
import 'package:delta_team/features/homepage/contact_me_screen.dart';
import 'package:delta_team/features/homepage/homepage.dart';
import 'package:delta_team/features/homepage/homepage_sidebar.dart';
import 'package:delta_team/features/homepage/homepage_video_screen.dart';
import 'package:delta_team/features/homepage/homescreen.dart';
import 'package:delta_team/features/homepage/lectures.dart';
import 'package:delta_team/features/homepage/provider/selectedRoleProvider.dart';
import 'package:delta_team/features/homepage/recentLectures.dart';
import 'package:delta_team/features/onboarding_web/provider/emailPasswProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

late MyEmailWeb myEmailWeb;
late UserAttributesProvider userAttributesProvider;
late EmailPasswordProvider emailPasswordProvider;
late LecturesProvider lecturesProvider;
late SelectedRoleProvider selectedRoleProvider;

Widget createLoginScreenWeb() => MultiProvider(
      providers: [
        ChangeNotifierProvider<UserAttributesProvider>(create: (contex) {
          userAttributesProvider = UserAttributesProvider();
          return userAttributesProvider;
        }),
        ChangeNotifierProvider<LecturesProvider>(create: (contex) {
          lecturesProvider = LecturesProvider();
          return lecturesProvider;
        }),
        ChangeNotifierProvider<MyEmailWeb>(create: (contex) {
          myEmailWeb = MyEmailWeb();
          return myEmailWeb;
        }),
        ChangeNotifierProvider<SelectedRoleProvider>(create: (contex) {
          selectedRoleProvider = SelectedRoleProvider();
          return selectedRoleProvider;
        }),
      ],
      child: MaterialApp(
        routes: {
          '/homepage': (context) => const HomePage(),
          '/lecturesPage': (context) => const LecturesPage(),
          '/homepagevideo': (context) => const HomePageVideoScreen(),
          '/contactUs': (context) => const ContactMeScreen(),
          '/recentLectures': (context) => const RecentLectures(),
          '/homescreen': (context) => const HomeScreen(),
        },
        home: const LoginField(),
      ),
    );

Widget createHomeScreenWeb() => MultiProvider(
      providers: [
        ChangeNotifierProvider<UserAttributesProvider>(create: (contex) {
          userAttributesProvider = UserAttributesProvider();
          return userAttributesProvider;
        }),
        ChangeNotifierProvider<LecturesProvider>(create: (contex) {
          lecturesProvider = LecturesProvider();
          return lecturesProvider;
        }),
        ChangeNotifierProvider<MyEmailWeb>(create: (contex) {
          myEmailWeb = MyEmailWeb();
          return myEmailWeb;
        }),
        ChangeNotifierProvider<SelectedRoleProvider>(create: (contex) {
          selectedRoleProvider = SelectedRoleProvider();
          return selectedRoleProvider;
        }),
      ],
      child: MaterialApp(
        routes: {
          '/homepage': (context) => const HomePage(),
          '/lecturesPage': (context) => const LecturesPage(),
          '/homepagevideo': (context) => const HomePageVideoScreen(),
          '/contactUs': (context) => const ContactMeScreen(),
          '/recentLectures': (context) => const RecentLectures(),
          '/homescreen': (context) => const HomeScreen(),
          '/homepage_sidebar': (context) => const Sidebar(),
        },
        home: const HomeScreen(),
      ),
    );

void main() {
  group('Login tests', () {
    testWidgets('Verify if a user can Login', (WidgetTester tester) async {
      await tester.pumpWidget(createLoginScreenWeb());
      await tester.pumpAndSettle();

      final emailField = find.byKey(const ValueKey('emailKey'));
      await tester.tap(emailField);
      await tester.enterText(emailField, 'Sblekic@pa.tech387.com');
      await tester.pumpAndSettle();

      final passwordField = find.byKey(const ValueKey('passwordKey'));
      await tester.tap(passwordField);
      await tester.enterText(passwordField, 'Password123!');
      await tester.pumpAndSettle();

      expect(
          find.text(
              'Our goal is to recognise persistence, motivation and adaptability, thats why we encourage you to dive into these materials and wish you the best of luck in your studies.'),
          findsOneWidget);
    });

    testWidgets(
        'Verify if error massage "Please fill the required field." will show',
        (WidgetTester tester) async {
      await tester.pumpWidget(createLoginScreenWeb());
      await tester.pumpAndSettle();

      final emailField = find.byKey(const ValueKey('emailKey'));
      await tester.tap(emailField);
      await tester.enterText(emailField, '');
      await tester.pumpAndSettle();

      final passwordField = find.byKey(const ValueKey('passwordKey'));
      await tester.tap(passwordField);
      await tester.enterText(passwordField, '');
      await tester.pumpAndSettle();

      expect(find.text('Please fill the required field.'), findsNWidgets(2));
    });

    testWidgets(
        'Verify if error massage "Incorrect email or password" will show',
        (WidgetTester tester) async {
      await tester.pumpWidget(createLoginScreenWeb());
      await tester.pumpAndSettle();

      final emailField = find.byKey(const ValueKey('emailKey'));
      await tester.tap(emailField);
      await tester.enterText(emailField, 'mail@mail.com');
      await tester.pumpAndSettle();

      final passwordField = find.byKey(const ValueKey('passwordKey'));
      await tester.tap(passwordField);
      await tester.enterText(passwordField, 'testPassword');
      await tester.pumpAndSettle();

      expect(find.text('Please fill the required field.'), findsNWidgets(1));
    });
  });

  group('Homescreen tests', () {
    testWidgets('Verify if a user can see welcome message',
        (WidgetTester tester) async {
      await tester.pumpWidget(createHomeScreenWeb());
      await tester.pumpAndSettle();

      expect(find.text('Welcome to'), findsOneWidget);
      expect(find.text('Product Arena'), findsOneWidget);
      expect(
          find.text(
              'Our goal is to recognise persistence, motivation and adaptability, thats why we encourage you to dive into these materials and wish you the best of luck in your studies.'),
          findsOneWidget);
      expect(
          find.text(
              'Once you have gone through all the lessons you ll be able to take a test to show us what you have learned!'),
          findsOneWidget);
    });

    testWidgets('Verify if a user can go on Homepage',
        (WidgetTester tester) async {
      await tester.pumpWidget(createHomeScreenWeb());
      await tester.pumpAndSettle();

      final homescreenButton = find.byKey(const ValueKey('homescreen_key'));
      await tester.tap(homescreenButton);
      await tester.pumpAndSettle();

      expect(find.text('Welcome to'), findsOneWidget);
      expect(find.text('Product Arena'), findsOneWidget);
    });

    testWidgets('Verify if a user can go on Contact us! page',
        (WidgetTester tester) async {
      await tester.pumpWidget(createHomeScreenWeb());
      await tester.pumpAndSettle();

      final backendButton = find.byKey(const ValueKey('contact_key'));
      await tester.tap(backendButton);
      await tester.pumpAndSettle();

      expect(find.text('Submit'), findsOneWidget);
    });
  });

  group('Contact us tests', () {
    testWidgets('Verify if a user can go on Contact us! page',
        (WidgetTester tester) async {
      await tester.pumpWidget(createHomeScreenWeb());
      await tester.pumpAndSettle();

      final backendButton = find.byKey(const ValueKey('contact_key'));
      await tester.tap(backendButton);
      await tester.pumpAndSettle();

      expect(find.text('Submit'), findsOneWidget);
    });

    testWidgets(
        'Verify if a user can will recieve error messages if field is empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(createHomeScreenWeb());
      await tester.pumpAndSettle();

      final textField = find.byKey(const ValueKey('contactField'));
      await tester.tap(textField);
      await tester.enterText(textField, '');
      await tester.pumpAndSettle();

      expect(
          find.text('Please type your message before sending'), findsOneWidget);
    });

    testWidgets(
        'Verify if a user can will recieve error messages if message is short',
        (WidgetTester tester) async {
      await tester.pumpWidget(createHomeScreenWeb());
      await tester.pumpAndSettle();

      final textField = find.byKey(const ValueKey('contactField'));
      await tester.tap(textField);
      await tester.enterText(textField, 'test');
      await tester.pumpAndSettle();

      expect(find.text('Your message has to contain at least 10 characters'),
          findsOneWidget);
    });
  });
}
