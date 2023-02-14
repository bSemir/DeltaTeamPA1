import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:delta_team/common/appbar_web.dart';
import 'package:delta_team/common/custom_button.dart';
import 'package:delta_team/features/auth/loadingScreens/loadingscreen_mobile.dart';
import 'package:delta_team/features/auth/loadingScreens/loadingscreen_web.dart';
import 'package:delta_team/features/auth/login/amplify_auth.dart';
import 'package:delta_team/features/auth/login/login_web/loginweb_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreenWeb extends StatelessWidget {
  static const routeName = '/homeweb';
  const HomeScreenWeb({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: HomeAppBar(
        title: 'Tech387',
        leading: Image.asset('assets/images/logo.png'),
        optionalAction: RoundedButton(
          key: const Key('Not_routed_to_SignUpPage'),
          text: 'Sign In',
          press: () {},
          color: const Color(0xFFFFFFFF),
          textColor: const Color(0xFF000000),
          borderColor: const Color(0xFF000000),
          borderSide: const BorderSide(width: 1, color: Color(0xFF000000)),
        ),
        action: RoundedButton(
          borderSide: const BorderSide(width: 1, color: Color(0xFF000000)),
          key: const Key('Not_routed_to_SignUpPage'),
          text: 'Sign Up',
          press: () {},
          color: const Color(0xFF000000),
          textColor: Colors.white,
          borderColor: Colors.black,
        ),
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 747.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage("assets/images/homeBackground.png"),
                    fit: BoxFit.fill),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 107.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                RichText(
                                  text: TextSpan(
                                      text: "Trust ",
                                      style: GoogleFonts.notoSans(
                                        fontSize: (60 / 1440) * width,
                                        color: const Color(0xFF22E974),
                                        fontWeight: FontWeight.w700,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'the',
                                            style: GoogleFonts.notoSans(
                                              fontSize: (60 / 1440) * width,
                                              color: const Color(0xFFFFFFFF),
                                              fontWeight: FontWeight.w700,
                                            )),
                                        TextSpan(
                                            text: ' Process',
                                            style: GoogleFonts.notoSans(
                                              fontSize: (60 / 1440) * width,
                                              color: const Color(0xFFFFFFFF),
                                              fontWeight: FontWeight.w700,
                                            ))
                                      ]),
                                ),
                                // Text(" the process",
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            SizedBox(
                              child: Text(
                                  "Take the first step towards a successful career in tech.",
                                  style: GoogleFonts.notoSans(
                                    fontSize: (48 / 1440) * width,
                                    color: const Color(0xFFFFFFFF),
                                    fontWeight: FontWeight.w400,
                                  )),
                            ),
                            const SizedBox(height: 64.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 65,
                                  width: 314,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Add your button action here
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF22E974),
                                    ),
                                    child: Text(
                                      "GET STARTED",
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF000000),
                                          fontSize: 26.0),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Container(
                                    height: 153.27,
                                    width: 153.27,
                                    alignment: Alignment.topCenter,
                                    child: Image.asset(
                                      "assets/images/arrowhome.png",
                                      height: 128.05,
                                      width: 130,
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: SizedBox(
                        width: 720,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/illustrationHome.png"),
                          ],
                        ),
                      ),
                    ),
                  ]),

              //             // Column(
              //             //   crossAxisAlignment: CrossAxisAlignment.start,
              //             //   children: [
              //             //     Image.asset('assets/images/Banner.png', width: 1600
              //             //         // height: 477,

              //             //         )
              //             //   ],
              //             // ),
              //             // Column(
              //             //   crossAxisAlignment: CrossAxisAlignment.center,
              //             //   mainAxisAlignment: MainAxisAlignment.center,
              //             //   children: [
              //             //     InkWell(
              //             //       onTap: () async {
              //             //         WidgetsBinding.instance.addPostFrameCallback((_) {
              //             //           Navigator.of(context).pop();
              //             //           try {
              //             //             signOutCurrentUser(null, null, context);
              //             //             safePrint('User Signed Out');
              //             //             Navigator.push(
              //             //               context,
              //             //               MaterialPageRoute(
              //             //                   builder: (context) => const MyDesktopBody()),
              //             //             );
              //             //           } on AmplifyException catch (e) {
              //             //             safePrint(e.message);
              //             //           }
              //             //         });
              //             //       },
              //             //       child: Image.asset('assets/images/logotop.png'),
              //             //     ),
              //             //     Text('HomePage',
              //             //         style: GoogleFonts.notoSans(
              //             //           fontSize: 32.0,
              //             //           color: Colors.black,
              //             //           fontWeight: FontWeight.w400,
              //             //         ))
              //             //   ],
              //             // ),
            ),
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 747.0,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("assets/images/homeBackground2.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 120),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/images/picture2.png')
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 35,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'What is Product Arena?',
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF000000),
                                      fontSize: 48.0),
                                ),
                                const SizedBox(
                                  height: 22,
                                ),
                                SizedBox(
                                  height: 177,
                                  width: 588,
                                  child: RichText(
                                      textAlign: TextAlign.justify,
                                      text: TextSpan(
                                          text:
                                              'Product Arena is the first paid internship by',
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xFF000000),
                                              fontSize: 32.0),
                                          children: [
                                            TextSpan(
                                              text: ' Tech387',
                                              style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w700,
                                                  color:
                                                      const Color(0xFF000000),
                                                  fontSize: 32.0),
                                            ),
                                            TextSpan(
                                              text:
                                                  ' for dedicated and talented individuals to experience product building, regardless of the previous experience.',
                                              style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      const Color(0xFF000000),
                                                  fontSize: 32.0),
                                            )
                                          ])),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
