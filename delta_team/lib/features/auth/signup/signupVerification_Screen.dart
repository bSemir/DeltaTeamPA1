import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:delta_team/features/auth/signup/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../common/custom_button.dart';
import '../../footer/footer.dart';

class SignupVerificationScreen extends StatefulWidget {
  const SignupVerificationScreen({super.key});

  @override
  State<SignupVerificationScreen> createState() =>
      _SignupVerificationScreenState();
}

class _SignupVerificationScreenState extends State<SignupVerificationScreen> {
  final _code1 = TextEditingController();
  final _code2 = TextEditingController();
  final _code3 = TextEditingController();
  final _code4 = TextEditingController();
  final _code5 = TextEditingController();
  final _code6 = TextEditingController();
  final _emailVerificationKey = GlobalKey<FormState>();

  Color errorColor = Color.fromARGB(255, 255, 0, 0);

  bool isNumberCorrect = true;
  bool isPressed = true;
  bool codeError = false;
  bool canSendCode = true;
  bool notSendCodeAgainPressed = false;

  String code1Str = "";
  String code2Str = "";
  String code3Str = "";
  String code4Str = "";
  String code5Str = "";
  String code6Str = "";
  String code = "";

  //////
  Future<void> sendMessage(email) async {
    try {
      await Amplify.Auth.resendSignUpCode(username: email);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Confirmation code resent. Check your email",
            style: GoogleFonts.notoSans(fontSize: 15, color: Colors.white),
          ),
        ),
      );
    } on AuthException catch (e) {
      safePrint(e.message);
    }
  }

