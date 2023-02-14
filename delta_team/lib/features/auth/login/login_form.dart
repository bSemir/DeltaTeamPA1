import 'dart:async';
import 'dart:math';

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
  bool emailExists = true;
  final _signInKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Color labelEmailColor = Colors.grey;
  final FocusNode _focusEmailNode = FocusNode();

  Future<bool> userExist(String email) async {
    try {
      final user =
          await Amplify.Auth.signIn(username: email, password: "Password1!");
    } catch (error) {
      if (!error.toString().contains("User does not exist.")) {
        setState(() {
          emailExists = true;
        });
        print(error.toString());
        print("a");
      } else {
        setState(() {
          emailExists = false;
        });
        print(emailExists);
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
      print(error.toString());
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
  // //         emailExists = false;
  // //       });
  // //       print("A");
  // //     } else {
  // //       setState(() {
  // //         emailExists = true;
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

    void togglePasswordObscure() {
      setState(() {
        passwordObscured = !passwordObscured;
      });
    }

    void _onFocusChange() {
      debugPrint("Focus: ${_focusEmailNode.hasFocus.toString()}");
    }

    void initState() {
      super.initState();
      _focusEmailNode.addListener(_onFocusChange);
    }

    void dispose() {
      super.dispose();
      _focusEmailNode.removeListener(_onFocusChange);
      _focusEmailNode.dispose();
    }

    double width = MediaQuery.of(context).size.width;
    return Form(
      key: _signInKey,
      child: Column(
        children: [
          TextFormField(
            key: const Key("emailKey"),
            focusNode: _focusEmailNode,
            controller: emailController,
            style: GoogleFonts.notoSans(fontWeight: FontWeight.w500),
            validator: (value) {
              if (value!.isEmpty) {
                emailErrored = true;
                showErrorIcon = true;

                return 'Please fill the required field.';
              } else if (!EmailValidator.validate(value)) {
                setState(() {
                  emailErrored = true;
                  showErrorIcon = true;
                  emailExists = false;
                });
                return "Enter the valid email";
              } else if (!emailExists) {
                setState(() {
                  emailErrored = true;
                  showErrorIcon = true;
                });
                return "Email does not exists!";
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
                style: GoogleFonts.notoSans(
                    color:
                        _focusEmailNode.hasFocus ? Colors.green : Colors.grey,
                    fontSize: 14),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(34, 233, 116, 1)),
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
              } else if (!regExp.hasMatch(value)) {
                setState(() {
                  passwordErrored = true;
                });
                return 'Password must contain a minimum of 8 characters, \nuppercase, lower case, number and special character.';
              } else {
                setState(() {
                  passwordErrored = false;
                });
              }
              return null;
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                label: Text(
                  "Password",
                  style: GoogleFonts.notoSans(
                      color:
                          _focusEmailNode.hasFocus ? Colors.green : Colors.grey,
                      fontSize: 14),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(34, 233, 116, 1)),
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
                userExist(emailController.text);
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
