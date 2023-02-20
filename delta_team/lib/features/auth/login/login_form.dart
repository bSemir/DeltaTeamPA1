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

  const LoginField({
    super.key,

    // required this.suffixIcon
  });

  @override
  State<LoginField> createState() => _LoginFieldState();
}

class _LoginFieldState extends State<LoginField> {
  bool _showPasswordSuffixIcon = false;
  bool viewPassword = false;
  bool showErrorIcon = false;
  String errorMessage = '';
  bool emailNotExist = true;

  bool canLogIn = false;

  final _signInKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Color labelEmailColor = const Color(0xFF605D66);
  Color labelPasswordColor = const Color(0xFF605D66);
  Color eyelid = const Color(0xFF000000);

  Future<bool> logUserIn(String email, String password) async {
    try {
      final user =
          await Amplify.Auth.signIn(username: email, password: password);
      print('successful');
      setState(() {
        canLogIn = user.isSignedIn;
      });
    } catch (error) {
      if (!error.toString().contains("UserNotFoundException") &&
          !error.toString().contains("underlyingException")) {
        setState(() {
          emailNotExist = true;
        });
      } else {
        setState(() {
          emailNotExist = false;
        });
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    bool emailErrored = false;
    bool passwordErrored = false;

    double width = MediaQuery.of(context).size.width;
    return Form(
      key: _signInKey,
      child: Column(
        children: [
          TextFormField(
            key: const Key("emailKey"),
            controller: emailController,
            style: GoogleFonts.notoSans(
              color: labelEmailColor,
              fontWeight: FontWeight.w700,
            ),
            validator: (value) {
              if (value!.isEmpty) {
                setState(() {
                  showErrorIcon = true;
                  emailErrored = true;
                  labelEmailColor = const Color(0xFFB3261E);
                });

                return 'Please fill the required field.';
              } else if ((!EmailValidator.validate(value) && !canLogIn) &&
                  passwordController.text.isNotEmpty) {
                setState(() {
                  labelEmailColor = const Color(0xFFB3261E);
                  passwordErrored = true;
                  emailErrored = true;
                  showErrorIcon = true;
                  emailNotExist = false;
                });
                return '';
              } else if (!emailNotExist) {
                setState(() {
                  emailErrored = true;
                  showErrorIcon = true;
                  passwordErrored = true;
                  labelEmailColor = const Color(0xFFB3261E);
                });
              }
              if (passwordController.text.isEmpty &&
                  emailController.text.isNotEmpty) {
                setState(() {
                  labelEmailColor = const Color(0xFF000000);
                });
              }

              if (canLogIn) {
                setState(() {
                  labelEmailColor = const Color(0xFF000000);
                  passwordErrored = false;
                  emailErrored = false;
                  showErrorIcon = false;
                });
                return null;
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
              filled: true,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              floatingLabelStyle: TextStyle(
                color: labelEmailColor,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                fontFamily: GoogleFonts.notoSans().fontFamily,
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF000000)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: labelEmailColor),
              ),
              disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF605D66))),
              label: Text(
                "Email",
                style: GoogleFonts.notoSans(
                    color: labelEmailColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w700),
              ),
              suffixIcon: showErrorIcon
                  ? const Icon(
                      Icons.error,
                      color: Color(0xFFB3261E),
                      size: 24,
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
            style: GoogleFonts.notoSans(
              color: labelPasswordColor,
              fontWeight: FontWeight.w700,
            ),
            onChanged: (value) {
              setState(() {
                _showPasswordSuffixIcon = value.isNotEmpty;
              });
            },
            validator: (value) {
              String regex =
                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
              RegExp regExp = RegExp(regex);

              if (value!.isEmpty) {
                setState(() {
                  passwordErrored = true;
                  labelPasswordColor = const Color(0xFFB3261E);
                  eyelid = const Color(0xFFB3261E);
                });
                return 'Please fill the required field.';
              } else if ((!regExp.hasMatch(value) ||
                      emailErrored ||
                      !canLogIn) &&
                  emailController.text.isNotEmpty) {
                setState(() {
                  labelPasswordColor = const Color(0xFFB3261E);
                  eyelid = const Color(0xFFB3261E);
                  labelEmailColor = const Color(0xFFB3261E);
                  emailErrored = true;
                  passwordErrored = true;
                  showErrorIcon = true;
                });
                return "Incorrect email or password";
              } else {
                setState(() {
                  passwordErrored = false;
                });
              }
              if (emailController.text.isEmpty &&
                  passwordController.text.isNotEmpty) {
                setState(() {
                  labelPasswordColor = const Color(0xFF000000);
                  eyelid = const Color(0xFF000000);
                });
              }
              if (canLogIn || emailController.text.isNotEmpty) {
                print("LOGIN");
                setState(() {
                  passwordErrored = false;
                  emailErrored = false;
                  showErrorIcon = false;
                });
                return null;
              }

              return null;
            },
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: labelPasswordColor)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                floatingLabelStyle: TextStyle(
                  color: labelPasswordColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontFamily: GoogleFonts.notoSans().fontFamily,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: labelEmailColor),
                ),
                disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF605D66))),
                label: Text(
                  "Password",
                  style: GoogleFonts.notoSans(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: labelPasswordColor),
                ),
                suffixIcon: _showPasswordSuffixIcon
                    ? InkWell(
                        key: const Key("passwordVisible"),
                        child: Icon(
                            viewPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: eyelid),
                        onTap: () {
                          setState(() {
                            viewPassword = !viewPassword;
                          });
                        })
                    : null),
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
                await logUserIn(emailController.text, passwordController.text);
                if (_signInKey.currentState!.validate()) {
                  if (canLogIn) {
                    print('successful');
                    Navigator.pushNamed(context, LoadingScreenWeb.routeName);
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF000000)),
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
