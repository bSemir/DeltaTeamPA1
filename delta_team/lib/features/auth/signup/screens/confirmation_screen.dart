import 'package:delta_team/features/auth/signup/widgets/ConfirmationContainers.dart';
import 'package:delta_team/features/auth/signup/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({super.key});

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Image.asset("assets/images/navbar_logo.png"),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromRGBO(243, 243, 249, 1),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32, right: 32),
                child: Center(
                  child: Text("Just to be sure...",
                      style: GoogleFonts.outfit(fontSize: 32)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32, right: 32),
                child: Center(
                  child: Text(
                    "We’ve sent a 6-digit code to your e-mail",
                    style: GoogleFonts.notoSans(
                      fontSize: 16,
                      color: const Color.fromRGBO(96, 93, 102, 1),
                    ),
                    // style: TextStyle(
                  ),
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: ConfirmationContainers(),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32, right: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: GoogleFonts.notoSans(fontSize: 14),
                    ),
                    Text(
                      'Log in',
                      style: GoogleFonts.notoSans(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 152,
              ),
              Image.asset(
                "assets/images/footer_logo.png",
              ),
              const SizedBox(
                height: 38,
              ),
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
