import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common/custom_signlog_button.dart';

class ConfirmationContainers extends StatefulWidget {
  const ConfirmationContainers({super.key});

  @override
  State<ConfirmationContainers> createState() => _ConfirmationContainersState();
}

class _ConfirmationContainersState extends State<ConfirmationContainers> {
  final _num1 = TextEditingController();
  final _num2 = TextEditingController();
  final _num3 = TextEditingController();
  final _num4 = TextEditingController();
  final _num5 = TextEditingController();
  final _num6 = TextEditingController();

  final _confirmationKey = GlobalKey<FormState>();

  String dummyNum = "234567";
  bool isNumberCorrect = true;
  int counter = 0;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _confirmationKey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                color: Colors.white,
                child: SizedBox(
                  height: 49,
                  width: 39,
                  child: TextFormField(
                    controller: _num1,
                    style: GoogleFonts.notoSans(
                        fontSize: 16, fontWeight: FontWeight.w700),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(64, 61, 59, 1),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                            color: isNumberCorrect
                                ? const Color.fromARGB(255, 121, 116, 126)
                                : Colors.red),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    validator: (value) {
                      if (value != dummyNum[0]) {
                        setState(() {
                          isNumberCorrect = false;
                        });
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.right,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: SizedBox(
                  height: 49,
                  width: 39,
                  child: TextFormField(
                    controller: _num2,
                    validator: (value) {
                      if (value != dummyNum[1]) {
                        setState(() {
                          isNumberCorrect = false;
                        });
                      }
                      return null;
                    },
                    style: GoogleFonts.notoSans(
                        fontSize: 16, fontWeight: FontWeight.w700),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(64, 61, 59, 1),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                            color: isNumberCorrect
                                ? const Color.fromARGB(255, 121, 116, 126)
                                : Colors.red),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.right,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: SizedBox(
                  height: 49,
                  width: 39,
                  child: TextFormField(
                    controller: _num3,
                    validator: (value) {
                      if (value != dummyNum[2]) {
                        setState(() {
                          isNumberCorrect = false;
                        });
                      }
                      return null;
                    },
                    style: GoogleFonts.notoSans(
                        fontSize: 16, fontWeight: FontWeight.w700),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(64, 61, 59, 1),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                            color: isNumberCorrect
                                ? const Color.fromARGB(255, 121, 116, 126)
                                : Colors.red),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.right,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: SizedBox(
                  height: 49,
                  width: 39,
                  child: TextFormField(
                    controller: _num4,
                    validator: (value) {
                      if (value != dummyNum[3]) {
                        setState(() {
                          isNumberCorrect = false;
                        });
                      }
                      return null;
                    },
                    style: GoogleFonts.notoSans(
                        fontSize: 16, fontWeight: FontWeight.w700),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(64, 61, 59, 1),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                            color: isNumberCorrect
                                ? const Color.fromARGB(255, 121, 116, 126)
                                : Colors.red),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.right,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: SizedBox(
                  height: 49,
                  width: 39,
                  child: TextFormField(
                    controller: _num5,
                    validator: (value) {
                      if (value != dummyNum[4]) {
                        setState(() {
                          isNumberCorrect = false;
                        });
                      }
                      return null;
                    },
                    style: GoogleFonts.notoSans(
                        fontSize: 16, fontWeight: FontWeight.w700),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(64, 61, 59, 1),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                            color: isNumberCorrect
                                ? const Color.fromARGB(255, 121, 116, 126)
                                : Colors.red),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.right,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: SizedBox(
                  height: 49,
                  width: 39,
                  child: TextFormField(
                    controller: _num6,
                    validator: (value) {
                      if (value != dummyNum[5]) {
                        setState(() {
                          isNumberCorrect = false;
                        });
                      }
                      if (_num1.text == dummyNum[0] &&
                          _num2.text == dummyNum[1] &&
                          _num3.text == dummyNum[2] &&
                          _num4.text == dummyNum[3] &&
                          _num5.text == dummyNum[4] &&
                          _num6.text == dummyNum[5]) {
                        setState(() {
                          isNumberCorrect = true;
                        });
                      }
                      return null;
                    },
                    style: GoogleFonts.notoSans(
                        fontSize: 16, fontWeight: FontWeight.w700),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(64, 61, 59, 1),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                            color: isNumberCorrect
                                ? const Color.fromARGB(255, 121, 116, 126)
                                : Colors.red),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.right,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        !isNumberCorrect
            ? Column(
                children: [
                  Text(
                    "Confirmation code does not match",
                    style: GoogleFonts.notoSans(
                      fontSize: 14,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(
                    height: 33,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Send code again",
                        style: GoogleFonts.notoSans(
                          fontWeight: FontWeight.w700,
                          color: const Color.fromRGBO(96, 93, 102, 1),
                        ),
                      ),
                      Text(
                        " 00:20",
                        style: GoogleFonts.notoSans(
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(96, 93, 102, 1),
                        ),
                      ),
                    ],
                  )
                ],
              )
            : Container(),
        !isNumberCorrect
            ? const SizedBox(
                height: 9,
              )
            : const SizedBox(
                height: 80,
              ),
        Padding(
          padding: const EdgeInsets.only(left: 32, right: 32),
          child: CustomButton(
            content: Text(
              "Verify",
              style: GoogleFonts.notoSans(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            buttonFunction: () {
              setState(() {
                isPressed = true;
              });
              if (_confirmationKey.currentState!.validate()) {}
            },
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
