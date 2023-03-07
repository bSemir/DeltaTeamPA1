import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:delta_team/features/auth/login/amplify_auth.dart';
import 'package:delta_team/features/auth/login/loadingScreens/loadingscreen_web.dart';
import 'package:delta_team/features/auth/login/login_web/loginform_web.dart';
import 'package:delta_team/features/auth/login/login_web/loginweb_body.dart';
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
import 'package:delta_team/features/homepage/provider/youtube_link_provider.dart';
import 'package:delta_team/features/homepage/recentLectures.dart';
import 'package:delta_team/features/onboarding_web/provider/emailPasswProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:provider/provider.dart';

late MyEmailWeb myEmailWeb;
late UserAttributesProvider userAttributesProvider;
late EmailPasswordProvider emailPasswordProvider;
late LecturesProvider lecturesProvider;
late SelectedRoleProvider selectedRoleProvider;
late YoutubeLinkProvider youtubeProvider;
late AuthenticationProvider authenticationProvider;

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
        ChangeNotifierProvider<AuthenticationProvider>(create: (contex) {
          authenticationProvider = AuthenticationProvider();
          return authenticationProvider;
        }),
      ],
      child: MaterialApp(
        routes: {
          // LoginScreenWeb.routeName: (context) => const LoginScreenWeb(),
          '/loadingScreenWeb': (context) => const LoadingScreenWeb(),
          '/homepage': (context) => const HomePage(),
          '/lecturesPage': (context) => const LecturesPage(),
          '/homepagevideo': (context) => const HomePageVideoScreen(),
          '/contactUs': (context) => const ContactMeScreen(),
          '/recentLectures': (context) => const RecentLectures(),
          '/homescreen': (context) => const HomeScreen(),
          '/homepage_sidebar': (context) => const Sidebar(),
          '/loginScreenWeb': (context) => const LoginScreenWeb(),
        },
        home: const LoginScreenWeb(),
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
        ChangeNotifierProvider<YoutubeLinkProvider>(create: (contex) {
          youtubeProvider = YoutubeLinkProvider();
          return youtubeProvider;
        }),
      ],
      child: MaterialApp(
        routes: {
          LoginScreenWeb.routeName: (context) => const LoginScreenWeb(),
          '/loadingScreenWeb': (context) => const LoadingScreenWeb(),
          '/homepage': (context) => const HomePage(),
          '/lecturesPage': (context) => const LecturesPage(),
          '/homepagevideo': (context) => const HomePageVideoScreen(),
          '/contactUs': (context) => const ContactMeScreen(),
          '/recentLectures': (context) => const RecentLectures(),
          '/homescreen': (context) => const HomeScreen(),
          '/homepage_sidebar': (context) => const Sidebar(),
          '/loginField': (context) => const LoginField(),
        },
        home: const HomeScreen(),
      ),
    );

@GenerateMocks([
  AmplifyClass,
  SignInResult,
  SignUpResult,
  SignOutResult,
  RestOperation,
])
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

      final loginButton = find.byKey(const ValueKey('Login_Button'));
      await tester.tap(loginButton);
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

      // final logPage = find.byKey(const ValueKey('logField'));
      // await tester.tap(logPage);
      // await tester.pumpAndSettle();

      final emailField = find.byKey(const ValueKey('emailKey'));
      await tester.tap(emailField);
      await tester.enterText(emailField, ' ');
      await tester.pumpAndSettle();

      final passwordField = find.byKey(const ValueKey('passwordKey11'));
      await tester.tap(passwordField);
      await tester.enterText(passwordField, ' ');
      await tester.pumpAndSettle();

      final loginButton = find.byKey(const ValueKey('Login_Button'));
      await tester.tap(loginButton);
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

      final loginButton = find.byKey(const ValueKey('Login_Button'));
      await tester.tap(loginButton);
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

    testWidgets('Verify if a user can go on Homescreen',
        (WidgetTester tester) async {
      await tester.pumpWidget(createHomeScreenWeb());
      await tester.pumpAndSettle();

      final homescreenButton = find.byKey(const ValueKey('homescreen_key2'));
      await tester.tap(homescreenButton);
      await tester.pumpAndSettle();

      expect(find.text('Welcome to'), findsOneWidget);
      expect(find.text('Product Arena'), findsOneWidget);
    });

    group('Contact us page tests', () {
      testWidgets('Verify if a user can go on Contact us! page',
          (WidgetTester tester) async {
        await tester.pumpWidget(createHomeScreenWeb());
        await tester.pumpAndSettle();

        final contactButton = find.byKey(const ValueKey('contact_key2'));
        await tester.tap(contactButton);
        await tester.pumpAndSettle();

        expect(find.text('CONTACT US'), findsOneWidget);
      });
    });

    testWidgets(
        'Verify if a user can will recieve error messages if field is empty on contact us page',
        (WidgetTester tester) async {
      await tester.pumpWidget(createHomeScreenWeb());
      await tester.pumpAndSettle();

      final backendButton = find.byKey(const ValueKey('contact_key2'));
      await tester.tap(backendButton);
      await tester.pumpAndSettle();

      final sideBar = find.byKey(const ValueKey('user_menu_key'));
      await tester.tap(sideBar);
      await tester.pumpAndSettle();

      final textField = find.byKey(const ValueKey('contactField'));
      await tester.tap(textField);
      await tester.enterText(textField, ' ');
      await tester.pumpAndSettle();

      expect(
          find.text('Please type your message before sending'), findsOneWidget);
    });

    testWidgets(
        'Verify if a user can will recieve error messages if message is short',
        (WidgetTester tester) async {
      await tester.pumpWidget(createHomeScreenWeb());
      await tester.pumpAndSettle();

      final backendButton = find.byKey(const ValueKey('contact_key2'));
      await tester.tap(backendButton);
      await tester.pumpAndSettle();

      final textField = find.byKey(const ValueKey('contactField'));
      await tester.tap(textField);
      await tester.enterText(textField, 'test');
      await tester.pumpAndSettle();

      expect(find.text('Your message has to contain at least 10 characters'),
          findsOneWidget);
    });
  });

  group('Recent Lectures tests', () {
    testWidgets('Verify if a user can go on Recent lecture page',
        (WidgetTester tester) async {
      await tester.pumpWidget(createHomeScreenWeb());
      await tester.pumpAndSettle();

      // final homescreenButton = find.byKey(const ValueKey('homescreen_key2'));
      // await tester.tap(homescreenButton);
      // await tester.pumpAndSettle();

      final recentButton = find.byKey(const ValueKey('recentlectures_key2'));
      await tester.tap(recentButton);
      await tester.pumpAndSettle();

      expect(find.text('Total time: '), findsNWidgets(1));
      expect(find.text('23:17'), findsNWidgets(1));
    });
  });

  group('User tests', () {
    testWidgets('Verify if a user can go on User popup page',
        (WidgetTester tester) async {
      await tester.pumpWidget(createHomeScreenWeb());
      await tester.pumpAndSettle();

      final userBarButton = find.byKey(const ValueKey('user_icon_key1'));
      await tester.tap(userBarButton);
      await tester.pumpAndSettle();

      expect(find.text('Log out'), findsOneWidget);
    });
  });
}
