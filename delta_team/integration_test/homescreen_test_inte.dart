import 'dart:convert';
import 'dart:typed_data';

import 'package:amplify_core/amplify_core.dart';
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
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'homescreen_test.mocks.dart';
import 'web_mocked_lectires.dart';

class MockAuth extends Mock implements AuthCategory {
  @override
  Future<SignInResult<AuthUserAttributeKey>> signIn(
      {required String username,
      String? password,
      SignInOptions? options}) async {
    var result = MockSignInResult();
    when(result.isSignedIn).thenReturn(true);
    return result;
  }

  @override
  Future<SignOutResult> signOut({SignOutOptions? options}) async {
    var result = MockSignOutResult();
    when(result.runtimeTypeName).thenReturn('');
    return result;
  }
}

class MockAPI extends Mock implements APICategory {
  @override
  RestOperation post(String path,
      {Map<String, String>? headers,
      HttpPayload? body,
      Map<String, String>? queryParameters,
      String? apiName}) {
    var result = MockRestOperation();
    when(result.response).thenAnswer((_) async {
      return AWSHttpResponse(
        statusCode: 201,
        headers: const {},
        body: Uint8List.fromList([]),
      );
    });
    return result;
  }

  @override
  RestOperation get(String path,
      {Map<String, String>? headers,
      Map<String, String>? queryParameters,
      String? apiName}) {
    var result = MockRestOperation();
    when(result.response).thenAnswer((_) async {
      if (path == '/api/user/lectures') {
        Map<String, dynamic> mockedResponseData = mockedLecturesResponseData;
        return AWSHttpResponse(
          statusCode: 200,
          headers: const {},
          body: Uint8List.fromList(utf8.encode(jsonEncode(mockedResponseData))),
        );
      } else {
        return AWSHttpResponse(
          statusCode: 200,
          headers: const {},
          body: Uint8List.fromList([]),
        );
      }
    });
    return result;
  }
}

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
          '/loginScreenWeb': (context) => const LoginScreenWeb(),
        },
        home: const LoginScreenWeb(),
      ),
    );

@GenerateMocks([
  AmplifyClass,
  SignInResult,
  SignUpResult,
  // BuildContext,
  SignOutResult,
  RestOperation,
  // AWSHttpResponse
])
void main() {
  group('Login tests', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    testWidgets('Verify if a user can Login', (tester) async {
      MockAmplifyClass test = MockAmplifyClass();
      when(test.Auth).thenReturn(MockAuth());
      when(test.API).thenReturn(MockAPI());
      AmplifyClass.instance = test;

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
    });
  });
}
