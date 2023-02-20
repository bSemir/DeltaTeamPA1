import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
        color: const Color(0xFFFFFFFF),
        width: width,
        height: 290,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/footer_logo.svg',
                width: (51.9 / 1440) * width,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.only(
                              left: (80 / 1440) * width,
                              right: (80 / 1440) * width),
                          child: const Divider(
                            color: Color.fromARGB(255, 187, 187, 187),
                            height: 60,
                          )))
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                    left: (80 / 1440) * width, right: (80 / 1440) * width),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/pin.svg',
                              // height: 21.65,
                              width: (18 / 1440) * width,
                            ),
                            SizedBox(width: (11.25 / 1440) * width),
                            SizedBox(
                              width: (467 / 1440) * width,
                              child: Text(
                                'Put Mladih Muslimana 2, City Gardens Residence, 71 000 Sarajevo, Bosnia and Herzegovina 14425 Falconhead Blvd, Bee Cave, TX 78738, United States 425',
                                style: GoogleFonts.notoSans(
                                  fontWeight: FontWeight.normal,
                                  color:
                                      const Color.fromARGB(255, 167, 166, 166),
                                  fontSize: (10 / 1440) * width,
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/email.svg',
                              // height: 16.14,
                              width: (18 / 1440) * width,
                            ),
                            SizedBox(width: (11.25 / 1440) * width),
                            SizedBox(
                              width: (150 / 1440) * width,
                              child: Text(
                                'hello@tech387.com',
                                style: GoogleFonts.notoSans(
                                  fontWeight: FontWeight.normal,
                                  color:
                                      const Color.fromARGB(255, 167, 166, 166),
                                  fontSize: (10 / 1440) * width,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      width: (37.75 / 1440) * width,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/facebook.svg',
                              // height: 37.48,
                              width: (37.45 / 1440) * width,
                            ),
                            SizedBox(
                              width: (18.5 / 1440) * width,
                            ),
                            SvgPicture.asset(
                              'assets/images/instagram.svg',
                              // height: 37.48,
                              width: (37.45 / 1440) * width,
                            ),
                            SizedBox(
                              width: (18.5 / 1440) * width,
                            ),
                            SvgPicture.asset(
                              'assets/images/linkedin.svg',
                              // height: 37.48,
                              width: (37.45 / 1440) * width,
                            ),
                            SizedBox(
                              width: (18.5 / 1440) * width,
                            ),
                            SvgPicture.asset(
                              'assets/images/tech387.svg',
                              // height: 37.48,
                              width: (37.45 / 1440) * width,
                            )
                          ],
                        ),
                        const SizedBox(height: 18.22),
                        Row(
                          children: <Widget>[
                            Text("© Credits, 2023, Product Arena",
                                style: GoogleFonts.notoSans(
                                  fontWeight: FontWeight.normal,
                                  color:
                                      const Color.fromARGB(255, 167, 166, 166),
                                  fontSize: (10 / 1440) * width,
                                ))
                          ],
                        )
                      ],
                    ),
                    SizedBox(width: (429.51 / 1440) * width),
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 14,
                              // width: (34 / 1440) * width,
                              child: Row(children: [
                                InkWell(
                                  key: const Key(
                                      'Not_routed_to_the_PrivacyPage'),
                                  onTap: () {
                                    // Navigate to privacy page
                                  },
                                  child: Text(
                                    "Privacy",
                                    style: GoogleFonts.notoSans(
                                      fontWeight: FontWeight.normal,
                                      color: const Color.fromARGB(
                                          255, 167, 166, 166),
                                      fontSize: (10 / 1440) * width,
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                            SizedBox(
                              width: (45 / 1440) * width,
                            ),
                            SizedBox(
                              height: 14,
                              // width: (24 / 1440) * width,
                              child: Row(children: [
                                InkWell(
                                  key: const Key('Not_routed_to_the_TermsPage'),
                                  onTap: () {
                                    // Navigate to privacy page
                                  },
                                  child: Text(
                                    "Terms",
                                    style: GoogleFonts.notoSans(
                                      fontWeight: FontWeight.normal,
                                      color: const Color.fromARGB(
                                          255, 167, 166, 166),
                                      fontSize: (10 / 1440) * width,
                                    ),
                                  ),
                                ),
                              ]),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ]));
  }
}
