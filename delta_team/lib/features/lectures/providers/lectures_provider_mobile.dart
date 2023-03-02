import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

class LectureListProvider extends ChangeNotifier {
  List roles = [];
  List _selectedRole1 = [];
  List _selectedRole2 = [];

  List get sR1 => _selectedRole1;
  List get sR2 => _selectedRole2;



//  Future<void> getUserLectures() async {
//     await signInUser();
//     try {
//       final restOperation = Amplify.API.get('/api/user/lectures',
//           apiName: 'getUserLectures',
//           queryParameters: {
//             'paDate': 'Jan2023'
//             // , 'name': 'Flutter widgets'
//           });
//       final response = await restOperation.response;
//       Map<String, dynamic> responseMap = jsonDecode(response.decodeBody());

//       List temp = [];
//       responseMap['lectures'].forEach((lecture) {
//         temp.addAll(lecture['roles']);
//       });
//       Set<String> set = Set<String>.from(temp);
//       List<String> roles = set.toList();
//       print(roles);
//       var oneLecture;
//       responseMap['lectures'].forEach((lecture) {
//         oneLecture = lecture;

//         _lectures.add(oneLecture);
//       });

//       print(_lectures[0]['name']);
//       print('GET call succeeded: ${responseMap['lectures'][1]['name']}');
//       notifyListeners();
//     } on ApiException catch (e) {
//       print('GET call failed: $e');
//     }
//   }
  

  Future<void> updateLastStopped() async {
    try {
      final restOperation = Amplify.API.patch("/api/lecture/lastStopped",
          body: HttpPayload.json({
            "lectureName": "Docker",
            "lastStoppedInSeconds": 10,
            "date": "Jan2023"
          }),
          apiName: "updateLastStoppedDelta");
      final response = await restOperation.response;
      Map<String, dynamic> responseMap = jsonDecode(response.decodeBody());

      print('GET call succeeded: ${responseMap}');
    } on ApiException catch (e) {
      print('PATCH call failed: ${e.message}');
    }
  }
}
