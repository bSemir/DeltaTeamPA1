import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:delta_team/features/auth/loadingScreens/loadingscreen_web.dart';
import 'package:delta_team/features/auth/login/login_web/loginweb_body.dart';
import 'package:delta_team/features/auth/signup/provider/Web_auth_provider.dart';
import 'package:delta_team/features/auth/signup/signup_web/Web_emailVerified_screen.dart';
import 'package:delta_team/features/auth/signup/signup_web/Web_loadingPage.dart';
import 'package:delta_team/features/auth/signup/signup_web/Web_signupScreen.dart';
import 'package:delta_team/features/auth/signup/signup_web/Web_signupVerification_Screen.dart';
import 'package:delta_team/features/onboarding_web/errorMsg-web.dart';
import 'package:delta_team/features/onboarding_web/loadingpageOnboarding_web.dart';
import 'package:delta_team/features/onboarding_web/modelRole.dart';
import 'package:delta_team/features/onboarding_web/modelmyItem.dart';
import 'package:delta_team/features/onboarding_web/onboardingScreen.dart';
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

late MyEmailWeb myEmailWeb;
late ErrorMessageWeb errorMessageWeb;
late MyItemWeb myItemWeb;
late Role myRole;

Widget createWebSignupScreen() => MultiProvider(
      providers: [
        ChangeNotifierProvider<MyEmailWeb>(
          create: (context) {
            myEmailWeb = MyEmailWeb();
            return myEmailWeb;
          },
        ),
        ChangeNotifierProvider<ErrorMessageWeb>(
          create: (context) {
            errorMessageWeb = ErrorMessageWeb();
            return errorMessageWeb;
          },
        ),
        ChangeNotifierProvider<MyItemWeb>(
          create: (context) {
            myItemWeb = MyItemWeb();
            return myItemWeb;
          },
        ),
      ],
      child: MaterialApp(
        routes: {
          '/signupWeb': (context) => const SignUpScreenWeb(),
          LoginScreenWeb.routeName: (context) => const LoginScreenWeb(),
          LoadingScreenWeb.routeName: (context) => const LoadingScreenWeb(),
          OnboardingWeb.routeName: (context) =>
              OnboardingWeb(role: listaRola.first),
          '/confirmationWeb': (context) => const SignupVerificationScreen(),
          '/confirmationMessageWeb': (context) => const EmailVerifiedScreen(),
          // '/loadingPage': (context) => const LoadingPage(),
          // LoadingPageOnboarding.routeName: (context) =>
          //     const LoadingPageOnboarding(),
          '/loadingPageSignup': (context) => const LoadingPage(),
          '/loadingOnboarding': (context) => const LoadingPageOnboarding(),
          '/homeweb': (context) => const HomeScreenWeb(),

          // '/loadingtoOnboard': (context) => const LoadingPage()
        },
        home: const SignUpScreenWeb(),
      ),
    );

//ispod

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
    // setUpAll(() async {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    // TestWidgetsFlutterBinding.ensureInitialized();
  });
  testWidgets('Web flow.', (tester) async {
    MockAmplifyClass test = MockAmplifyClass();
    when(test.Auth).thenReturn(MockCC());
    when(test.API).thenReturn(MockAPI());
    AmplifyClass.instance = test;

    await tester.pumpWidget(createWebSignupScreen());
    await tester.pumpAndSettle();

    // //singup
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

    await tester.ensureVisible(find.byKey(const Key("code1Key")));
    await tester.tap(find.byKey(const Key("code1Key")));
    await tester.enterText(find.byKey(const Key("code1Key")), '1');
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.byKey(const Key("code2Key")));
    await tester.tap(find.byKey(const Key("code2Key")));
    await tester.enterText(find.byKey(const Key("code2Key")), '2');
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.byKey(const Key("code3Key")));
    await tester.tap(find.byKey(const Key("code3Key")));
    await tester.enterText(find.byKey(const Key("code3Key")), '3');
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.byKey(const Key("code4Key")));
    await tester.tap(find.byKey(const Key("code4Key")));
    await tester.enterText(find.byKey(const Key("code4Key")), '4');
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.byKey(const Key("code5Key")));
    await tester.tap(find.byKey(const Key("code5Key")));
    await tester.enterText(find.byKey(const Key("code5Key")), '5');
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.byKey(const Key("code6Key")));
    await tester.tap(find.byKey(const Key("code6Key")));
    await tester.enterText(find.byKey(const Key("code6Key")), '6');
    await tester.pumpAndSettle();

    final verifyButton = find.byKey(const ValueKey('verifyConfirmationKey'));
    await tester.ensureVisible(verifyButton);
    await tester.tap(verifyButton);
    await tester.pumpAndSettle();

    // //onboarding

    final radButtonDa = find.byKey(const ValueKey('KeyDa'));

    await tester.tap(radButtonDa);
    await tester.pumpAndSettle();

    final inputField2 = find.byKey(const ValueKey('TextFieldKey2'));
    await tester.tap(inputField2);
    await tester.pumpAndSettle();
    await tester.enterText(inputField2, 'motiv123');
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text(
        'Da li imaš ili si imao/la neki hobi ili se baviš nekim sportom?'));
    await tester.pumpAndSettle();

    final inputField3 = find.byKey(const ValueKey('TextFieldKey3'));
    await tester.tap(inputField3);
    await tester.pumpAndSettle();
    await tester.enterText(inputField3, 'bavim se sportom');
    await tester.pumpAndSettle();

    final inputField4 = find.byKey(const ValueKey('TextFieldKey4'));
    await tester.tap(inputField4);
    await tester.pumpAndSettle();
    await tester.enterText(inputField4, 'interesovanje test test ...');
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text(
        'Da li bi vodio/la brigu o kucnom ljubimcu svojih komsija dok su oni na godisnjem odmoru?'));
    await tester.pumpAndSettle();

    final inputField5 = find.byKey(const ValueKey('TextFieldKey5'));
    await tester.tap(inputField5);
    await tester.pumpAndSettle();
    await tester.enterText(inputField5, 'da naravno ...');
    await tester.pumpAndSettle();

    final inputField6 = find.byKey(const ValueKey('TextFieldKey6'));
    await tester.tap(inputField6);
    await tester.pumpAndSettle();
    await tester.enterText(inputField6, 'kapetan oke ...');
    await tester.pumpAndSettle();

    // await tester.ensureVisible(find
    //     .text('Pogledajte video snimak Amera i poslušajte njegovu poruku.'));
    // await tester.pumpAndSettle();

    // final inputFieldVideo = find.byKey(const ValueKey('ytKiDrugaVelicina'));
    // await tester.tap(inputFieldVideo);
    // await tester.pumpAndSettle();

    // await Future.delayed(const Duration(seconds: 15));
    // await tester.pumpAndSettle();
    // await tester.tap(inputFieldVideo);

    // final inputFieldVideoInput = find.byKey(const ValueKey('urlKey1'));
    // await tester.tap(inputFieldVideoInput);
    // await tester.pumpAndSettle();
    // await tester.enterText(inputFieldVideoInput, 'link link');
    // await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Posalji'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('qa'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('uiux'));
    await tester.pumpAndSettle();

    final sendKey = find.byKey(const ValueKey('posaljikey'));
    await tester.tap(sendKey);
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 15));
    expect(find.text('Congratulations'), findsOneWidget);
    await Future.delayed(const Duration(seconds: 15));
  });
}
