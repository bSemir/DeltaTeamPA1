import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:delta_team/features/auth/loadingScreens/loadingscreen_mobile.dart';
import 'package:delta_team/features/auth/loadingScreens/loadingscreen_web.dart';
import 'package:delta_team/features/auth/login/login_mobile/loginmobile_body.dart';
import 'package:delta_team/features/auth/login/login_web/loginweb_body.dart';
import 'package:delta_team/features/auth/signup/provider/auth_provider_mobile.dart';
import 'package:delta_team/features/auth/signup/signup_web/Web_emailVerified_screen.dart';
import 'package:delta_team/features/auth/signup/signup_web/Web_loadingPage.dart';
import 'package:delta_team/features/auth/signup/signup_web/Web_signupScreen.dart';
import 'package:delta_team/features/auth/signup/signup_web/Web_signupVerification_Screen.dart';
import 'package:delta_team/features/auth/signup_mobile/screens/confirmation_message_mobile.dart';
import 'package:delta_team/features/auth/signup_mobile/screens/confirmation_screen_mobile.dart';
import 'package:delta_team/features/auth/signup_mobile/screens/redirecting_screen_mobile.dart';
import 'package:delta_team/features/auth/signup_mobile/screens/signupScreen_mobile.dart';
import 'package:delta_team/features/onboarding/onboarding_mobile/mobile_providers/answer_mobile.dart';
import 'package:delta_team/features/onboarding/onboarding_mobile/mobile_providers/error_provider_mobile.dart';
import 'package:delta_team/features/onboarding/onboarding_mobile/mobile_providers/provider_mobile.dart';
import 'package:delta_team/features/onboarding/onboarding_mobile/mobile_providers/role_provider_mobile.dart';
import 'package:delta_team/features/onboarding/onboarding_mobile/onboarding_screen_mobile.dart';
import 'package:delta_team/features/onboarding/onboarding_mobile/welcome_page_mobile.dart';
import 'package:delta_team/features/onboarding_web/modelRole.dart';
import 'package:delta_team/features/onboarding_web/onboardingScreen.dart';
import 'package:delta_team/home_mobile.dart';
import 'package:delta_team/home_web.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'textfields_signup_mobile_test.mocks.dart';

class MockCC extends Mock implements AuthCategory {
  @override
  Future<SignUpResult> signUp(
      {required String username,
      required String password,
      SignUpOptions? options}) async {
    var result = MockSignUpResult();
    when(result.isSignUpComplete).thenReturn(true);
    return result;
  }

  @override
  Future<SignUpResult> confirmSignUp(
      {required String username,
      required String confirmationCode,
      ConfirmSignUpOptions? options}) async {
    var result = MockSignUpResult();
    when(result.isSignUpComplete).thenReturn(true);
    return result;
  }

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
        statusCode: 200,
        headers: const {},
        body: Uint8List.fromList([]),
      );
    });
    return result;
  }
}

late MyEmail myEmail;
late AnswerProvider answerAuth;
late ErrorMessage errorMessage;
late MyItem myItem;
late MyProvider myProvider;
late AnswerProvider answerProvider;

Widget createMobileSignupScreen() => MultiProvider(
      providers: [
        ChangeNotifierProvider<MyEmail>(
          create: (context) {
            myEmail = MyEmail();
            return myEmail;
          },
        ),
        ChangeNotifierProvider<MyProvider>(
          create: (context) {
            myProvider = MyProvider();
            return myProvider;
          },
        ),
        ChangeNotifierProvider<AnswerProvider>(
          create: (context) {
            answerProvider = AnswerProvider();
            return answerProvider;
          },
        ),
        ChangeNotifierProvider<ErrorMessage>(
          create: (context) {
            errorMessage = ErrorMessage();
            return errorMessage;
          },
        ),
        ChangeNotifierProvider<MyItem>(
          create: (context) {
            myItem = MyItem();
            return myItem;
          },
        ),
      ],
      child: MaterialApp(
        routes: {
          LoginScreenWeb.routeName: (context) => const LoginScreenWeb(),
          LoginScreenMobile.routeName: (context) => const LoginScreenMobile(),
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
          OnboardingWeb.routeName: (context) =>
              OnboardingWeb(role: listaRola.first),
          '/signupWeb': (context) => const SignUpScreenWeb(),
          '/confirmationWeb': (context) => const SignupVerificationScreen(),
          '/confirmationMessageWeb': (context) => const EmailVerifiedScreen(),
          '/loadingPage': (context) => const LoadingPage()
        },
        home: const SignupScreenMobile(),
      ),
    );

