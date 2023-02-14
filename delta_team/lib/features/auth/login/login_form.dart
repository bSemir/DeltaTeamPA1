import 'dart:async';
import 'dart:math';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:delta_team/features/auth/loadingScreens/loadingscreen_web.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_extension/riverpod_extension.dart';

class LoginField extends StatefulWidget {
  // final IconData suffixIcon;

  LoginField({
    super.key,

    // required this.suffixIcon
  });

  @override
  State<LoginField> createState() => _LoginFieldState();
}

class _LoginFieldState extends State<LoginField> {
  bool viewPassword = false;
  bool showErrorIcon = false;
  String errorMessage = '';
  bool emailNotExist = true;
  final _signInKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Color labelEmailColor = Colors.grey;

  Future<bool> userExist(String email) async {
    try {
      final user =
          await Amplify.Auth.signIn(username: email, password: "Password1!");
    } catch (error) {
      if (!error.toString().contains("UserNotFoundException") &&
          !error.toString().contains("AuthException")) {
        setState(() {
          emailNotExist = true;
        });
        print(error);
        print("ERR");
      } else {
        setState(() {
          emailNotExist = false;
        });
        print(error);
      }
    }
    return false;
  }

  Future<bool> usersignIn(String email, String password) async {
    try {
      final result =
          await Amplify.Auth.signIn(username: email, password: password);

      if (result.isSignedIn) {
        safePrint('User Logged In');
        Navigator.pushNamed(context, LoadingScreenWeb.routeName);
        return true;
      }
    } catch (error) {
      // print(error.toString());
    }
    return false;
  }

  // // Future<bool> usersignIn(String email, String password) async {
  // //   try {
  // //     final result =
  // //         await Amplify.Auth.signIn(username: email, password: password);
  // //     if (result.isSignedIn) {
  // //       safePrint('User Logged In');
  // //       Navigator.pushNamed(context, LoadingScreenWeb.routeName);
  // //       return true;
  // //     }
  // //   } catch (error) {
  // //     if (error.toString().contains("UserNotFoundException")) {
  // //       setState(() {
  // //         emailNotExist = false;
  // //       });
  // //       print("A");
  // //     } else {
  // //       setState(() {
  // //         emailNotExist = true;
  // //       });
  // //       print("B");
  // //     }
  // //     print(error.toString());
  // //   }
  // //   return false;
  // // }

  // FutureOr<bool> usersignIn(String email, String password) async {
  //   try {
  //     final result =
  //         await Amplify.Auth.signIn(username: email, password: password);
  //     if (result.isSignedIn) {
  //       safePrint('User Logged In');
  //       Navigator.pushNamed(context, LoadingScreenWeb.routeName);
  //       return true;
  //     }
  //   } on AuthException catch (error) {
  //     setState(() {
  //       errorMessage = error.message;
  //     });
  //     return false;
  //   } on HttpException catch (e) {
  //     final response = e.response;
  //     if (response.statusCode == 400) {
  //       setState(() {
  //         errorMessage = 'Please enter a valid email or password';
  //       });
  //       return false;
  //     } else {
  //       setState(() {
  //         errorMessage = 'Sign in failed';
  //       });
  //       return false;
  //     }
  //   }
  //   setState(() {
  //     errorMessage = 'Sign in failed';
  //   });
  //   return false;
  // }

  @override
  Widget build(BuildContext context) {
    bool passwordObscured = true;
    bool emailErrored = false;
    bool passwordErrored = false;
    String passwordError = '';
    bool isButtonPressed = false;

    double width = MediaQuery.of(context).size.width;
    return Form(
      key: _signInKey,
      child: Column(
        children: [
          TextFormField(
            key: const Key("emailKey"),
            controller: emailController,
            style: GoogleFonts.notoSans(fontWeight: FontWeight.w500),
            validator: (value) {
              if (value!.isEmpty) {
                showErrorIcon = true;

                return 'Please fill the required field.';
              } else if (!EmailValidator.validate(value)) {
                setState(() {
                  passwordErrored = true;
                  emailErrored = true;
                  showErrorIcon = true;
                  emailNotExist = false;
                });
              } else if (!emailNotExist) {
                setState(() {
                  emailErrored = true;
                  showErrorIcon = true;
                  passwordErrored = true;
                });
              }
              if (passwordErrored && passwordController.text.isNotEmpty) {
                return "";
              }
              setState(() {
                emailErrored = false;
                showErrorIcon = false;
              });
              return null;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              label: Text(
                "Email",
                style: GoogleFonts.notoSans(fontSize: 14),
              ),
              suffixIcon: showErrorIcon
                  ? const Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 18,
                    )
                  : null,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            key: const Key("passwordKey"),
            controller: passwordController,
            obscureText: !viewPassword,
            style: GoogleFonts.notoSans(fontWeight: FontWeight.w500),
            validator: (value) {
              String regex =
                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
              RegExp regExp = RegExp(regex);
              if (value!.isEmpty) {
                setState(() {
                  passwordErrored = true;
                });
                return 'Please fill the required field.';
              } else if (!regExp.hasMatch(value) ||
                  emailErrored ||
                  !emailNotExist) {
                setState(() {
                  passwordErrored = true;
                });
                return "Username or email incorrect";
              } else {
                setState(() {
                  passwordErrored = false;
                });
              }
              if (emailErrored && emailController.text.isNotEmpty) {
                return "";
              }

              return null;
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                label: Text(
                  "Password",
                  style: GoogleFonts.notoSans(fontSize: 14),
                ),
                suffixIcon: InkWell(
                    key: const Key("passwordVisible"),
                    child: Icon(
                      viewPassword ? Icons.visibility : Icons.visibility_off,
                      color: viewPassword
                          ? Colors.black
                          : const Color.fromRGBO(96, 93, 102, 1),
                    ),
                    onTap: () {
                      setState(() {
                        viewPassword = !viewPassword;
                      });
                    })),
          ),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            height: 56,
            width: (452 / 1440) * width,
            child: ElevatedButton(
              key: const Key('Login_Button'),
              onPressed: () async {
                await userExist(emailController.text);
                if (_signInKey.currentState!.validate()) {
                  usersignIn(emailController.text, passwordController.text);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              child: Text(
                "Login",
                style: GoogleFonts.notoSans(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: (16 / 1440) * width,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
