import 'package:delta_team/features/auth/signup/widgets/textfields_signup_mobile.dart';
import 'package:delta_team/features/auth/signup/widgets/title_signup_mobile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/footer.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Image.asset("assets/images/navbar_logo.png"),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromRGBO(243, 243, 249, 1),
          child: Column(
            children: [
              const Center(child: TitleSignUpMobile()),
              const Padding(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: TextFieldSignUp(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: GoogleFonts.notoSans(fontSize: 14),
                  ),
                  GestureDetector(
                    key: const Key("loginKey"),
                    child: Text(
                      'Log in',
                      style: GoogleFonts.notoSans(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 57.1,
              ),
              Image.asset(
                "assets/images/footer_logo.png",
              ),
              const SizedBox(
                height: 23.1,
              ),
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
