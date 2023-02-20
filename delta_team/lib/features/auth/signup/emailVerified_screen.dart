import 'package:delta_team/features/auth/signup/loadingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmailVerifiedScreen extends StatefulWidget {
  const EmailVerifiedScreen({super.key});

  @override
  State<EmailVerifiedScreen> createState() => _EmailVerifiedScreenState();
}

class _EmailVerifiedScreenState extends State<EmailVerifiedScreen> {
  @override
  void initState() {
    super.initState();
    // Schedule the opening of a new page after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoadingPage()),
      );
    });
  }

  double? screenWidth;
  double? screenHeight;
  @override
  Widget build(BuildContext context) {
    screenWidth ??= MediaQuery.of(context).size.width;
    screenHeight ??= MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/paBackground.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Container(
              height: 464,
              width: 740,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
              ),
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Padding(
                  padding: MediaQuery.of(context).size.width > 630
                      ? const EdgeInsets.symmetric(
                          horizontal: 80.0, vertical: 80.0)
                      : const EdgeInsets.symmetric(
                          horizontal: 1, vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 16),
                      SvgPicture.asset("assets/images/check_circle.svg"),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          'Email verified',
                          style: MediaQuery.of(context).size.width > 630
                              ? const TextStyle(
                                  fontSize: 60, fontWeight: FontWeight.bold)
                              : const TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          'Your email is successfully verified',
                          style: MediaQuery.of(context).size.width > 630
                              ? const TextStyle(
                                  fontSize: 32,
                                )
                              : const TextStyle(
                                  fontSize: 16,
                                ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
