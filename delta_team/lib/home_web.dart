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
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: 747.0,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("assets/images/homeBackground.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  width: 720,
                  padding: const EdgeInsets.only(left: 32.0),
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
                        height: 118,
                        width: 607,
                        child: Expanded(
                          child: Text(
                              "Take the first step towards a successful career in tech.",
                              style: GoogleFonts.notoSans(
                                fontSize: (48 / 1440) * width,
                                color: const Color(0xFFFFFFFF),
                                fontWeight: FontWeight.w400,
                              )),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        child: const Text("GET STARTED"),
                        onPressed: () {
                          // Add your button action here
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 100.0,
                height: 100.0,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("assets/images/illustrationHome.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              //   child: Column(
              //     children: [
              //       Expanded(
              //         child: Stack(
              //           children: [
              //             Container(
              //               width: width,
              //               height: 747,
              //               decoration: const BoxDecoration(
              //                 image: DecorationImage(
              //                   image: AssetImage('assets/images/homeBackground.png'),
              //                   fit: BoxFit.cover,
              //                 ),
              //               ),
              //             ),
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.start,
              //               children: [
              //                 Row(
              //                   children: [
              //                     RichText(
              //                       text: TextSpan(
              //                         children: [
              //                           TextSpan(
              //                               text: 'Trust',
              //                               style: GoogleFonts.notoSans(
              //                                 fontSize: (60 / 1440) * width,
              //                                 color: const Color(0xFF22E974),
              //                                 fontWeight: FontWeight.w700,
              //                               )),
              //                         ],
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //                 Row(
              //                   children: [
              //                     RichText(
              //                       text: TextSpan(
              //                         children: [
              //                           TextSpan(
              //                               text: ' the process',
              //                               style: GoogleFonts.notoSans(
              //                                 fontSize: (60 / 1440) * width,
              //                                 color: const Color(0xFF22E974),
              //                                 fontWeight: FontWeight.w700,
              //                               )),
              //                         ],
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //                 Column(
              //                   children: [
              //                     RichText(
              //                       text: TextSpan(
              //                         children: [
              //                           TextSpan(
              //                               text:
              //                                   'Take the first step towards a successful career in tech.',
              //                               style: GoogleFonts.notoSans(
              //                                 fontSize: (48 / 1440) * width,
              //                                 color: const Color(0xFFFFFFFF),
              //                                 fontWeight: FontWeight.w400,
              //                               )),
              //                         ],
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //                 Column(
              //                   children: [Row(), Row()],
              //                 )
              //               ],
              //             ),
              //             Center(
              //               child: Row(
              //                 mainAxisAlignment: MainAxisAlignment.end,
              //                 children: [
              //                   Image.asset('assets/images/illustrationHome.png')
              //                 ],
              //               ),
              //             )
              //           ],
              //         ),
              //       ),
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
            ],
          ),
        ));
  }
}
