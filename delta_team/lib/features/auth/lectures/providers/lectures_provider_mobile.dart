import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:delta_team/amplifyconfiguration.dart';
import 'package:flutter/material.dart';

class LectureListProvider extends ChangeNotifier {
  List roles = [];
  List _lectures = [];

  List get lectures {
    return [..._lectures];
  }

  // Future<void> _configureAmplify() async {
  //   // Add any Amplify plugins you want to use
  //   print('pocela konfiguracija');
  //   final authPlugin = AmplifyAuthCognito();
  //   final api = AmplifyAPI();
  //   await Amplify.addPlugins([authPlugin, api]);
  //   try {
  //     await Amplify.configure(amplifyconfig);
  //   } on AmplifyAlreadyConfiguredException {
  //     safePrint(
  //         'Tried to reconfigure Amplify; this can occur when your app restarts on Android.');
  //   }
  // }

  Future<void> signInUser() async {
    // await _configureAmplify();
    try {
      final result = await Amplify.Auth.signIn(
        username: 'semir.blekich@gmail.com', // email of user
        password: 'Password123!',
      );
      print('LOGGED IN!');
    } on AuthException catch (e) {
      safePrint(e.message);
    }
  }

  Future<void> getUserLectures() async {
    await signInUser();
    try {
      final restOperation = Amplify.API.get('/api/user/lectures',
          apiName: 'getUserLectures',
          queryParameters: {
            'paDate': 'Jan2023'
            // , 'name': 'Flutter widgets'
          });
      final response = await restOperation.response;
      Map<String, dynamic> responseMap = jsonDecode(response.decodeBody());

      List temp = [];
      responseMap['lectures'].forEach((lecture) {
        temp.addAll(lecture['roles']);
      });
      Set<String> set = Set<String>.from(temp);
      List<String> roles = set.toList();
      print(roles);
      var oneLecture;
      responseMap['lectures'].forEach((lecture) {
        oneLecture = lecture;

        _lectures.add(oneLecture);
      });

      print(_lectures[0]['name']);
      print('GET call succeeded: ${responseMap['lectures'][1]['name']}');
      notifyListeners();
    } on ApiException catch (e) {
      print('GET call failed: $e');
    }
  }
}
