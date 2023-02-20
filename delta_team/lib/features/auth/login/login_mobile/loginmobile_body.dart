import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:delta_team/features/auth/loadingScreens/loadingscreen_mobile.dart';
import 'package:delta_team/features/auth/login/amplify_auth.dart';
import 'package:delta_team/features/auth/login/login_form.dart';
import 'package:delta_team/features/auth/login/loginform_mobile.dart';
import 'package:delta_team/home_mobile.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_extension/riverpod_extension.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:google_fonts/google_fonts.dart';

class MyMobileBody extends StatefulWidget {
  const MyMobileBody({super.key});

  @override
  _MyMobileBodyState createState() => _MyMobileBodyState();
}

class _MyMobileBodyState extends State<MyMobileBody> {
  // TextEditingController username = TextEditingController();
  // TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // bool passwordObscured = true;
  String errorMessage = '';

  // void togglePasswordObscure() {
  //   setState(() {
  //     passwordObscured = !passwordObscured;
  //   });
  // }

  //   setState(() {
  // }

  Future<void> usersignIn(
      BuildContext context, String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      setState(() {
        errorMessage = 'Incorrect email or password';
      });
    } else {
      try {
        final result =
            await Amplify.Auth.signIn(username: email, password: password);
        if (result.isSignedIn) {
          Navigator.pushNamed(context, LoadingScreenMobile.routeName);
        }
      } on AuthException catch (error) {
        setState(() {
          errorMessage = error.message;
        });
      } on HttpException catch (e) {
        final response = e.response;
        if (response.statusCode == 400) {
          setState(() {
            errorMessage = 'Please enter a valid email or password';
          });
        } else {
          setState(() {
            errorMessage = 'Sign in failed';
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 0.0,
        title: Container(
          alignment: Alignment.center,
          child: Image.asset(
            "assets/images/logotop.png",
            fit: BoxFit.contain,
            height: 35,
          ),
        ),
      ),
      backgroundColor: const Color(0xFFE9E9E9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: 'Welcome to',
                              style: GoogleFonts.notoSans(
                                fontSize: 32.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              )),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Product Arena',
                        style: GoogleFonts.notoSans(
                            fontWeight: FontWeight.w700,
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontSize: 32.0),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 128.0),
                Form(
                    key: _formKey,
                    child: SizedBox(
                      width: (296 / 360) * width,
                      child: Column(
                        children: [
                          const LoginFieldMobile(),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 14,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(children: [
                                  Text(
                                    'Don’t you have an account?',
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFF000000),
                                      fontSize: 10.0,
                                    ),
                                  )
                                ]),
                                GestureDetector(
                                  key: const Key('SignUp_Homepage'),
                                  onTap: () async {
                                    Navigator.pushNamed(
                                        context, LoadingScreenMobile.routeName);
                                  },
                                  child: Text(
                                    ' Sign up',
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF000000),
                                      fontSize: 10.0,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 185,
                ),
                SizedBox(
                  height: 70,
                  width: 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Image.asset("assets/images/tech387.png")],
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 55,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: (30 / 360) * width,
                      right: (30 / 360) * width,
                      bottom: 8),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          key: const Key('routed_to_loadingScreen'),
                          onTap: () async {
                            Navigator.pushNamed(
                                context, LoadingScreenMobile.routeName);
                            // Navigate to privacy page
                          },
                          child: Text(
                            "Privacy",
                            style: GoogleFonts.notoSans(
                              fontWeight: FontWeight.w400,
                              color: const Color.fromARGB(255, 142, 142, 142),
                              fontSize: 13.0,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            "© Credits, 2023, Product Arena",
                            style: GoogleFonts.notoSans(
                                fontWeight: FontWeight.w400,
                                color: const Color.fromARGB(255, 142, 142, 142),
                                fontSize: 12.0),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          key: const Key('routed_to_LoadingScreen'),
                          onTap: () async {
                            Navigator.pushNamed(
                                context, LoadingScreenMobile.routeName);
                            // Navigate to privacy page
                          },
                          child: Text(
                            "Terms",
                            style: GoogleFonts.notoSans(
                                fontWeight: FontWeight.w400,
                                color: const Color.fromARGB(255, 142, 142, 142),
                                fontSize: 13.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}