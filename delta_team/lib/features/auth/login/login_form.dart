import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginFormWeb extends StatelessWidget {
  final String text;
  late bool showErrorIcon;

  // final IconData suffixIcon;
  final TextEditingController controller;

  LoginFormWeb({
    super.key,
    required this.text,
    required this.controller,
    this.showErrorIcon = false,

    // required this.suffixIcon
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          showErrorIcon = true;
          return 'Please enter an email';
        }
        if (!value.contains("@") || !value.endsWith(".com")) {
          showErrorIcon = true;
          return 'Please enter a valid email';
        }
        showErrorIcon = false;
        return null;
      },
      controller: controller,
      decoration: InputDecoration(
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
        hintText: text,
        hintStyle: GoogleFonts.notoSans(
          fontWeight: FontWeight.w700,
          color: Colors.black.withOpacity(0.5),
          fontSize: (14 / 1440) * width,
        ),
      ),
    );
  }
}

class CustomEmailField extends StatelessWidget {
  final String text;
  late bool showErrorIcon;

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
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(children: [
      TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            showErrorIcon = true;
            return 'Please enter an email';
          }
          if (!value.contains("@") || !value.endsWith(".com")) {
            showErrorIcon = true;
            return 'Please enter a valid email';
          }
          showErrorIcon = false;
          return null;
        },
        controller: controller,
        decoration: InputDecoration(
          labelText: "Email",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          floatingLabelStyle: const TextStyle(color: Color(0xFF000000)),

          filled: true,
          focusedBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 3, 199, 42), width: 1.0),
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
          contentPadding: const EdgeInsets.only(
              top: 10.5, left: 16.0, right: 16, bottom: 10.5),
          hintText: text,
          hintStyle: GoogleFonts.notoSans(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF605D66),
              fontSize: 14.0),

          suffixIcon: showErrorIcon
              ? const Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 20,
                )
              : null,
        ),
      ),
    ]);
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
          return 'Please enter a password';
        }
        if (value.length < 8) {
          return 'Password must be at least 8 characters';
        }
        if (!RegExp(r'^(?=.*?[#?!@$%^&*-]).{8,}$').hasMatch(value)) {
          return 'Password must contain a special character';
        }
        return null;
      },
      controller: widget.controller,
      obscureText: passwordObscured,
      style: GoogleFonts.notoSans(
        fontWeight: FontWeight.w600,
        color: Colors.black,
        fontSize: 14.0,
      ),
      decoration: InputDecoration(
        labelText: "Password",
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelStyle: const TextStyle(color: Color(0xFF000000)),
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
        contentPadding: const EdgeInsets.only(
            top: 10.5, left: 16.0, right: 16, bottom: 10.5),
        hintText: widget.hintText,
        hintStyle: GoogleFonts.notoSans(
          fontWeight: FontWeight.w700,
          color: const Color(0xFF605D66),
          fontSize: 14.0,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            passwordObscured
                ? FontAwesomeIcons.solidEyeSlash
                : FontAwesomeIcons.solidEye,
            size: 18,
            color: Colors.black,
          ),
          onPressed: togglePasswordObscure,
        ),
      ),
    );
  }
}
