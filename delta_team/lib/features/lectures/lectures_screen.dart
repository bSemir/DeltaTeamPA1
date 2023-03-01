import "package:amplify_api/amplify_api.dart";
import "package:amplify_auth_cognito/amplify_auth_cognito.dart";
import "package:amplify_flutter/amplify_flutter.dart";
import "package:delta_team/amplifyconfiguration.dart";
import 'package:delta_team/features/lectures/providers/lectures_provider_mobile.dart';
import 'package:delta_team/features/lectures/single_lecture_screen.dart';
import 'package:delta_team/features/lectures/widgets/lecture_card.dart';
import "package:delta_team/features/onboarding/onboarding_mobile/mobile_models/role_mobile.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class LecturesScreen extends StatefulWidget {
  final String role;
  const LecturesScreen({super.key, required this.role});

  @override
  State<LecturesScreen> createState() => _LecturesScreenState();
}

class _LecturesScreenState extends State<LecturesScreen> {
  Future<void> _configureAmplify() async {
    // Add any Amplify plugins you want to use
    print('pocela konfiguracija');
    final authPlugin = AmplifyAuthCognito();
    final api = AmplifyAPI();
    await Amplify.addPlugins([authPlugin, api]);
    try {
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      safePrint(
          'Tried to reconfigure Amplify; this can occur when your app restarts on Android.');
    }
  }

  void initState() {
    super.initState();
    _configureAmplify();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    var provider = Provider.of<LectureListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: provider.getUserLectures,
            child: const Text('Response'),
          ),
        ],
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: provider.lectures.length,
        itemBuilder: (BuildContext context, int index) {
          final lecture = provider.lectures[index];
          final name = lecture['name'];
          final image = lecture['imageSrc'];
          return Padding(
            padding: const EdgeInsets.only(top: 12.0, left: 32.0, right: 32.0),
            child: GestureDetector(
              onTap: () {
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(
                //     content: Text('Lesson clicked!'),
                //   ),
                // );
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SingleLectureScreen()));
              },
              child: LectureCard(
                imageSrc: image,
                name: name,
              ),
            ),
          );
        },
      ),
    );
  }
}