//////
  int counter = 20;
  int clickCounter = 0;

  void _startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (counter > 0) {
          counter--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  double? screenWidth;
  double? screenHeight;
  @override
  Widget build(BuildContext context) {
    screenWidth ??= MediaQuery.of(context).size.width;
    screenHeight ??= MediaQuery.of(context).size.height;
    final emailProvider = Provider.of<MyEmail>(context, listen: false);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/paBackground.png"),
                    fit: BoxFit.cover),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 50),
                child: Form(
                  key: _emailVerificationKey,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    width: MediaQuery.of(context).size.width * 0.50,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.10,
                          right: MediaQuery.of(context).size.width * 0.10,
                          top: 30,
                          bottom: 30),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 184,
                          ),
                          Image.asset("assets/images/paLogoWhite.png"),
                          const Text(
                            "Just to be sure...",
                            style: TextStyle(fontSize: 60),
                          ),
                          const Text(
                            "We've sent a 6-digit code to your e-mail",
                            style: TextStyle(fontSize: 32, color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 36,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.04,
                                height:
                                    MediaQuery.of(context).size.height * 0.065,
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      code1Str = value;
                                    });

                                    if (value.length == 1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },
                                  controller: _code1,
                                  key: const Key("code1Key"),
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 25),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(64, 61, 59, 1),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide(
                                        color: codeError &&
                                                isPressed &&
                                                notSendCodeAgainPressed
                                            ? errorColor
                                            : Color.fromARGB(
                                                255, 126, 116, 116),
                                      ),
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: codeError &&
                                            isPressed &&
                                            notSendCodeAgainPressed
                                        ? errorColor
                                        : const Color.fromARGB(
                                            255, 121, 116, 126),
                                  ),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.04,
                                height:
                                    MediaQuery.of(context).size.height * 0.065,
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      code2Str = value;
                                    });

                                    if (value.length == 1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },
                                  controller: _code2,
                                  key: const Key("code2Key"),
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 25),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(64, 61, 59, 1),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide(
                                        color: codeError &&
                                                isPressed &&
                                                notSendCodeAgainPressed
                                            ? errorColor
                                            : const Color.fromARGB(
                                                255, 121, 116, 126),
                                      ),
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: codeError &&
                                            isPressed &&
                                            notSendCodeAgainPressed
                                        ? errorColor
                                        : const Color.fromARGB(
                                            255, 121, 116, 126),
                                  ),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.04,
                                height:
                                    MediaQuery.of(context).size.height * 0.065,
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      code3Str = value;
                                    });

                                    if (value.length == 1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },
                                  controller: _code3,
                                  key: const Key("code3Key"),
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 25),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(64, 61, 59, 1),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide(
                                        color: codeError &&
                                                isPressed &&
                                                notSendCodeAgainPressed
                                            ? errorColor
                                            : const Color.fromARGB(
                                                255, 121, 116, 126),
                                      ),
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: codeError &&
                                            isPressed &&
                                            notSendCodeAgainPressed
                                        ? errorColor
                                        : const Color.fromARGB(
                                            255, 121, 116, 126),
                                  ),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.04,
                                height:
                                    MediaQuery.of(context).size.height * 0.065,
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      code4Str = value;
                                    });

                                    if (value.length == 1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },
                                  controller: _code4,
                                  key: const Key("code4Key"),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 25),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(64, 61, 59, 1),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide(
                                        color: codeError &&
                                                isPressed &&
                                                notSendCodeAgainPressed
                                            ? errorColor
                                            : const Color.fromARGB(
                                                255, 121, 116, 126),
                                      ),
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: codeError &&
                                            isPressed &&
                                            notSendCodeAgainPressed
                                        ? errorColor
                                        : const Color.fromARGB(
                                            255, 121, 116, 126),
                                  ),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.04,
                                height:
                                    MediaQuery.of(context).size.height * 0.065,
                                child: TextFormField(
                                  controller: _code5,
                                  key: const Key("code5Key"),
                                  onChanged: (value) {
                                    setState(() {
                                      code5Str = value;
                                    });

                                    if (value.length == 1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 25),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(64, 61, 59, 1),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide(
                                        color: codeError &&
                                                isPressed &&
                                                notSendCodeAgainPressed
                                            ? errorColor
                                            : const Color.fromARGB(
                                                255, 121, 116, 126),
                                      ),
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: codeError &&
                                            isPressed &&
                                            notSendCodeAgainPressed
                                        ? errorColor
                                        : const Color.fromARGB(
                                            255, 121, 116, 126),
                                  ),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.04,
                                height:
                                    MediaQuery.of(context).size.height * 0.065,
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      code6Str = value;
                                    });

                                    if (value.length == 1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },
                                  controller: _code6,
                                  key: const Key("code6Key"),
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 25),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(64, 61, 59, 1),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide(
                                        color: codeError &&
                                                isPressed &&
                                                notSendCodeAgainPressed
                                            ? errorColor
                                            : const Color.fromARGB(
                                                255, 121, 116, 126),
                                      ),
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: codeError &&
                                            isPressed &&
                                            notSendCodeAgainPressed
                                        ? errorColor
                                        : const Color.fromARGB(
                                            255, 121, 116, 126),
                                  ),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                              ),
                            ],
                          ),
                          codeError
                              ? const Padding(
                                  padding: EdgeInsets.only(top: 25),
                                  child: Text(
                                    "Conformation code does not match",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.red),
                                  ),
                                )
                              : const SizedBox(
                                  height: 2,
                                ),
                          Padding(
                            padding: const EdgeInsets.only(top: 28),
                            child: SizedBox(
                              height: 56,
                              child: CustomButton(
                                key: const Key("verifyConfirmationKey"),
                                content: Text(
                                  "Verify",
                                  style: GoogleFonts.notoSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                buttonFunction: () async {
                                  if (clickCounter == 0) {
                                    _startTimer();
                                  }
                                  setState(() {
                                    notSendCodeAgainPressed = true;
                                  });
                                  setState(() {
                                    clickCounter++;
                                    isPressed = true;
                                    code = "";
                                    code += code1Str +
                                        code2Str +
                                        code3Str +
                                        code4Str +
                                        code5Str +
                                        code6Str;
                                  });
                                  if (code.length < 6) {
                                    setState(() {
                                      codeError = true;
                                    });
                                  }

                                  if (_emailVerificationKey.currentState!
                                      .validate()) {
                                    try {
                                      final result =
                                          await Amplify.Auth.confirmSignUp(
                                              username: emailProvider.email,
                                              confirmationCode: code);
                                      setState(() {
                                        codeError = !result.isSignUpComplete;
                                      });
                                      if (!codeError) {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        Navigator.pushNamed(
                                            context, "/confirmationMessage");
                                      }
                                    } on AuthException catch (e) {
                                      setState(() {
                                        codeError = true;
                                      });
                                      // if (e.message.toString().contains(
                                      //         "Confirmation code entered is not correct.") ||
                                      //     e.message.toString().contains(
                                      //         "One or more parameters are incorrect.")) {
                                      //   setState(() {
                                      //     codeError = true;
                                      //   });
                                      // } else {
                                      //   setState(() {
                                      //     codeError = false;
                                      //   });
                                      // }
                                    }
                                  }
                                },
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 12),
                            child: Column(
                              children: [
                                codeError && isPressed
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            key: const Key('sendCodeAgain'),
                                            onDoubleTap: () async {
                                              if (counter == 0 && codeError) {
                                                setState(() {
                                                  counter = 20;
                                                  notSendCodeAgainPressed =
                                                      false;
                                                  canSendCode = true;
                                                });

                                                _startTimer();
                                              } else if (counter == 0) {
                                                setState(() {
                                                  canSendCode = true;
                                                  notSendCodeAgainPressed =
                                                      false;
                                                });
                                              } else if (counter != 0) {
                                                setState(() {
                                                  canSendCode = false;
                                                  notSendCodeAgainPressed =
                                                      true;
                                                });
                                              }

                                              if (canSendCode) {
                                                _code1.clear();
                                                _code2.clear();
                                                _code3.clear();
                                                _code4.clear();
                                                _code5.clear();
                                                _code6.clear();
                                                sendMessage(
                                                    emailProvider.email);
                                              }
                                            },
                                            onTap: () async {
                                              if (counter == 0 && codeError) {
                                                setState(() {
                                                  counter = 20;
                                                  notSendCodeAgainPressed =
                                                      false;
                                                  canSendCode = true;
                                                });

                                                _startTimer();
                                              } else if (counter == 0) {
                                                setState(() {
                                                  canSendCode = true;
                                                  notSendCodeAgainPressed =
                                                      false;
                                                });
                                              } else if (counter != 0) {
                                                setState(() {
                                                  canSendCode = false;
                                                  notSendCodeAgainPressed =
                                                      true;
                                                });
                                              }

                                              if (canSendCode) {
                                                _code1.clear();
                                                _code2.clear();
                                                _code3.clear();
                                                _code4.clear();
                                                _code5.clear();
                                                _code6.clear();
                                                sendMessage(
                                                    emailProvider.email);
                                              }
                                            },
                                            child: Text(
                                              "Send code again",
                                              style: GoogleFonts.notoSans(
                                                fontWeight: FontWeight.w700,
                                                color: const Color.fromRGBO(
                                                    96, 93, 102, 1),
                                              ),
                                            ),
                                          ),
                                          counter > 9
                                              ? Text(
                                                  " 00:$counter",
                                                  style: GoogleFonts.notoSans(
                                                    fontWeight: FontWeight.w400,
                                                    color: const Color.fromRGBO(
                                                        96, 93, 102, 1),
                                                  ),
                                                )
                                              : Text(
                                                  " 00:0$counter",
                                                  style: GoogleFonts.notoSans(
                                                    fontWeight: FontWeight.w400,
                                                    color: const Color.fromRGBO(
                                                        96, 93, 102, 1),
                                                  ),
                                                ),
                                        ],
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 184,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 56,
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
