import 'package:delta_team/features/Home_welcome_mobile/menu_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../auth/login/loadingScreens/loadingscreen_mobile.dart';

class WelcomingScreen extends StatefulWidget {
  static const routeName2 = '/welcome_screen';
  const WelcomingScreen({super.key});
  @override
  State<WelcomingScreen> createState() => _WelcomingScreenState();
}

class _WelcomingScreenState extends State<WelcomingScreen> {
  bool _isBurgerIcon = true;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SvgPicture.asset("assets/images/appbar_logo.svg"),
          ),
          actions: [
            Padding(
              key: const Key('open_menu_burger_icon'),
              padding: const EdgeInsets.only(right: 15),
              child: IconButton(
                icon: _isBurgerIcon
                    ? const Icon(Icons.menu)
                    : const Icon(Icons.close),
                color: Colors.black,
                onPressed: () {
                  setState(() {
                    _isBurgerIcon = !_isBurgerIcon;
                  });
                },
              ),
            ),
          ],
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: _isBurgerIcon
            ? SingleChildScrollView(
                child: Stack(
                  children: <Widget>[
                    Container(
                      color: Color.fromRGBO(238, 233, 233, 1),
                      child: Center(
                        child: Column(
                          key: const Key('home_welcome_mesagge'),
                          children: [
                            const SizedBox(
                              height: 60,
                            ),
                            SvgPicture.asset("assets/images/UX.svg"),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              "Welcome to",
                              style: TextStyle(fontSize: 32),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              "Product Arena",
                              style: TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Our goal is to recognise persistence,\nmotivation and adaptability, that’s why we\n encourage you to dive into these materials\n and wish you the best of luck in your\n studies.",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Once you have gone through all the lessons\n you'll be able to take a test to show us what\n you have learned!",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14),
                            ),
                            const SizedBox(
                              height: 108,
                            ),
                            Container(
                              height: 55,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: (30 / 360) * width,
                                    right: (30 / 360) * width,
                                    bottom: 8),
                                child: Row(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: InkWell(
                                        key: const Key(
                                            'routed_to_loadingScreen'),
                                        onTap: () async {
                                          // Navigator.pushNamed(context,
                                          //     LoadingScreenMobile.routeName);
                                          // Navigate to privacy page
                                        },
                                        child: Text(
                                          "Privacy",
                                          style: GoogleFonts.notoSans(
                                            fontWeight: FontWeight.w400,
                                            color: const Color.fromARGB(
                                                255, 142, 142, 142),
                                            fontSize: 13.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Text(
                                          "© Credits, 2023, Product Arena",
                                          style: GoogleFonts.notoSans(
                                              fontWeight: FontWeight.w400,
                                              color: const Color.fromARGB(
                                                  255, 142, 142, 142),
                                              fontSize: 12.0),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        key: const Key(
                                            'routed_to_LoadingScreen'),
                                        onTap: () async {
                                          // Navigator.pushNamed(context,
                                          //     LoadingScreenMobile.routeName);
                                          // Navigate to privacy page
                                        },
                                        child: Text(
                                          "Terms",
                                          style: GoogleFonts.notoSans(
                                              fontWeight: FontWeight.w400,
                                              color: const Color.fromARGB(
                                                  255, 142, 142, 142),
                                              fontSize: 13.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : const MyDrawer());
  }
}