@GenerateMocks([
  SignInResult,
  SignUpResult,
  AmplifyClass,
  BuildContext,
  SignOutResult,
  RestOperation
])
void main() {
  group('E2E Test', () {
    setUpAll(() async {
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    });
    testWidgets('Mobile flow.', (tester) async {
      MockAmplifyClass test = MockAmplifyClass();
      when(test.Auth).thenReturn(MockCC());
      when(test.API).thenReturn(MockAPI());
      AmplifyClass.instance = test;

      await tester.pumpWidget(createMobileSignupScreen());
      await tester.pumpAndSettle();

      final dropDown = find.byKey(const ValueKey('statusKey'));
      await tester.tap(dropDown);
      await tester.pumpAndSettle();

      final status = find.text('Student').last;
      await tester.tap(status);
    });
  });
}

  // testWidgets(
  //     'QA: Verify if a user can not proceed without filling all the mandatory fields.',
  //     (WidgetTester tester) async {
  //   await tester.pumpWidget(createMobileSignupScreen());
  //   await tester.pumpAndSettle();

  //   final cyaButton = find.byKey(const ValueKey('createAccountKey'));
  //   await tester.ensureVisible(cyaButton);
  //   await tester.tap(cyaButton);
  //   await tester.pumpAndSettle();

  //   expect(find.text('Please fill the required field.'), findsNWidgets(6));
  // });

//   testWidgets(
//       'QA: Verify the valid age of the user when the user wants to sign up.',
//       (WidgetTester tester) async {
//     await tester.pumpWidget(createMobileSignupScreen());
//     await tester.pumpAndSettle();

//     final birthDateField = find.byKey(const ValueKey('birthDateKey'));
//     await tester.tap(birthDateField);
//     await tester.enterText(birthDateField, '07/12/2056');
//     await tester.pumpAndSettle();

//     final cyaButton = find.byKey(const ValueKey('createAccountKey'));
//     await tester.ensureVisible(cyaButton);
//     await tester.tap(cyaButton);
//     await tester.pumpAndSettle();

//     expect(
//         find.text('Please enter valid birth date (dd/mm/yy)'), findsOneWidget);
//   });

//   testWidgets(
//       'QA:  Verify if the numbers and special characters are not allowed in the First and Last name.',
//       (WidgetTester tester) async {
//     await tester.pumpWidget(createMobileSignupScreen());
//     await tester.pumpAndSettle();

//     //name
//     final nameField = find.byKey(const ValueKey('nameKey'));
//     await tester.ensureVisible(nameField);
//     await tester.tap(nameField);
//     await tester.enterText(nameField, 'aco123');
//     await tester.pumpAndSettle();

//     //surname
//     final surnameField = find.byKey(const ValueKey('surnameKey'));
//     await tester.ensureVisible(surnameField);
//     await tester.tap(surnameField);
//     await tester.enterText(surnameField, 'ferhat1222');
//     await tester.pumpAndSettle();

//     final cyaButton = find.byKey(const ValueKey('createAccountKey'));
//     await tester.ensureVisible(cyaButton);
//     await tester.tap(cyaButton);
//     await tester.pumpAndSettle();

//     expect(find.text('Please enter valid name'), findsOneWidget);
//     expect(find.text('Please enter valid surname'), findsOneWidget);
//   });

//   testWidgets(
//       'QA: Verify if a user can sign-up successfully with all the mandatory details.',
//       (WidgetTester tester) async {
//     await tester.pumpWidget(createMobileSignupScreen());
//     await tester.pumpAndSettle();

//     //name
//     final nameField = find.byKey(const ValueKey('nameKey'));
//     await tester.pumpAndSettle();
//     await tester.tap(nameField);
//     await tester.pump();
//     await tester.enterText(nameField, 'alen');

//     //surname
//     final surnameField = find.byKey(const ValueKey('surnameKey'));
//     await tester.pumpAndSettle();
//     await tester.tap(surnameField);
//     await tester.pump();
//     await tester.enterText(surnameField, 'islamovic');

//     //birth date
//     final birthDateField = find.byKey(const ValueKey('birthDateKey'));
//     await tester.pumpAndSettle();
//     await tester.tap(birthDateField);
//     await tester.pump();
//     await tester.enterText(birthDateField, '05/04/2006');

//     //city
//     final cityField = find.byKey(const ValueKey('cityKey'));
//     await tester.pumpAndSettle();
//     await tester.tap(cityField);
//     await tester.pump();
//     await tester.enterText(cityField, 'Berlin');

//     //phone
//     final phoneField = find.byKey(const ValueKey('phoneNumberKey'));
//     await tester.pumpAndSettle();
//     await tester.tap(phoneField);
//     await tester.pump();
//     await tester.enterText(phoneField, '+38761123456789');

