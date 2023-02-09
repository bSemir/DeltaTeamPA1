import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common/custom_signlog_button.dart';

class TextFieldSignUp extends StatefulWidget {
  const TextFieldSignUp({super.key});

  @override
  State<TextFieldSignUp> createState() => _TextFieldSignUpState();
}

class _TextFieldSignUpState extends State<TextFieldSignUp> {
  bool viewPassword = false;
  bool isButtonPressed = false;

  Color _nameLabelColor = const Color.fromRGBO(96, 93, 102, 1);
  Color _isSurnameLabelColor = const Color.fromRGBO(96, 93, 102, 1);
  Color _isBirthDateLabelColor = const Color.fromRGBO(96, 93, 102, 1);
  Color _isPhoneLabelColor = const Color.fromRGBO(96, 93, 102, 1);
  Color _cityLabelColor = const Color.fromRGBO(96, 93, 102, 1);
  Color _isEmailLabelColor = const Color.fromRGBO(96, 93, 102, 1);
  Color _isPasswordLabelColor = const Color.fromRGBO(96, 93, 102, 1);

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? _statusValue;

  List<String> statusList = [
    'Student',
    'Employed',
    'Unemployed',
  ];

  final _signUpKey = GlobalKey<FormState>();

  bool isNameValid = false;
  bool isSurnameValid = false;
  bool isStatusValid = false;
  bool isEmailValid = false;
  bool isPhoneValid = false;
  bool isCityValid = false;
  bool isPasswordValid = false;
  bool isBirthDateValid = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _signUpKey,
      child: Column(
        children: [
          TextFormField(
            controller: nameController,
            onChanged: (value) {
              if (value.isNotEmpty && isNameValid) {
                setState(() {
                  isButtonPressed = false;
                });
              }
            },
            style: GoogleFonts.notoSans(fontWeight: FontWeight.w500),
            onTap: () {
              setState(() {
                _isBirthDateLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isSurnameLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _nameLabelColor = const Color.fromRGBO(34, 233, 116, 1);
                _cityLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isPhoneLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isPasswordLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isEmailLabelColor = const Color.fromRGBO(96, 93, 102, 1);
              });
            },
            validator: (value) {
              String pattern = r'^[a-zA-Z]+$';
              RegExp regExp = RegExp(pattern);
              if (value!.isEmpty) {
                setState(() {
                  isNameValid = false;
                });
                return 'Please enter your name';
              } else if (!regExp.hasMatch(value)) {
                setState(() {
                  isNameValid = false;
                });
                return 'Please enter valid name';
              } else {
                setState(() {
                  isNameValid = true;
                });
              }
              return null;
            },
            decoration: InputDecoration(
              label: Text(
                "Name",
                style: GoogleFonts.notoSans(
                    color: !isNameValid && isButtonPressed
                        ? Colors.red
                        : _nameLabelColor,
                    fontSize: 14),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: !isNameValid && isButtonPressed
                      ? Colors.red
                      : _nameLabelColor,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          TextFormField(
            controller: surnameController,
            onChanged: (value) {
              if (value.isNotEmpty && isSurnameValid) {
                setState(() {
                  isButtonPressed = false;
                });
              }
            },
            style: GoogleFonts.notoSans(fontWeight: FontWeight.w500),
            onTap: () {
              setState(() {
                _isBirthDateLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _nameLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isSurnameLabelColor = const Color.fromRGBO(34, 233, 116, 1);
                _cityLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isPhoneLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isPasswordLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isEmailLabelColor = const Color.fromRGBO(96, 93, 102, 1);
              });
            },
            validator: (value) {
              String pattern = r'^[a-zA-Z]+$';
              RegExp regExp = RegExp(pattern);
              if (value!.isEmpty) {
                setState(() {
                  isSurnameValid = false;
                });
                return 'Please enter your surname';
              } else if (!regExp.hasMatch(value)) {
                setState(() {
                  isSurnameValid = false;
                });
                return 'Please enter valid surname';
              } else {
                setState(() {
                  isSurnameValid = true;
                });
              }
              return null;
            },
            decoration: InputDecoration(
              label: Text(
                "Surname",
                style: GoogleFonts.notoSans(
                    color: !isSurnameValid && isButtonPressed
                        ? Colors.red
                        : _isSurnameLabelColor,
                    fontSize: 14),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: !isSurnameValid && isButtonPressed
                      ? Colors.red
                      : _isSurnameLabelColor,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          TextFormField(
            controller: birthDateController,
            onChanged: (value) {
              if (value.isNotEmpty && isBirthDateValid) {
                setState(() {
                  isButtonPressed = false;
                });
              }
            },
            style: GoogleFonts.notoSans(fontWeight: FontWeight.w500),
            onTap: () {
              setState(() {
                _nameLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isSurnameLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isBirthDateLabelColor = const Color.fromRGBO(34, 233, 116, 1);
                _cityLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isPhoneLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isPasswordLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isEmailLabelColor = const Color.fromRGBO(96, 93, 102, 1);
              });
            },
            validator: (value) {
              String pattern =
                  r'(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})';
              RegExp regExp = RegExp(pattern);
              if (value!.isEmpty) {
                setState(() {
                  isBirthDateValid = false;
                });
                return 'Please enter birth date';
              } else if (!regExp.hasMatch(value)) {
                setState(() {
                  isBirthDateValid = false;
                });
                return 'Please enter valid birth date (01/01/01)';
              } else {
                setState(() {
                  isBirthDateValid = true;
                });
              }
              return null;
            },
            decoration: InputDecoration(
              label: Text(
                "Birth Date",
                style: GoogleFonts.notoSans(
                    color: !isBirthDateValid && isButtonPressed
                        ? Colors.red
                        : _isBirthDateLabelColor,
                    fontSize: 14),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: !isBirthDateValid && isButtonPressed
                      ? Colors.red
                      : const Color.fromRGBO(34, 233, 116, 1),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          TextFormField(
            controller: cityController,
            onChanged: (value) {
              if (value.isNotEmpty && isCityValid) {
                setState(() {
                  isButtonPressed = false;
                });
              }
            },
            style: GoogleFonts.notoSans(fontWeight: FontWeight.w500),
            onTap: () {
              setState(() {
                _isBirthDateLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _nameLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _cityLabelColor = const Color.fromRGBO(34, 233, 116, 1);
                _isPhoneLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isSurnameLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isPasswordLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isEmailLabelColor = const Color.fromRGBO(96, 93, 102, 1);
              });
            },
            validator: (value) {
              String pattern = r'^[a-zA-Z]+$';
              RegExp regExp = RegExp(pattern);
              if (value!.isEmpty) {
                setState(() {
                  isCityValid = false;
                });
                return 'Please enter your city';
              } else if (!regExp.hasMatch(value)) {
                setState(() {
                  isCityValid = false;
                });
                return 'Please enter valid city';
              } else {
                setState(() {
                  isCityValid = true;
                });
              }
              return null;
            },
            decoration: InputDecoration(
              label: Text(
                "City",
                style: GoogleFonts.notoSans(
                    color: !isCityValid && isButtonPressed
                        ? Colors.red
                        : _cityLabelColor,
                    fontSize: 14),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: !isCityValid && isButtonPressed
                      ? Colors.red
                      : _cityLabelColor,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          SizedBox(
            width: double.infinity,
            child: DropdownButtonFormField<String>(
              hint: Text(
                'Status',
                style: GoogleFonts.notoSans(
                    color: !isStatusValid && isButtonPressed
                        ? Colors.red
                        : const Color.fromRGBO(96, 93, 102, 1),
                    fontSize: 14,
                    fontWeight: FontWeight.w700),
              ),
              icon: const Icon(Icons.keyboard_arrow_down),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(96, 93, 102, 1),
                    )),
              ),
              value: _statusValue,
              validator: (value) {
                if (_statusValue == null) {
                  setState(() {
                    isStatusValid = false;
                  });
                  return "Select your status";
                } else {
                  setState(() {
                    isStatusValid = true;
                  });
                }
                return null;
              },
              items: statusList
                  .map(
                    (String item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: GoogleFonts.notoSans(
                          color: const Color.fromRGBO(96, 93, 102, 1),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onTap: () {
                setState(() {
                  _nameLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                  _isSurnameLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                  _cityLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                  _isBirthDateLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                  _isPhoneLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                  _isEmailLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                  _isPasswordLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                });
              },
              onChanged: (String? value) {
                if (value is String) {
                  setState(() {
                    _statusValue = value;
                  });
                }
              },
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          TextFormField(
            controller: phoneNumberController,
            onChanged: (value) {
              if (value.isNotEmpty && isPhoneValid) {
                setState(() {
                  isButtonPressed = false;
                });
              }
            },
            style: GoogleFonts.notoSans(fontWeight: FontWeight.w500),
            onTap: () {
              setState(() {
                _nameLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isSurnameLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isBirthDateLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isPhoneLabelColor = const Color.fromRGBO(34, 233, 116, 1);
                _cityLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isPasswordLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isEmailLabelColor = const Color.fromRGBO(96, 93, 102, 1);
              });
            },
            validator: (value) {
              String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
              RegExp regExp = RegExp(patttern);
              if (value!.isEmpty) {
                setState(() {
                  isPhoneValid = false;
                });
                return 'Please enter phone number';
              } else if (!regExp.hasMatch(value)) {
                setState(() {
                  isPhoneValid = false;
                });
                return 'Please enter valid phone number (387 format)';
              } else {
                setState(() {
                  isPhoneValid = true;
                });
              }
              return null;
            },
            decoration: InputDecoration(
              label: Text(
                "Phone",
                style: GoogleFonts.notoSans(
                    color: !isPhoneValid && isButtonPressed
                        ? Colors.red
                        : _isPhoneLabelColor,
                    fontSize: 14),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: !isPhoneValid && isButtonPressed
                      ? Colors.red
                      : const Color.fromRGBO(34, 233, 116, 1),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          TextFormField(
            controller: emailController,
            onChanged: (value) {
              if (value.isNotEmpty && isEmailValid) {
                setState(() {
                  isButtonPressed = false;
                });
              }
            },
            style: GoogleFonts.notoSans(fontWeight: FontWeight.w500),
            onTap: () {
              setState(() {
                _nameLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isSurnameLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isBirthDateLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _cityLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isPhoneLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isPasswordLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isEmailLabelColor = const Color.fromRGBO(34, 233, 116, 1);
              });
            },
            validator: (value) {
              if (!EmailValidator.validate(value!)) {
                setState(() {
                  isEmailValid = false;
                });
                return "Enter the valid email";
              }
              if (EmailValidator.validate(value)) {
                setState(() {
                  isEmailValid = true;
                });
              }
              return null;
            },
            decoration: InputDecoration(
              label: Text(
                "Email",
                style: GoogleFonts.notoSans(
                    color: !isEmailValid && isButtonPressed
                        ? Colors.red
                        : _isEmailLabelColor,
                    fontSize: 14),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: !isEmailValid && isButtonPressed
                        ? Colors.red
                        : const Color.fromRGBO(34, 233, 116, 1)),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          TextFormField(
            controller: passwordController,
            onChanged: (value) {
              if (value.isNotEmpty && isPasswordValid) {
                setState(() {
                  isButtonPressed = false;
                });
              }
            },
            style: GoogleFonts.notoSans(fontWeight: FontWeight.w500),
            obscureText: !viewPassword ? true : false,
            onTap: () {
              setState(() {
                _nameLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isSurnameLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isBirthDateLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isPhoneLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _cityLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isEmailLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isPasswordLabelColor = const Color.fromRGBO(34, 233, 116, 1);
              });
            },
            validator: (value) {
              String patttern =
                  r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$';
              RegExp regExp = RegExp(patttern);
              if (value!.isEmpty) {
                setState(() {
                  isPasswordValid = false;
                });
                return 'Please enter password';
              } else if (!regExp.hasMatch(value)) {
                setState(() {
                  isPasswordValid = false;
                });
                return 'Password must contain a minimum of 8 characters, \nuppercase, lower case, number and special character.';
              } else {
                setState(() {
                  isPasswordValid = true;
                });
              }
              return null;
            },
            decoration: InputDecoration(
              suffixIcon: InkWell(
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
                  }),
              label: Text(
                "Password",
                style: GoogleFonts.notoSans(
                    color: !isPasswordValid && isButtonPressed
                        ? Colors.red
                        : _isPasswordLabelColor,
                    fontSize: 14),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: !isPasswordValid && isButtonPressed
                        ? Colors.red
                        : const Color.fromRGBO(34, 233, 116, 1)),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          !isPasswordValid && isButtonPressed
              ? const SizedBox(
                  height: 72,
                )
              : const SizedBox(
                  height: 16,
                ),
          Text(
              "By creating an account, you agree to our Terms and have read and acknowledge the Global Privacy Statement.",
              style: GoogleFonts.notoSans(
                  fontSize: 10, color: const Color.fromRGBO(96, 93, 102, 1))),
          const SizedBox(
            height: 33,
          ),
          CustomButton(
            content: Text(
              "Create Your account",
              style: GoogleFonts.notoSans(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            buttonFunction: () {
              setState(() {
                isButtonPressed = true;
              });
              if (_signUpKey.currentState!.validate()) {
                Navigator.pushNamed(context, "/confirmation");
              }
            },
            color: Colors.black,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
