import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:delta_team/common/appbar_web.dart';
import 'package:delta_team/common/custom_button.dart';
import 'package:delta_team/common/customfooter_web.dart';
import 'package:delta_team/features/auth/loadingScreens/loadingscreen_web.dart';
import 'package:delta_team/features/auth/login/login_form.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:riverpod_extension/riverpod_extension.dart';

class MyDesktopBody extends StatefulWidget {
  const MyDesktopBody({Key? key}) : super(key: key);

  @override
  MyDesktopBodyState createState() => MyDesktopBodyState();
}

class MyDesktopBodyState extends State<MyDesktopBody> {
  final ScrollController _controller = ScrollController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handleKeyEvent(RawKeyEvent event) {
    var offset = _controller.offset; //Getting current position
    if (event.logicalKey.debugName == "Arrow Down") {
      setState(() {
        if (kReleaseMode) {
          //This block only runs when the application was compiled in release mode.
          _controller.animateTo(offset + 50,
              duration: const Duration(milliseconds: 200), curve: Curves.ease);
        } else {
          // This will only print useful information in debug mode.
          // print(_controller.position); to get information..
          _controller.animateTo(offset + 50,
              duration: const Duration(milliseconds: 200), curve: Curves.ease);
        }
      });
    } else if (event.logicalKey.debugName == "Arrow Up") {
      setState(() {
        if (kReleaseMode) {
          _controller.animateTo(offset - 50,
              duration: const Duration(milliseconds: 200), curve: Curves.ease);
        } else {
          _controller.animateTo(offset - 50,
              duration: const Duration(milliseconds: 200), curve: Curves.ease);
        }
      });
    }
  }

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

  FutureOr<bool> usersignIn(
      BuildContext context, String email, String password) async {
    try {
      final result =
          await Amplify.Auth.signIn(username: email, password: password);
      if (result.isSignedIn) {
        safePrint('User Logged In');
        Navigator.pushNamed(context, LoadingScreenWeb.routeName);
        return true;
      }
    } on AuthException catch (error) {
      setState(() {
        errorMessage = error.message;
      });
      safePrint(errorMessage);

      return false;
    } on HttpException catch (e) {
      final response = e.response;
      if (response.statusCode == 400) {
        setState(() {
          errorMessage = 'Please enter a valid email or password';
        });
        return false;
      } else {
        setState(() {
          errorMessage = 'Sign in failed';
        });
        return false;
      }
    }
    setState(() {
      errorMessage = 'Sign in failed';
    });
    return false;
  }
  // FutureOr<bool> usersignIn(
  //     BuildContext context, String email, String password) async {
  //   if (email.isEmpty || password.isEmpty) {
  //     setState(() {
  //       errorMessage = 'Incorrect email or password';
  //     });
  //     return Future.value(false);
  //   } else {
  //     try {
  //       final result =
  //           await Amplify.Auth.signIn(username: email, password: password);
  //       if (result.isSignedIn) {
  //         safePrint('User Logged In');
  //         Navigator.pushNamed(context, LoadingScreenWeb.routeName);
  //         return Future.value(true);
  //       }
  //     } on AuthException catch (error) {
  //       setState(() {
  //         errorMessage = error.message;
  //       });
  //       return Future.value(false);
  //     } on HttpException catch (e) {
  //       final response = e.response;
  //       if (response.statusCode == 400) {
  //         setState(() {
  //           errorMessage = 'Please enter a valid email or password';
  //         });
  //         return Future.value(false);
  //       } else {
  //         setState(() {
  //           errorMessage = 'Sign in failed';
  //         });
  //         return Future.value(false);
  //       }
  //     }
  //   }
  //   return Future.value(false);
  // }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(
          title: 'Tech387',
          leading: Image.asset('assets/images/logo.png'),
          action: RoundedButton(
            key: const Key('SignUpPage_homepage'),
            text: 'Sign Up',
            press: () async {
              Navigator.pushNamed(context, LoadingScreenWeb.routeName);
            },
            color: const Color(0xFF000000),
            textColor: Colors.white,
            borderColor: Colors.black,
            borderSide: const BorderSide(width: 1, color: Color(0xFF000000)),
          )),
      backgroundColor: const Color(0xFFE9E9E9),
      body: RawKeyboardListener(
        autofocus: true,
        focusNode: _focusNode,
        onKey: _handleKeyEvent,
        child: SingleChildScrollView(
          controller: _controller,
          child: Column(
            children: [
              SizedBox(
                  height: 965,
                  width: width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 185,
                      ),
                      Image.asset('assets/images/logotop.png'),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: 'Welcome to',
                                style: GoogleFonts.notoSans(
                                  fontSize: (48 / 1440) * width,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                )),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: 'Product Arena',
                                style: GoogleFonts.notoSans(
                                  fontSize: (48 / 1440) * width,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                )),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'All great things take time to accomplish',
                          style: GoogleFonts.notoSans(
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF605D66),
                            fontSize: (32 / 1440) * width,
                          ),
                        ),
                      ),
                      const SizedBox(height: 75.0),
                      Form(
                        key: _formKey,
                        child: SizedBox(
                          // height: 228,
                          width: (452 / 1440) * width,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                LoginField(),

                                // CustomEmailField(
                                //   key: const Key('email_field'),
                                //   controller: username,
                                //   showErrorIcon: username.text.isNotEmpty &&
                                //       !username.text.contains("@") &&
                                //       !username.text.endsWith(".com"),
                                //   text: 'Email',
                                // ),
                                // CustomPasswordField(
                                //   key: const Key(
                                //       'Password_field_Unreveal_Password'),
                                //   controller: password,
                                //   hintText: 'Password',
                                //   obscureText: passwordObscured,
                                // ),
                                // ignore: unnecessary_null_comparison
                                // if (errorMessage != null)
                                //   Container(
                                //     // margin: const EdgeInsets.only(top: 2.0),
                                //     child: Text(
                                //       errorMessage,
                                //       style: const TextStyle(
                                //         color: Colors.red,
                                //         fontSize: 10.0,
                                //       ),
                                //     ),
                                //   ),
                                // SizedBox(
                                //   height: 56,
                                //   width: (452 / 1440) * width,
                                //   child: ElevatedButton(
                                //     key: const Key('Login_Button'),
                                //     onPressed: () async {
                                //       if (_formKey.currentState!.validate()) {
                                //         usersignIn(context, username.text,
                                //             password.text);
                                //       }
                                //     },
                                //     style: ElevatedButton.styleFrom(
                                //       backgroundColor: Colors.black,
                                //     ),
                                //     child: Text(
                                //       "Login",
                                //       style: GoogleFonts.notoSans(
                                //         fontWeight: FontWeight.w700,
                                //         color: Colors.white,
                                //         fontSize: (16 / 1440) * width,
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ]),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 198,
              ),
              const FooterWidget()
            ],
          ),
        ),
      ),
    );
  }
}
