import 'dart:async';
import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:delta_team/common/appbar_web.dart';
import 'package:delta_team/features/auth/login/login_web/loginform_web.dart';
import 'package:delta_team/common/custom_button.dart';
import 'package:email_validator/email_validator.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_extension/riverpod_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/footer/footer.dart';
import '../../../homepage/homepage_sidebar.dart';
import '../loadingScreens/loadingscreen_web.dart';

class LoginScreenWeb extends StatefulWidget {
  static const routeName = '/loginmobileWeb';
  const LoginScreenWeb({Key? key}) : super(key: key);

  @override
  LoginScreenWebState createState() => LoginScreenWebState();
}

class LoginScreenWebState extends State<LoginScreenWeb> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _loadingLogin = false;
  bool _showPasswordSuffixIcon = false;
  bool viewPassword = false;
  bool showErrorIcon = false;
  String errorMessage = '';
  bool emailNotExist = true;
  bool canLogIn = false;
  bool _isFocusedPassword = false;
  bool _isFocusedEmail = false;

  final _passwordFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _signInKey = GlobalKey<FormState>();

  Color labelEmailColor = const Color(0xFF605D66);
  Color labelPasswordColor = const Color(0xFF605D66);
  Color eyelid = const Color(0xFF000000);
  Color labelEmailFocusColor = const Color(0xFF22E974);
  Color labelPasswordFocusColor = const Color(0xFF22E974);

  @override
  void dispose() {
    super.dispose();
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    _focusNode.dispose();
  }

  dynamic token = '';

  @override
  void initState() {
    _loadingLogin = false;
    varijablaRola.clear();
    _loadPrefs();
    // Add a listener to the focus node to update the _isFocused variable
    _passwordFocusNode.addListener(() {
      setState(() {
        _isFocusedPassword = _passwordFocusNode.hasFocus;
      });
    });

    _emailFocusNode.addListener(() {
      setState(() {
        _isFocusedEmail = _emailFocusNode.hasFocus;
      });
    });
    super.initState();
  }

  Future<void> _loadPrefs() async {
    dynamic tokenStr = await FlutterSession().get("token");
    final prefs = await SharedPreferences.getInstance();

    final emailExist = prefs.getString("email");
    final getRoute = prefs.getString("route");
    if (emailExist!.contains("@")) {
      Navigator.pushReplacementNamed(context, getRoute!);
    }

    setState(() {
      token = tokenStr;
    });
  }

  Map<String, dynamic> lectures = {};

  Future<Map<String, dynamic>> getUserLectures() async {
    // signInUser();
    try {
      final restOperation = Amplify.API.get('/api/user/lectures',
          apiName: 'getUserLectures', queryParameters: {'paDate': 'Jan2023'});
      final response = await restOperation.response;

      Map<String, dynamic> responseMap = jsonDecode(response.decodeBody());
      setState(() {
        lectures = responseMap;
      });
      return responseMap;
    } on ApiException catch (e) {
      throw Exception('Failed to load lectures: $e');
    }
  }

  String nameUser = '';
  String email = '';
  bool emailErrored = false;
  bool passwordErrored = false;

  String surname = '';

  Future<bool> logUserIn(String email, String password) async {
    try {
      setState(() {
        _loadingLogin = true;
      });
      final user =
          await Amplify.Auth.signIn(username: email, password: password);

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
      setState(() {
        _loadingLogin = false;
      });
    }
    return false;
  }

  Future<void> fetchCurrentUserAttributes() async {
    try {
      final result = await Amplify.Auth.fetchUserAttributes();
      for (final element in result) {
        // print('key: ${element.userAttributeKey}; value: ${element.value}');
        if (element.userAttributeKey.key == "email") {
          setState(() {
            email = element.value;
          });
        }
        if (element.userAttributeKey.key == "given_name") {
          setState(() {
            nameUser = element.value;
          });
        }
        if (element.userAttributeKey.key == "family_name") {
          setState(() {
            surname = element.value;
          });
        }
      }
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  final ScrollController _controller = ScrollController();
  final FocusNode _focusNode = FocusNode();

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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(
          title: 'Tech387',
          leading: SvgPicture.asset('assets/images/logo.svg'),
          action: RoundedButton(
            key: const Key('SignUpPage_homepage'),
            text: 'Sign Up',
            press: () {
              _loadingLogin ? null : Navigator.pushNamed(context, '/signupWeb');
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
                      SvgPicture.asset(
                        'assets/images/logotop.svg',
                        width: ((99.7 / 1440) * width).clamp(50, 100),
                      ),
                      const SizedBox(
                        height: 17,
                      ),
                      SelectableText.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: 'Welcome to',
                                style: GoogleFonts.notoSans(
                                  fontSize: ((48 / 1440) * width).clamp(38, 48),
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                )),
                          ],
                        ),
                      ),
                      SelectableText.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: 'Product Arena',
                                style: GoogleFonts.notoSans(
                                  fontSize: ((48 / 1440) * width).clamp(38, 48),
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                )),
                          ],
                        ),
                      ),
                      SelectableText.rich(
                        TextSpan(
                          text: 'All great things take time to accomplish',
                          style: GoogleFonts.notoSans(
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF605D66),
                            fontSize: ((48 / 1440) * width).clamp(16, 32),
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
                              children: [
                                Form(
                                  key: _signInKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        key: const Key("emailKey"),
                                        focusNode: _emailFocusNode,
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
                                              labelEmailColor =
                                                  const Color(0xFFB3261E);
                                              labelEmailFocusColor =
                                                  const Color(0xFFB3261E);
                                            });

                                            return 'Please fill the required field.';
                                          } else if ((!EmailValidator.validate(
                                                      value) &&
                                                  !canLogIn) &&
                                              passwordController
                                                  .text.isNotEmpty) {
                                            setState(() {
                                              labelEmailFocusColor =
                                                  const Color(0xFFB3261E);
                                              labelEmailColor =
                                                  const Color(0xFFB3261E);
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
                                              labelEmailColor =
                                                  const Color(0xFFB3261E);
                                              labelEmailFocusColor =
                                                  const Color(0xFFB3261E);
                                            });
                                          }
                                          if (passwordController.text.isEmpty &&
                                              emailController.text.isNotEmpty) {
                                            setState(() {
                                              labelEmailColor =
                                                  const Color(0xFF000000);
                                            });
                                          }

                                          if (canLogIn) {
                                            setState(() {
                                              labelEmailColor =
                                                  const Color(0xFF000000);
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
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          filled: true,
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFF22E974)),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: labelEmailColor),
                                          ),
                                          disabledBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          Color(0xFF605D66))),
                                          label: Text(
                                            "Email",
                                            style: GoogleFonts.notoSans(
                                                color: _isFocusedEmail
                                                    ? labelEmailFocusColor
                                                    : labelEmailColor,
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
                                        focusNode: _passwordFocusNode,
                                        controller: passwordController,
                                        obscureText: !viewPassword,
                                        style: GoogleFonts.notoSans(
                                          color: labelPasswordColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            _showPasswordSuffixIcon =
                                                value.isNotEmpty;
                                          });
                                        },
                                        validator: (value) {
                                          String regex =
                                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                                          RegExp regExp = RegExp(regex);

                                          if (value!.isEmpty) {
                                            setState(() {
                                              passwordErrored = true;
                                              labelPasswordFocusColor =
                                                  const Color(0xFFB3261E);
                                              labelPasswordColor =
                                                  const Color(0xFFB3261E);
                                              eyelid = const Color(0xFFB3261E);
                                            });
                                            return 'Please fill the required field.';
                                          } else if ((!regExp.hasMatch(value) ||
                                                  emailErrored ||
                                                  !canLogIn) &&
                                              emailController.text.isNotEmpty) {
                                            setState(() {
                                              labelPasswordFocusColor =
                                                  const Color(0xFFB3261E);
                                              labelPasswordColor =
                                                  const Color(0xFFB3261E);
                                              eyelid = const Color(0xFFB3261E);
                                              labelEmailColor =
                                                  const Color(0xFFB3261E);
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
                                              passwordController
                                                  .text.isNotEmpty) {
                                            setState(() {
                                              labelPasswordColor =
                                                  const Color(0xFF000000);
                                              eyelid = const Color(0xFF000000);
                                            });
                                          }
                                          if (canLogIn ||
                                              emailController.text.isNotEmpty) {
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
                                            focusedBorder:
                                                const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            Color(0xFF22E974))),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            filled: true,
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: labelEmailColor),
                                            ),
                                            disabledBorder:
                                                const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            Color(0xFF605D66))),
                                            label: Text(
                                              "Password",
                                              style: GoogleFonts.notoSans(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                                color: _isFocusedPassword
                                                    ? labelPasswordFocusColor
                                                    : labelPasswordColor,
                                              ),
                                            ),
                                            suffixIcon: _showPasswordSuffixIcon
                                                ? InkWell(
                                                    key: const Key(
                                                        "passwordVisible"),
                                                    child: Icon(
                                                        viewPassword
                                                            ? Icons.visibility
                                                            : Icons
                                                                .visibility_off,
                                                        color: eyelid),
                                                    onTap: () {
                                                      setState(() {
                                                        viewPassword =
                                                            !viewPassword;
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
                                        child: _loadingLogin
                                            ? const Center(
                                                child: SpinKitRing(
                                                  color: Colors.black,
                                                  size: 36,
                                                  lineWidth: 6,
                                                ),
                                              )
                                            : ElevatedButton(
                                                key: const Key('Login_Button'),
                                                onPressed: () async {
                                                  await logUserIn(
                                                      emailController.text,
                                                      passwordController.text);
                                                  if (_signInKey.currentState!
                                                      .validate()) {
                                                    if (canLogIn) {
                                                      await getUserLectures();
                                                      await fetchCurrentUserAttributes();
                                                      SharedPreferences prefs =
                                                          await SharedPreferences
                                                              .getInstance();

                                                      prefs.setBool(
                                                          'isSelectedHome',
                                                          true);
                                                      prefs.setBool(
                                                          'isSelectedContact',
                                                          false);
                                                      prefs.setBool(
                                                          'isSelectedRecent',
                                                          false);
                                                      prefs.setBool(
                                                          'isSelectedFirstRole',
                                                          false);
                                                      prefs.setBool(
                                                          'isSelectedSecondRole',
                                                          false);
                                                      prefs.setInt(
                                                          "selectedIndex", -1);
                                                      setState(() {
                                                        isSelectedHome = true;
                                                        isSelectedRecent =
                                                            false;
                                                        isSelectedContact =
                                                            false;
                                                        isSelectedFirstRole =
                                                            false;
                                                        isSelectedSecondRole =
                                                            false;
                                                        selectedIndex = -1;
                                                      });

                                                      String jsonLectures =
                                                          json.encode(lectures);
                                                      await prefs.setString(
                                                          'lecturesPrefs',
                                                          jsonLectures);
                                                      await prefs.setString(
                                                          'email', email);
                                                      await prefs.setString(
                                                          'nameUser', nameUser);
                                                      await prefs.setString(
                                                          'surname', surname);
                                                      await FlutterSession()
                                                          .set("token", email);
                                                      Navigator
                                                          .pushReplacementNamed(
                                                              context,
                                                              '/homepage');
                                                    }
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        _loadingLogin
                                                            ? Colors.grey
                                                            : const Color(
                                                                0xFF000000)),
                                                child: Text(
                                                  "Login",
                                                  style: GoogleFonts.notoSans(
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 38,
              ),
              const Footer()
            ],
          ),
        ),
      ),
    );
  }
}