//     //email
//     final emailField = find.byKey(const ValueKey('emailKey'));
//     await tester.pumpAndSettle();
//     await tester.tap(emailField);
//     await tester.pump();
//     await tester.enterText(emailField, 'vijaypratapica@otpku.com');

//     //password
//     final passwordField = find.byKey(const ValueKey('passwordKey'));
//     await tester.pumpAndSettle();
//     await tester.tap(passwordField);
//     await tester.pump();
//     await tester.enterText(passwordField, 'Imeiprezime1@');

//     final cyaButton = find.byKey(const ValueKey('createAccountKey'));
//     await tester.ensureVisible(cyaButton);
//     await tester.tap(cyaButton);
//     await tester.pumpAndSettle();

//     expect(find.text('Please fill the required field.'), findsNothing);

//     //expect(find.byType(ConfirmationContainers), findsOneWidget);

//     // I got a verification email, but in Integration, test will be processed
//   });

//   testWidgets('QA: Verify if duplicate email address will not get assigned.',
//       (WidgetTester tester) async {
//     await tester.pumpWidget(createMobileSignupScreen());
//     await tester.pumpAndSettle();

//     //name
//     final nameField = find.byKey(const ValueKey('nameKey'));
//     await tester.pumpAndSettle();
//     await tester.tap(nameField);
//     await tester.pump();
//     await tester.enterText(nameField, 'alen');

//     //surname
//     final surnameField = find.byKey(const ValueKey('surnameKey'));
//     await tester.pumpAndSettle();
//     await tester.tap(surnameField);
//     await tester.pump();
//     await tester.enterText(surnameField, 'islamovic');

//     //birth date
//     final birthDateField = find.byKey(const ValueKey('birthDateKey'));
//     await tester.pumpAndSettle();
//     await tester.tap(birthDateField);
//     await tester.pump();
//     await tester.enterText(birthDateField, '05/04/2006');

//     //city
//     final cityField = find.byKey(const ValueKey('cityKey'));
//     await tester.pumpAndSettle();
//     await tester.tap(cityField);
//     await tester.pump();
//     await tester.enterText(cityField, 'Berlin');

//     //phone
//     final phoneField = find.byKey(const ValueKey('phoneNumberKey'));
//     await tester.pumpAndSettle();
//     await tester.tap(phoneField);
//     await tester.pump();
//     await tester.enterText(phoneField, '+38761123456789');

//     //email
//     final emailField = find.byKey(const ValueKey('emailKey'));
//     await tester.pumpAndSettle();
//     await tester.tap(emailField);
//     await tester.pump();
//     await tester.enterText(emailField, 'vijaypratapica@otpku.com');

//     //password
//     final passwordField = find.byKey(const ValueKey('passwordKey'));
//     await tester.pumpAndSettle();
//     await tester.tap(passwordField);
//     await tester.pump();
//     await tester.enterText(passwordField, 'Imeiprezime1@');

//     final cyaButton = find.byKey(const ValueKey('createAccountKey'));
//     await tester.ensureVisible(cyaButton);
//     await tester.tap(cyaButton);
//     await tester.pumpAndSettle();

//     expect(find.text('Email already exists'), findsOneWidget);
//   });

//   testWidgets('QA: Verify if a user with an account go to a Log in page.',
//       (WidgetTester tester) async {
//     await tester.pumpWidget(createMobileSignupScreen());
//     await tester.pumpAndSettle();

//     final loginButton = find.byKey(const ValueKey('loginKey'));
//     await tester.ensureVisible(loginButton);
//     await tester.tap(loginButton);
//     await tester.pumpAndSettle();

//     expect(find.text("'Don't you have an account?'"), findsOneWidget);
//   });

//   // testWidgets('QA: Verify if a user with an account go to a Log in page.',
//   //     (WidgetTester tester) async {
//   //   const errorColor = const Color.fromRGBO(179, 38, 30, 1);

//   //   await tester.pumpWidget(createMobileSignupScreen());
//   //   await tester.pumpAndSettle();

//   //   final nameField = find.byKey(const Key("nameKey"));
//   //   expect(nameField, findsOneWidget);

//   //   final input = 'wron12';
//   //   await tester.enterText(nameField, input);
//   //   await tester.pumpAndSettle();

//   //   expect(find.text('Please enter valid name'), findsOneWidget);

//   //   final nameFormField = tester.widget<TextFormField>(nameField);
//   //   expect(nameFormField.style!.color, equals(errorColor));
//   // });
// }
