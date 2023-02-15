import 'dart:js';
import 'dart:math';
import 'package:flutter/material.dart';

import 'package:delta_team/features/auth/signup/provider/auth_provider.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

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

  @override
  Widget build(BuildContext context) {
    final emailProvider = Provider.of<MyEmail>(context, listen: false);
    return Container(
      height: 1133,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/paBackground.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
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
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Welcome to",
                    style: TextStyle(fontSize: 48),
                  ),
                ),
                Padding(
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
                              Container(
                                width: 220,
                                child: TextFormField(
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
                                  // validator: (value) {
                                  //   if (value!.isEmpty) {
                                  //     return "PLeas populate field";
                                  //   }
                                  //   return null;
                                  // },

                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    label: Text("Name"),
                                  ),
                                ),
                              ),
                              Container(
                                width: 220,
                                child: TextFormField(
                                  controller: surnameController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "PLeas populate field";
                                    }
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    label: Text("Surname"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 452,
                            child: TextFormField(
                              controller: birthDateController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "PLeas populate field";
                                }
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text("Birth date"),
                              ),
                            ),
                          ),
                          Container(
                            width: 452,
                            child: TextFormField(
                              controller: cityController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "PLeas populate field";
                                }
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text("Citx"),
                              ),
                            ),
                          ),
                          Container(
                            width: 452,
                            child: DropdownButtonFormField<String>(
                              key: const Key("statusKey"),
                              hint: Text('Status',
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
                                    (String item) => DropdownMenuItem<String>(
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
                          Container(
                            width: 452,
                            child: TextFormField(
                              controller: phoneNumberController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "PLeas populate field";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.phone,
                              // inputFormatters: [
                              //   MaskedTextInputFormatter(
                              //     mask: '+387-##-###-###',
                              //     separator: '-',
                              //   ),
                              // ],
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text("Phone"),
                              ),
                            ),
                          ),
                          Container(
                            width: 452,
                            child: TextFormField(
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
                                }
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
                                  _isEmailCorrect == false ? Icons.error : null,
                                  color: Colors.red,
                                ),
                                label: Text("Email"),
                                errorText: _isEmailCorrect == false
                                    ? "Invalid email format"
                                    : null,
                              ),
                            ),
                          ),
                          Container(
                            width: 452,
                            child: TextFormField(
                              controller: passwordController,
                              onChanged: (value) {
                                setState(() {
                                  _isPassCorrect = validatePassword(value);
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "PLeas populate field";
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
                          Container(
                            width: 452,
                            height: 56,
                            child: Text(
                              "By creating an account, you agree to our  Terms and have read and acknowledge the Global Privacy Statement.",
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                          Container(
                            width: 452,
                            height: 56,
                            child: ElevatedButton(
                              child: Text(
                                "Create your account",
                                style: TextStyle(fontSize: 16),
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black),
                              onPressed: () async {
                                setState(() {
                                  isButtonPressed = true;
                                });

                                if (_signupFormKey.currentState!.validate()) {
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

                                    final result = await Amplify.Auth.signUp(
                                      username: emailController.text,
                                      password: passwordController.text,
                                      options: CognitoSignUpOptions(
                                          userAttributes: userAttributes),
                                    );
                                    print(result.isSignUpComplete);
                                    if (!result.isSignUpComplete) {
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
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "/confirmation");
                              },
                              child: Text("redirect"))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
