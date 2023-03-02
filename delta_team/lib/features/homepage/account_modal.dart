import 'package:amplify_core/amplify_core.dart';
import 'package:delta_team/features/auth/login/login_web/loginweb_body.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../auth/login/providers/userAttributesProvider.dart';
import 'homepage_sidebar.dart';

class AccountModal extends StatefulWidget {
  const AccountModal({super.key});

  @override
  State<AccountModal> createState() => _AccountModalState();
}

class _AccountModalState extends State<AccountModal> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> signOutUser() async {
    try {
      final res = await Amplify.Auth.signOut();
    } on AuthException catch (e) {
      safePrint(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userAttributesProvider =
        Provider.of<UserAttributesProvider>(context, listen: false);

    return Positioned(
      top: 64,
      right: 106,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.15,
        height: MediaQuery.of(context).size.height * 0.46,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  "assets/images/product_arena_modal.png",
                  width: double.infinity,
                ),
              ),
              Center(
                child: Image.asset(
                  "assets/images/profile_icon.png",
                  height: 10,
                  width: 10,
                ),
              ),
              Center(
                child: Text(
                  "${userAttributesProvider.name} ${userAttributesProvider.surname}",
                  style: GoogleFonts.outfit(
                      fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Text(
                  userAttributesProvider.email,
                  style: GoogleFonts.notoSans(fontSize: 16),
                ),
              ),
              const Divider(
                color: Colors.black,
              ),
              const SizedBox(
                height: 26,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 17, left: 17),
                child: Text(
                  "My interests:",
                  style: GoogleFonts.notoSans(fontSize: 14),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              SizedBox(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: varijablaRola.length,
                  itemBuilder: (context, index) {
                    var res = varijablaRola[index];
                    String image = "assets/images/backendBijela.png";

                    String str = "";

                    if (res == "backend") {
                      str = "Backend Development";
                      image = "assets/images/backendBijela.png";
                    }
                    if (res == "fullstack") {
                      str = "Fullstack Development";
                      image = "assets/images/fullstackBijela.png";
                    }
                    if (res == "productManager") {
                      str = "Project Manager";
                      image = "assets/images/homepage_manager.png";
                    }
                    if (res == "uiux") {
                      str = "UI/UX Design";
                      image = "assets/images/homepageui.png";
                    }
                    if (res == "qa") {
                      str = "QA";
                      image = "assets/images/homepageqa.png";
                    }
                    return Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(right: 17, left: 17),
                            child: Text(
                              str,
                              style: GoogleFonts.notoSans(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            )),
                      ],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 14,
                    );
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.10,
              ),
              Center(
                child: ElevatedButton(
                  key: const Key("signout_key"),
                  onPressed: () {
                    signOutUser();
                    Navigator.pushNamed(context, LoginScreenWeb.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.black, width: 2),
                  ),
                  child: const Text(
                    "Log out",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
