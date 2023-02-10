import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:delta_team/common/appbar_web.dart';
import 'package:delta_team/common/custom_button.dart';
import 'package:delta_team/common/customfooter_web.dart';
import 'package:delta_team/features/auth/loadingScreens/loadingscreen_mobile.dart';
import 'package:delta_team/features/auth/loadingScreens/loadingscreen_web.dart';
import 'package:delta_team/features/auth/login/login_form.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:riverpod_extension/riverpod_extension.dart';

class MyDesktopBody extends StatefulWidget {
  const MyDesktopBody({super.key});

  @override
  _MyDesktopBodyState createState() => _MyDesktopBodyState();
}

class _MyDesktopBodyState extends State<MyDesktopBody> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool passwordObscured = true;
  String errorMessage = 'Incorrect email or password';

  void togglePasswordObscure() {
    setState(() {
      passwordObscured = !passwordObscured;
    });
  }

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
          safePrint('User Logged In');
          Navigator.pushNamed(context, LoadingScreenWeb.routeName);
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

  // Future<void> userLogin(
  //     BuildContext context, String username, String password) async {
  //   if (username.isEmpty || password.isEmpty) {
  //     (() {
  //       errorMessage = 'Username and password cannot be empty';
  //     });
  //   } else {
  //     try {
  //       await Amplify.Auth.signIn(username: username, password: password);
  //       Navigator.pushNamed(context, '/home');
  //     } on AuthException catch (error) {
  //       (() {
  //         errorMessage = error.message;
  //       });
  //     }
  //   }
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
              key: const Key('Not_routed_to_SignUpPage'),
              text: 'Sign Up',
              press: () {},
              color: const Color(0xFF000000),
              textColor: Colors.white,
              borderColor: Colors.black)),
      backgroundColor: const Color(0xFFE9E9E9),
      body: SingleChildScrollView(
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
                        height: 228,
                        width: (452 / 1440) * width,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomEmailField(
                                key: const Key('email_field'),
                                controller: username,
                                showErrorIcon: username.text.isNotEmpty &&
                                    !username.text.contains("@"),
                                // &&
                                // !username.text.endsWith(".com"),
                                text: 'Email',
                              ),
                              CustomPasswordField(
                                key: const Key(
                                    'Password_field_Unreveal_Password'),
                                controller: password,
                                hintText: 'Password',
                                obscureText: passwordObscured,
                              ),
                              SizedBox(
                                height: 56,
                                width: (452 / 1440) * width,
                                child: ElevatedButton(
                                  key: const Key('Login_Button'),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      usersignIn(context, username.text,
                                          password.text);

                                      //   // final _authProvider =
                                      //   //     provider.Provider.of<AuthenticationProvider>(
                                      //   //         context,
                                      //   //         listen: false);
                                      //   // _authProvider.signIn(
                                      //   //   username as String,
                                      //   //   password as String,
                                      //   //   context,
                                      //   //   HomeRoute as String,
                                      //   // );
                                    }
                                  },

                                  // signIn;
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => const HomeRoute()));
                                  //   }
                                  // },
                                  // Add your login logic here

                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                  ),
                                  child: Text(
                                    "Login",
                                    style: GoogleFonts.notoSans(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                      fontSize: (15 / 1440) * width,
                                    ),
                                  ),
                                ),
                              ),
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
    );
  }
}
