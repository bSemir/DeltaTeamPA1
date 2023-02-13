import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomEmailField extends StatefulWidget {
  final String text;
  bool showErrorIcon;

  // final IconData suffixIcon;
  final TextEditingController controller;

  CustomEmailField({
    super.key,
    required this.text,
    required this.controller,
    this.showErrorIcon = false,

    // required this.suffixIcon
  });

  @override
  State<CustomEmailField> createState() => _CustomEmailFieldState();
}

class _CustomEmailFieldState extends State<CustomEmailField> {
  bool showErrorIcon = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              setState(() {
                showErrorIcon = true;
              });
              return 'Please enter an email';
            }
            if (!value.contains("@") || !value.endsWith(".com")) {
              setState(() {
                showErrorIcon = true;
              });
              return 'Please enter a valid email';
            }
            setState(() {
              showErrorIcon = false;
            });
            return null;
          },
          controller: widget.controller,
          style: TextStyle(color: showErrorIcon ? Colors.red : Colors.black),
          decoration: InputDecoration(
            labelText: "Email",
            labelStyle: GoogleFonts.notoSans(
                fontWeight: FontWeight.w600,
                color: showErrorIcon ? Colors.red : const Color(0xFF605D66),
                fontSize: 14.0),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            floatingLabelStyle:
                TextStyle(color: showErrorIcon ? Colors.red : Colors.black),

            filled: true,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 3, 199, 42), width: 1.0),
              gapPadding: 10.0,
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1.0),
            ),
            disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF605D66), width: 1.0),
            ),

            // ignore: prefer_const_constructors
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFB3261E), width: 1.0),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
            // contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),

            contentPadding: const EdgeInsets.only(
                top: 10.5, left: 16.0, right: 16, bottom: 10.5),
            hintText: widget.text,
            hintStyle: GoogleFonts.notoSans(
                fontWeight: FontWeight.w700,
                color: showErrorIcon ? Colors.red : const Color(0xFF605D66),
                fontSize: 14.0),

            suffixIcon: (widget.controller.text.isNotEmpty &&
                    !widget.controller.text.contains("@") &&
                    !widget.controller.text.endsWith(".com"))
                ? const Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 18,
                  )
                : null,
          ),
        ),
      ],
    );
  }
}

class CustomPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const CustomPasswordField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool passwordObscured = true;
  bool validatorError = false;
  void togglePasswordObscure() {
    setState(() {
      passwordObscured = !passwordObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          setState(() {
            validatorError = true;
          });
          return 'Please enter a password';
        }
        if (value.length < 8) {
          setState(() {
            validatorError = true;
          });
          return 'Password must be at least 8 characters';
        }
        if (!RegExp(r'^(?=.*?[#?!@$%^&*-]).{8,}$').hasMatch(value)) {
          setState(() {
            validatorError = true;
          });
          return 'Password must contain a special character';
        }

        setState(() {
          validatorError = false;
        });
        return null;
      },
      controller: widget.controller,
      obscureText: passwordObscured,
      style: TextStyle(color: validatorError ? Colors.red : Colors.black),
      decoration: InputDecoration(
        labelText: "Password",
        labelStyle: GoogleFonts.notoSans(
            fontWeight: FontWeight.w600,
            color: validatorError ? Colors.red : Colors.black,
            fontSize: 14.0),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelStyle:
            TextStyle(color: validatorError ? Colors.red : Colors.black),

        filled: true,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.0),
          gapPadding: 10.0,
        ),

        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.0),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF605D66), width: 1.0),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFB3261E), width: 1.0),
          gapPadding: 10.0,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
        // contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        contentPadding: const EdgeInsets.only(
            top: 10.5, left: 16.0, right: 16, bottom: 10.5),
        hintText: widget.hintText,
        hintStyle: GoogleFonts.notoSans(
          fontWeight: FontWeight.w700,
          color: validatorError ? Colors.red : Colors.black,
          fontSize: 14.0,
        ),
        suffixIcon: IconButton(
          color: validatorError ? Colors.red : Colors.black,
          icon: Icon(
            passwordObscured
                ? FontAwesomeIcons.solidEyeSlash
                : FontAwesomeIcons.solidEye,
            size: 18,
          ),
          onPressed: togglePasswordObscure,
        ),
        // errorStyle: TextStyle(color: Colors.red),
      ),
    );
  }
}
