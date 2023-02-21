import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:delta_team/common/appbar_web.dart';
import 'package:delta_team/common/custom_button.dart';
import 'package:delta_team/common/customfooter_web.dart';
import 'package:delta_team/features/auth/loadingScreens/loadingscreen_mobile.dart';
import 'package:delta_team/features/auth/loadingScreens/loadingscreen_web.dart';
import 'package:delta_team/features/auth/login/amplify_auth.dart';
import 'package:delta_team/features/auth/login/login_web/loginweb_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LandingPage extends StatelessWidget {
  static const routeName = '/landingweb';
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: HomeAppBar(
        title: 'Tech387',
        leading: SvgPicture.asset('assets/images/logo.svg'),
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
          text: 'Sign Out',
          press: () async {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pop();
              try {
                signOutCurrentUser(null, null, context);
                safePrint('User Signed Out');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LoginScreenWeb()),
                );
              } on AmplifyException catch (e) {
                safePrint(e.message);
              }
            });
          },
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
                    image: NetworkImage(
                      "assets/images/homeBackground.png",
                    ),
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
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 120, left: 120),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  Image.asset('assets/images/picture2.png')
                                ],
                              ),
                              const SizedBox(
                                width: 35,
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    child: Text(
                                      'What is Product Arena?',
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF000000),
                                          fontSize: 48.0),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 22,
                                  ),
                                  SizedBox(
                                    // height: 177,
                                    width: 600,
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
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 830.0,
                    decoration: const BoxDecoration(color: Color(0xFFFFFFFF)),
                    child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 120, left: 120),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: 467,
                                        height: 130,
                                        child: RichText(
                                          textAlign: TextAlign.right,
                                          text: TextSpan(
                                            text:
                                                'What our interns\n say about us',
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w700,
                                                color: const Color(0xFF000000),
                                                fontSize: 48.0),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 22,
                                      ),
                                      SizedBox(
                                        height: 120,
                                        child: RichText(
                                            textAlign: TextAlign.right,
                                            text: TextSpan(
                                              text:
                                                  "It's an honor to\n have them choose\n to start their careers with us.",
                                              style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      const Color(0xFF605D66),
                                                  fontSize: 32.0),
                                            )),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 90,
                                  ),
                                  SizedBox(
                                    width: 630,
                                    // height: 617.0,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 91, right: 91),
                                              child: Container(
                                                alignment: Alignment.center,
                                                width: 449,
                                                height: 617,
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(16)),
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                ListView.builder(
                                                  itemCount: 3,
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, index) {
                                                    // Calculate the alignment for each item
                                                    EdgeInsetsGeometry padding =
                                                        const EdgeInsets.all(0);
                                                    if (index == 0) {
                                                      padding =
                                                          const EdgeInsets.only(
                                                              top: 17,
                                                              left: 145,
                                                              bottom: 26);
                                                    } else if (index == 1) {
                                                      padding =
                                                          const EdgeInsets.only(
                                                              right: 145,
                                                              bottom: 26);
                                                    } else if (index == 2) {
                                                      padding =
                                                          const EdgeInsets.only(
                                                              left: 145,
                                                              bottom: 20);
                                                    }
                                                    return Padding(
                                                      padding: padding,
                                                      child: SizedBox(
                                                        width: 498,
                                                        height: 178,
                                                        child: Card(
                                                          elevation: 5,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16)),
                                                          child: SizedBox(
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 24,
                                                                  horizontal:
                                                                      44),
                                                              child: Row(
                                                                children: [
                                                                  // For the first item
                                                                  if (index ==
                                                                      0)
                                                                    SizedBox(
                                                                      width:
                                                                          292,
                                                                      height:
                                                                          128,
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: const [
                                                                          Text(
                                                                            textAlign:
                                                                                TextAlign.justify,
                                                                            "I had an amazing experience as a paid intern at this company. Not only did I learn a lot about my field of interest, but I also had the chance to work on real projects and make a difference.",
                                                                            style:
                                                                                TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                                                                          ),
                                                                          SizedBox(
                                                                              height: 10),
                                                                          Text(
                                                                            textAlign:
                                                                                TextAlign.justify,
                                                                            "Mubarak Adam Ibnu Chambas",
                                                                            style:
                                                                                TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  const SizedBox(
                                                                      width:
                                                                          30),
                                                                  if (index ==
                                                                      0)
                                                                    Container(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              44,
                                                                          vertical:
                                                                              24),
                                                                      width: 80,
                                                                      height:
                                                                          80,
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        image:
                                                                            DecorationImage(
                                                                          image:
                                                                              AssetImage("assets/images/cham.png"),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  // For the second item
                                                                  if (index ==
                                                                      1)
                                                                    Container(
                                                                      width: 80,
                                                                      height:
                                                                          80,
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        image:
                                                                            DecorationImage(
                                                                          image:
                                                                              AssetImage('assets/images/amru.png'),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  const SizedBox(
                                                                      width:
                                                                          30),
                                                                  if (index ==
                                                                      1)
                                                                    Expanded(
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: const [
                                                                          Text(
                                                                            textAlign:
                                                                                TextAlign.justify,
                                                                            "My paid internship with this company was a game-changer for me. The company culture is incredible and I felt supported and valued throughout my entire internship.",
                                                                            style:
                                                                                TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                                                                          ),
                                                                          SizedBox(
                                                                              height: 10),
                                                                          Text(
                                                                            textAlign:
                                                                                TextAlign.justify,
                                                                            "Amrudin Ćatić",
                                                                            style:
                                                                                TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  // For the third item
                                                                  if (index ==
                                                                      2)
                                                                    Expanded(
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: const [
                                                                          Text(
                                                                            textAlign:
                                                                                TextAlign.justify,
                                                                            "I recently completed a paid internship as a full stack developer with this company, and it was an incredible experience.",
                                                                            style:
                                                                                TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                                                                          ),
                                                                          SizedBox(
                                                                              height: 10),
                                                                          Text(
                                                                            textAlign:
                                                                                TextAlign.justify,
                                                                            "Asmir Alić",
                                                                            style:
                                                                                TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  const SizedBox(
                                                                      width:
                                                                          30),
                                                                  if (index ==
                                                                      2)
                                                                    Container(
                                                                      width: 80,
                                                                      height:
                                                                          80,
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        image:
                                                                            DecorationImage(
                                                                          image:
                                                                              AssetImage("assets/images/asm.png"),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ))),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 412.0,
                  decoration: const BoxDecoration(color: Color(0xFF000000)),
                ),
              ],
            ),
            const FooterWidget()
          ],
        ),
      ),
    );
  }
}
