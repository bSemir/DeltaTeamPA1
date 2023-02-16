// ignore: file_names
import 'dart:js';
// ignore: unused_import
import 'dart:math';
// ignore: unused_import
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:flutter/material.dart';

import 'package:delta_team/features/auth/signup/provider/auth_provider.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
// ignore: unused_import
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';
// ignore: unnecessary_import
import 'package:flutter/services.dart';

// import 'package:amplify_api/amplify_api.dart';
// import 'package:masked_text_input_formatter/masked_text_input_formatter.dart';
import '../../../common/custom_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isButtonPressed = false;

  Future<bool> userExist(String email) async {
    try {
      final user = await Amplify.Auth.signIn(
        username: email,
      );
    } catch (error) {
      if (!error.toString().contains("UserNotFoundException")) {
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

  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? _statusValue;
  List<String> statusList = [
    'Student',
    'Employed',
    'Unemployed',
  ];

  final _signupFormKey = GlobalKey<FormState>();
  bool nameErrored = false;
  bool _passwordVisible = false;

  bool _isEmailCorrect = true;
  bool _isPassCorrect = false;

  bool isSignUpCompleted = false;
  bool isEmailTaken = false;

  void changeScreen() {
    if (isSignUpCompleted) {
      FocusManager.instance.primaryFocus?.unfocus();
      Navigator.pushNamed(context as BuildContext, "/confirmation");
    }
  }

  initState() {
    _passwordVisible = false;
  }

  RegExp pass_valid = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$ %^&*-]).{8,}$');

  bool validatePassword(String pass) {
    String _password = pass.trim();
    if (pass_valid.hasMatch(_password)) {
      return true;
    } else {
      return false;
    }
  }

  final phoneMaskFormatter = MaskTextInputFormatter(mask: "+############");
  final dateMaskFormatter = MaskTextInputFormatter(mask: "##/##/####");

  @override
  Widget build(BuildContext context) {
    final emailProvider = Provider.of<MyEmail>(context, listen: false);
    return Container(
      height: 1133,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/paBackground.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Container(
              width: 740,
              height: 1010,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Image.asset("images/PAlogoWhite.png"),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      "Welcome to",
                      style: TextStyle(fontSize: 48),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      "Product Arena",
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  //user inputs fields
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      width: 452,
                      height: 728,
                      child: Form(
                        key: _signupFormKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Container(
                                    width: 220,
                                    child: TextFormField(
                                      key: const Key("nameKey"),
                                      controller: nameController,
                                      validator: (value) {
                                        String pattern = r'^[a-zA-Z]+$';
                                        RegExp regExp = RegExp(pattern);
                                        if (value!.isEmpty) {
                                          setState(() {
                                            nameErrored = true;
                                          });
                                          return 'Please fill the required field.';
                                        } else if (!regExp.hasMatch(value)) {
                                          setState(() {
                                            nameErrored = true;
                                          });
                                          return 'Please enter valid name';
                                        }
                                        setState(() {
                                          nameErrored = false;
                                        });
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        label: Text("Name"),
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Container(
                                    width: 220,
                                    child: TextFormField(
                                      key: const Key("surnameKey"),
                                      controller: surnameController,
                                      validator: (value) {
                                        String pattern = r'^[a-zA-Z]+$';
                                        RegExp regExp = RegExp(pattern);
                                        if (value!.isEmpty) {
                                          setState(() {
                                            nameErrored = true;
                                          });
                                          return 'Please fill the required field.';
                                        } else if (!regExp.hasMatch(value)) {
                                          setState(() {
                                            nameErrored = true;
                                          });
                                          return 'Please enter valid surname';
                                        }
                                        setState(() {
                                          nameErrored = false;
                                        });
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        label: Text("Surname"),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Flexible(
                              child: Container(
                                width: 452,
                                child: TextFormField(
                                  key: const Key("birthDateKey"),
                                  inputFormatters: [dateMaskFormatter],
                                  controller: birthDateController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please fill the required field.";
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    label: Text("Birth date"),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                width: 452,
                                child: TextFormField(
                                  key: const Key("cityKey"),
                                  controller: cityController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please fill the required field.";
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    label: Text("City"),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                width: 452,
                                child: DropdownButtonFormField<String>(
                                  key: const Key("statusKey"),
                                  hint: const Text('Status',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700)),
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  value: _statusValue,
                                  // validator: (value) {
                                  //   if (_statusValue == null) {
                                  //     setState(() {
                                  //       statusErrored = true;
                                  //     });
                                  //     return "Select your status";
                                  //   } else {
                                  //     setState(() {
                                  //       statusErrored = false;
                                  //     });
                                  //   }
                                  //   return null;
                                  // },
                                  items: statusList
                                      .map(
                                        (String item) =>
                                            DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (String? value) {
                                    if (value is String) {
                                      setState(() {
                                        _statusValue = value;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                width: 452,
                                child: TextFormField(
                                  key: const Key("phoneNumberKey"),
                                  controller: phoneNumberController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please fill the required field.";
                                    }
                                    return null;
                                  },
                                  inputFormatters: [phoneMaskFormatter],
                                  keyboardType: TextInputType.phone,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    label: Text("Phone"),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                width: 452,
                                child: TextFormField(
                                  key: const Key("emailKey"),
                                  controller: emailController,
                                  onChanged: (value) {
                                    setState(() {
                                      _isEmailCorrect = isEmail(value);
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please fill the required field.';
                                    } else if (isEmailTaken) {
                                      return "Email already exists";
                                    } else if (isEmail(value)) {}
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: _isEmailCorrect == true
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ),
                                    suffixIcon: Icon(
                                      _isEmailCorrect == false
                                          ? Icons.error
                                          : null,
                                      color: Colors.red,
                                    ),
                                    label: Text("Email"),
                                    errorText: _isEmailCorrect == false
                                        ? "Invalid email format"
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                width: 452,
                                child: TextFormField(
                                  key: const Key("passwordKey"),
                                  controller: passwordController,
                                  onChanged: (value) {
                                    setState(() {
                                      _isPassCorrect = validatePassword(value);
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please fill the required field.";
                                    } else {
                                      bool result = validatePassword(value);
                                      if (result) {
                                        return null;
                                      } else {
                                        return "Password must contain a minimum of 8 characters, upperase, lower case, number and special character";
                                      }
                                    }
                                  },
                                  obscureText: !_passwordVisible,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    label: Text("Password"),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        // Based on passwordVisible state choose the icon
                                        _passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        // Update the state i.e. toogle the state of passwordVisible variable
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                width: 452,
                                height: 56,
                                child: const Text(
                                  "By creating an account, you agree to our  Terms and have read and acknowledge the Global Privacy Statement.",
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                width: 452,
                                height: 56,
                                child: ElevatedButton(
                                  key: const Key("createAccountKey"),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black),
                                  onPressed: () async {
                                    setState(() {
                                      isButtonPressed = true;
                                    });

                                    if (_signupFormKey.currentState!
                                        .validate()) {
                                      try {
                                        final userAttributes =
                                            <CognitoUserAttributeKey, String>{
                                          CognitoUserAttributeKey.email:
                                              emailController.text,
                                          CognitoUserAttributeKey.phoneNumber:
                                              phoneNumberController.text,
                                          CognitoUserAttributeKey.givenName:
                                              nameController.text,
                                          CognitoUserAttributeKey.address:
                                              cityController.text,
                                          CognitoUserAttributeKey.familyName:
                                              surnameController.text,
                                          CognitoUserAttributeKey.birthdate:
                                              birthDateController.text,
                                          // const CognitoUserAttributeKey.custom(
                                          //     "Student"): _statusValue!,
                                          // additional attributes as needed
                                        };

                                        final result =
                                            await Amplify.Auth.signUp(
                                          username: emailController.text,
                                          password: passwordController.text,
                                          options: CognitoSignUpOptions(
                                              userAttributes: userAttributes),
                                        );
                                        print(result.isSignUpComplete);
                                        if (!result.isSignUpComplete) {
                                          // ignore: use_build_context_synchronously
                                          Navigator.pushNamed(
                                              context, "/confirmation");
                                          setState(() {
                                            emailProvider.email =
                                                emailController.text;
                                          });
                                        }
                                      } on AuthException catch (e) {
                                        safePrint(e.message);
                                        print(e.message);
                                      }
                                    }
                                    if (isSignUpCompleted) {
                                      print("SIGNUP ISE COMEPLETED");
                                      changeScreen();
                                    }
                                  },
                                  child: const Text(
                                    "Create your account",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
