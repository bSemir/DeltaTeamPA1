import 'package:delta_team/features/auth/login/login_mobile/loginmobile_body.dart';
import 'package:delta_team/features/auth/signup/signup_mobile/widgets/textfields_signup_mobile.dart';
import 'package:delta_team/features/auth/signup/signup_mobile/widgets/title_signup_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../common/footer/bottomnavigation_mobile.dart';
import '../widgets/footer.dart';

class SignupScreenMobile extends StatelessWidget {
  const SignupScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: SvgPicture.asset("assets/images/navbar_logo.svg",
            semanticsLabel: 'Confirmation SVG'),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFFE9E9E9),
          child: Column(
            children: [
              const Center(child: TitleSignUpMobile()),
              Padding(
                padding: EdgeInsets.only(
                    left: (32.0 / 360) * width, right: (32.0 / 360) * width),
                child: const TextFieldSignUp(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: GoogleFonts.notoSans(
                        fontSize: (10.0 / 360) * width,
                        fontWeight: FontWeight.w400),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, LoginScreenMobile.routeName);
                    },
                    key: const Key("loginKey"),
                    child: Text(
                      'Log in',
                      style: GoogleFonts.notoSans(
                          fontSize: (10.0 / 360) * width,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 57.1,
              ),
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [SvgPicture.asset("assets/images/tech387.svg")],
                ),
              ),
              const SizedBox(
                height: 23.1,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
