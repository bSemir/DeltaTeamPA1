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
import 'package:delta_team/features/onboarding/mobile_widgets/role_card_mobile.dart';
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

      ////singup

      await tester.pumpWidget(createMobileSignupScreen());
      await tester.pumpAndSettle();

      final nameField = find.byKey(const ValueKey('nameKey'));
      await tester.ensureVisible(nameField);
      await tester.tap(nameField);
      await tester.enterText(nameField, 'Amar');
      await tester.pumpAndSettle();

      final surnameField = find.byKey(const ValueKey('surnameKey'));
      await tester.ensureVisible(surnameField);
      await tester.tap(surnameField);
      await tester.enterText(surnameField, 'Doe');
      await tester.pumpAndSettle();

      final birthDateField = find.byKey(const ValueKey('birthDateKey'));
      await tester.pumpAndSettle();
      await tester.tap(birthDateField);
      await tester.pump();
      await tester.enterText(birthDateField, '05/04/2003');

      final cityField = find.byKey(const ValueKey('cityKey'));
      await tester.pumpAndSettle();
      await tester.tap(cityField);
      await tester.pump();
      await tester.enterText(cityField, 'Berlin');

      final dropDown = find.byKey(const ValueKey('statusKey'));
      await tester.tap(dropDown);
      await tester.pumpAndSettle();

      final status = find.text('Student').last;
      await tester.tap(status);
      await tester.pumpAndSettle();

      final phoneField = find.byKey(const ValueKey('phoneNumberKey'));
      await tester.pumpAndSettle();
      await tester.tap(phoneField);
      await tester.pump();
      await tester.enterText(phoneField, '+38761123456789');

      final emailField = find.byKey(const ValueKey('emailKey'));
      await tester.pumpAndSettle();
      await tester.tap(emailField);
      await tester.pump();
      await tester.enterText(emailField, 'tttttt@tttttt.com');
      await tester.pumpAndSettle();

      final passwordField = find.byKey(const ValueKey('passwordKey'));
      await tester.pumpAndSettle();
      await tester.tap(passwordField);
      await tester.pump();
      await tester.enterText(passwordField, 'Imeiprezime1@');

      final cyaButton = find.byKey(const ValueKey('createAccountKey'));
      await tester.ensureVisible(cyaButton);
      await tester.tap(cyaButton);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key("num1Key")));
      await tester.enterText(find.byKey(const Key("num1Key")), '1');
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key("num2Key")));
      await tester.enterText(find.byKey(const Key("num2Key")), '2');
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key("num3Key")));
      await tester.enterText(find.byKey(const Key("num3Key")), '3');
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key("num4Key")));
      await tester.enterText(find.byKey(const Key("num3Key")), '4');
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key("num5Key")));
      await tester.enterText(find.byKey(const Key("num5Key")), '5');
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key("num6Key")));
      await tester.enterText(find.byKey(const Key("num6Key")), '6');
      await tester.pumpAndSettle();

      final verifyButton = find.byKey(const ValueKey('verifyConfirmationKey'));
      await tester.ensureVisible(verifyButton);
      await tester.tap(verifyButton);
      await tester.pumpAndSettle();

      ////onboarding

      final radButtonDa = find.byKey(const ValueKey('RadioButtonDaKey'));
      expect(radButtonDa, findsOneWidget);
      await tester.tap(radButtonDa);
      await tester.pumpAndSettle();

      final nextButtonF =
          find.byKey(const ValueKey('FirstQuestionNextButtonKey'));
      //await tester.ensureVisible(navButton);
      await tester.tap(nextButtonF);
      await tester.pumpAndSettle();

      final inputField = find.byKey(const ValueKey('inputKey'));
      await tester.tap(inputField);
      await tester.pumpAndSettle();
      await tester.enterText(inputField, 'motiv123');
      await tester.pumpAndSettle();

      final nextButton = find.byKey(const ValueKey('OnboardingNextButtonKey'));
      await tester.tap(nextButton);
      await tester.pumpAndSettle();

      expect(
          find.text(
              'Da li imaš ili si imao/la neki hobi ili se baviš nekim sportom?'),
          findsOneWidget);

      await tester.tap(inputField);
      await tester.pumpAndSettle();
      await tester.enterText(inputField, 'bavim se sportom');
      await tester.pumpAndSettle();

      await tester.tap(nextButton);
      await tester.pumpAndSettle();

      expect(
          find.text(
              'Postoji li neko interesovanje koje imaš, ali ga trenutno ne možeš ostvariti?'),
          findsOneWidget);

      await tester.tap(inputField);
      await tester.pumpAndSettle();
      await tester.enterText(inputField, 'interesovanje test test ...');
      await tester.pumpAndSettle();

      await tester.tap(nextButton);
      await tester.pumpAndSettle();

      expect(
          find.text(
              'Da li bi vodio/la brigu o kućnom ljubimcu svojih komšija dok su oni na godišnjem odmoru?'),
          findsOneWidget);

      await tester.tap(inputField);
      await tester.pumpAndSettle();
      await tester.enterText(inputField, 'naravno, volim zivotinje');
      await tester.pumpAndSettle();

      await tester.tap(nextButton);
      await tester.pumpAndSettle();

      expect(
          find.text(
              'Kapetan si piratskog broda, tvoja posada može da glasa kako se dijeli zlato. Ako se manje od polovine pirata složi sa tobom, umrijet ćeš. \n \nKakvu podjelu zlata bi predložio/la tako da dobiješ dobar dio plijena, a ipak preživiš?'),
          findsOneWidget);

      await tester.tap(inputField);
      await tester.pumpAndSettle();
      await tester.enterText(inputField, 'kapetan lagani');
      await tester.pumpAndSettle();

      await tester.tap(nextButton);
      await tester.pumpAndSettle();

      expect(
          find.text(
              'Pogledajte video snimak Amera i poslušajte njegovu poruku.'),
          findsOneWidget);

      final nextButtonVideo =
          find.byKey(const ValueKey('VideoPageNextButtonKey'));
      await tester.tap(nextButtonVideo);
      await tester.pumpAndSettle();

      expect(find.text('Submit'), findsOneWidget);

      //final roleList = find.byKey(const ValueKey('RoleButtonKey'));
      await tester.pumpAndSettle();

      final roleFinder = find.byWidgetPredicate(
          (widget) => widget is RoleWidget && widget.role == listaRola[0]);

      await tester.tap(roleFinder);
      await tester.pumpAndSettle();

      final submitButton = find.byKey(const ValueKey('SubmitButtonKey'));
      await tester.tap(submitButton);
      await tester.pumpAndSettle();

      expect(find.text('Congratulations'), findsOneWidget);

      // //login

      final emailFieldLogin = find.byKey(const ValueKey('emailKey'));
      await tester.ensureVisible(emailFieldLogin);
      await tester.tap(emailFieldLogin);
      await tester.enterText(emailFieldLogin, 'sblekic@pa.tech387.com');
      await tester.pumpAndSettle();

      final passwordFieldLogin = find.byKey(const ValueKey('passwordKey'));
      await tester.ensureVisible(passwordFieldLogin);
      await tester.tap(passwordFieldLogin);
      await tester.enterText(passwordFieldLogin, 'Password123!');
      await tester.pumpAndSettle();

      final loginButton = find.byKey(const ValueKey('Login_Button'));
      await tester.ensureVisible(loginButton);
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      expect(find.byKey(const ValueKey('routed_to_loadingScreen')),
          findsOneWidget);
    });
  });
}
