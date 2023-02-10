import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:auth/auth.dart';
import 'package:delta_team/features/auth/signup/provider/auth_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../common/custom_signlog_button.dart';

class TextFieldSignUp extends StatefulWidget {
  const TextFieldSignUp({super.key});

  @override
  State<TextFieldSignUp> createState() => _TextFieldSignUpState();
}

class _TextFieldSignUpState extends State<TextFieldSignUp> {
  bool viewPassword = false;
  bool isButtonPressed = false;

  Future<bool> userExist(String email) async {
    try {
      final user =
          await Amplify.Auth.signIn(username: email, password: "Password1!");
    } catch (error) {
      if (error.toString().contains("UserNotConfirmedException")) {
        setState(() {
          isEmailTaken = true;
        });
      } else {
        setState(() {
          isEmailTaken = false;
        });
      }
    }
    return false;
  }

  Color errorColor = const Color.fromRGBO(179, 38, 30, 1);

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

  bool isSignUpCompleted = false;
  bool isEmailTaken = false;

  void changeScreen() {
    if (isSignUpCompleted) {
      Navigator.pushNamed(context, '/confirmation');
    }
  }

  @override
  Widget build(BuildContext context) {
    final emailProvider = Provider.of<MyEmail>(context, listen: false);
    return Form(
      key: _signUpKey,
      child: Column(
        children: [
          TextFormField(
            key: const Key("nameKey"),
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
                return 'Please fill the required field.';
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
              suffixIcon: Visibility(
                visible: !isNameValid && isButtonPressed,
                child: Icon(
                  Icons.error,
                  color: errorColor,
                  size: 24,
                ),
              ),
              label: Text(
                "Name",
                style: GoogleFonts.notoSans(
                    color: !isNameValid && isButtonPressed
                        ? errorColor
                        : _nameLabelColor,
                    fontSize: 14),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: !isNameValid && isButtonPressed
                      ? errorColor
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
            key: const Key("surnameKey"),
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
                return 'Please fill the required field.';
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
              suffixIcon: Visibility(
                visible: !isSurnameValid && isButtonPressed,
                child: Icon(
                  Icons.error,
                  color: errorColor,
                  size: 24,
                ),
              ),
              label: Text(
                "Surname",
                style: GoogleFonts.notoSans(
                    color: !isSurnameValid && isButtonPressed
                        ? errorColor
                        : _isSurnameLabelColor,
                    fontSize: 14),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: !isSurnameValid && isButtonPressed
                      ? errorColor
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
            key: const Key("birthDateKey"),
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
              RegExp exp = RegExp(
                r'^(?:0[1-9]|[12]\d|3[01])([\/.-])(?:0[1-9]|1[012])\1(?:19|20)\d\d$',
              );
              if (value!.isEmpty) {
                setState(() {
                  isBirthDateValid = false;
                });
                return 'Please fill the required field.';
              } else if (!exp.hasMatch(value)) {
                setState(() {
                  isBirthDateValid = false;
                });
                return 'Please enter valid birth date (dd/mm/yy)';
              }
              if (exp.hasMatch(value)) {
                setState(() {
                  isBirthDateValid = true;
                });
              }
              return null;
            },
            decoration: InputDecoration(
              suffixIcon: Visibility(
                visible: !isBirthDateValid && isButtonPressed,
                child: Icon(
                  Icons.error,
                  color: errorColor,
                  size: 24,
                ),
              ),
              label: Text(
                "Birth Date",
                style: GoogleFonts.notoSans(
                    color: !isBirthDateValid && isButtonPressed
                        ? errorColor
                        : _isBirthDateLabelColor,
                    fontSize: 14),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: !isBirthDateValid && isButtonPressed
                      ? errorColor
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
            key: const Key("cityKey"),
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
                return 'Please fill the required field.';
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
              suffixIcon: Visibility(
                visible: !isCityValid && isButtonPressed,
                child: Icon(
                  Icons.error,
                  color: errorColor,
                  size: 24,
                ),
              ),
              label: Text(
                "City",
                style: GoogleFonts.notoSans(
                    color: !isCityValid && isButtonPressed
                        ? errorColor
                        : _cityLabelColor,
                    fontSize: 14),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: !isCityValid && isButtonPressed
                      ? errorColor
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
              key: const Key("statusKey"),
              hint: Text(
                'Status',
                style: GoogleFonts.notoSans(
                    color: !isStatusValid && isButtonPressed
                        ? errorColor
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
            key: const Key("phoneNumberKey"),
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
              String patttern =
                  r'^[\+]?((?:9[679]|8[035789]|6[789]|5[90]|42|3[578]|2[1-689])|9[0-58]|8[1246]|6[0-6]|5[1-8]|4[013-9]|3[0-469]|2[70]|7|1)(?:\W*\d){0,13}\d$';
              RegExp regExp = RegExp(patttern);
              if (value!.isEmpty) {
                setState(() {
                  isPhoneValid = false;
                });
                return 'Please fill the required field.';
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
              suffixIcon: Visibility(
                visible: !isPhoneValid && isButtonPressed,
                child: Icon(
                  Icons.error,
                  color: errorColor,
                  size: 24,
                ),
              ),
              label: Text(
                "Phone",
                style: GoogleFonts.notoSans(
                    color: !isPhoneValid && isButtonPressed
                        ? errorColor
                        : _isPhoneLabelColor,
                    fontSize: 14),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: !isPhoneValid && isButtonPressed
                      ? errorColor
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
            key: const Key("emailKey"),
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
              if (value!.isEmpty) {
                return 'Please fill the required field.';
              } else if (!EmailValidator.validate(value)) {
                setState(() {
                  isEmailValid = false;
                });
                return "Enter the valid email";
              } else if (isEmailTaken) {
                setState(() {
                  isEmailValid = false;
                });
                return "Email already exists";
              } else if (EmailValidator.validate(value)) {
                setState(() {
                  isEmailValid = true;
                });
              }
              return null;
            },
            decoration: InputDecoration(
              suffixIcon: Visibility(
                visible: !isEmailValid && isButtonPressed,
                child: Icon(
                  Icons.error,
                  color: errorColor,
                  size: 24,
                ),
              ),
              label: Text(
                "Email",
                style: GoogleFonts.notoSans(
                    color: !isEmailValid && isButtonPressed
                        ? errorColor
                        : _isEmailLabelColor,
                    fontSize: 14),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: !isEmailValid && isButtonPressed
                        ? errorColor
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
            key: const Key("passwordKey"),
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
              String regex =
                  r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$";
              RegExp regExp = RegExp(regex);
              if (value!.isEmpty) {
                setState(() {
                  isPasswordValid = false;
                });
                return 'Please fill the required field.';
              } else if (regExp.hasMatch(value)) {
                setState(() {
                  isPasswordValid = true;
                });
              } else {
                setState(() {
                  isPasswordValid = false;
                });
                return 'Password must contain a minimum of 8 characters, \nuppercase, lower case, number and special character.';
              }
              return null;
            },
            decoration: InputDecoration(
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
                  }),
              label: Text(
                "Password",
                style: GoogleFonts.notoSans(
                    color: !isPasswordValid && isButtonPressed
                        ? errorColor
                        : _isPasswordLabelColor,
                    fontSize: 14),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: !isPasswordValid && isButtonPressed
                        ? errorColor
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
            key: const Key("createAccountKey"),
            content: Text(
              "Create Your account",
              style: GoogleFonts.notoSans(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            buttonFunction: () async {
              setState(() {
                isButtonPressed = true;
              });
              await userExist(emailController.text);
              if (_signUpKey.currentState!.validate()) {
                try {
                  final userAttributes = <CognitoUserAttributeKey, String>{
                    CognitoUserAttributeKey.email: emailController.text,
                    CognitoUserAttributeKey.phoneNumber:
                        phoneNumberController.text,
                    CognitoUserAttributeKey.givenName: nameController.text,
                    CognitoUserAttributeKey.address: cityController.text,
                    CognitoUserAttributeKey.familyName: surnameController.text,
                    CognitoUserAttributeKey.birthdate: birthDateController.text,
                    const CognitoUserAttributeKey.custom("Status"):
                        _statusValue!,

                    // additional attributes as needed
                  };
                  final result = await Amplify.Auth.signUp(
                    username: emailController.text,
                    password: passwordController.text,
                    options:
                        CognitoSignUpOptions(userAttributes: userAttributes),
                  );
                  if (result.isSignUpComplete) {
                    setState(() {
                      emailProvider.email = emailController.text;
                      isSignUpCompleted = true;
                    });
                  }
                } on AuthException catch (e) {
                  safePrint(e.message);
                }
              }
              if (isSignUpCompleted) {
                changeScreen();
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
