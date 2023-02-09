import 'dart:io';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:delta_team/amplifyconfiguration.dart';
import 'package:flutter/material.dart';

import 'package:riverpod_extension/riverpod_extension.dart';

// class AuthenticationProvider with ChangeNotifier {
//   String errorMessage = '';
//   bool isSignInComplete = false;
//   bool isLoading = false;

//   Future<void> _configureAmplify() async {
//     try {
//       final apiPlugin = AmplifyAPI();
//       final authPlugin = AmplifyAuthCognito();
//       await Amplify.addPlugin(
//           [apiPlugin, authPlugin] as AmplifyPluginInterface);

//       // call Amplify.configure to use the initialized categories in your app
//       await Amplify.configure(amplifyconfig);
//     } on Exception catch (e) {
//       safePrint('An error occurred configuring Amplify: $e');
//     }
//   }

//   Future<void> _userLogin(
//     String username,
//     String password,
//     BuildContext context,
//   ) async {
//     await _configureAmplify();
//     try {
//       final result = await Amplify.Auth.signIn(
//         username: username,
//         password: password,
//       );

//       isSignInComplete = result.isSignedIn;
//       notifyListeners();
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const Homepage()),
//       );
//       // handle the sign in result
//     } on AuthException catch (e) {
//       safePrint(e.message);
//       errorMessage = e.message;
//     }
//   }
// }
class AuthenticationProvider with ChangeNotifier {
  String errorMessage = '';
  bool isSignInComplete = false;
  bool isLoading = false;

  Future<void> _configureAmplify() async {
    try {
      // amplify plugins
      final apiPlugin = AmplifyAPI();
      final authPlugin = AmplifyAuthCognito();
      // add Amplify plugins
      await Amplify.addPlugins([apiPlugin, authPlugin]);
      await Amplify.configure(amplifyconfig);
    } catch (e) {
      safePrint('An error occurred configuring Amplify: $e');
    }
  }

  Future<void> signIn(
    email,
    password,
    BuildContext context,
  ) async {
    isLoading = true;
    notifyListeners();
    await _configureAmplify();
    try {
      final result =
          await Amplify.Auth.signIn(username: email, password: password);
      if (result.isSignedIn) {
        isSignInComplete = true;
      } else {
        errorMessage = 'Sign in failed';
      }
    } on AuthException catch (e) {
      errorMessage = e.message;
    } on HttpException catch (e) {
      final response = e.response;
      if (response.statusCode == 400) {
        errorMessage = 'Please enter a valid email or password';
      } else {
        errorMessage = 'Sign in failed';
      }
    }

    isLoading = false;
    notifyListeners();
  }
}

// import 'package:amplify_flutter/amplify_flutter.dart';

// Future<void> signIn(String email, String password) async {
//   try {
//     AuthSignInResult result = await Amplify.Auth.signIn(
//       username: email,
//       password: password,
//     );
//     print(result.isSignedIn);
//   } on AuthException catch (e) {
//     print(e);
//   }
// }

// Future<void> signOutCurrentUserGlobally(
//   email,
//   password,
//   BuildContext context,
// ) async {
//   try {
//     await Amplify.Auth.signOut(
//         options: const SignOutOptions(globalSignOut: true));
//   } on AmplifyException catch (e) {
//     print(e.message);
//   }
// }

Future<void> signOutCurrentUser(
  email,
  password,
  BuildContext context,
) async {
  try {
    await Amplify.Auth.signOut();
  } on AuthException catch (e) {
    print(e.message);
  }
}
