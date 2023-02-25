import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:delta_team/common/custom_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'amplifyconfiguration.dart';
import 'features/auth/loadingScreens/loadingscreen_mobile.dart';

class ContactMobile extends StatefulWidget {
  const ContactMobile({super.key});

  @override
  State<ContactMobile> createState() => _ContactMobileState();
}

// void _submitForm(BuildContext context) async {
//   final message = messageController.text;
//   try {
//     final restOperation = Amplify.API.post(
//       'message',
//       apiName: contactEmailDelta,
//       body: HttpPayload.json(
//         {
//           'message': message.toString(),
//         },
//       ),
//     );
//     final response = await restOperation.response;
//     safePrint('POST call succeeded');
//     safePrint(response.decodeBody());
//   } catch (e) {
//     safePrint('POST call failed: ${e.message}');
//   }
// }

// void safePrint(String message) {
//   if (!kReleaseMode) {
//     print(message);
//   }
// }

// void _submitForm(BuildContext context) async {
//   final message = messageController.text;

//   try {
//     await Amplify.API.post(
//       restOptions: RestOptions(
//         path: '/messages',
//       ),
//       body: {
//         'message': message,
//       },
//     );
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Message sent!'),
//       ),
//     );
//     messageController.clear();
//   } catch (e) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Failed to send message.'),
//       ),
//     );
//   }
// }

class _ContactMobileState extends State<ContactMobile> {
  final messageController = TextEditingController();
  void _submitForm(BuildContext context) async {
    final message = messageController.text;
    if (message.trim().isEmpty) {
      return;
    }
    try {
      final restOperation = Amplify.API.post(
        'contactEmailDelta',
        body: HttpPayload.json({'message': message}),
        apiName: 'contactEmailDelta',
      );
      final response = await restOperation.response;
      print(response.decodeBody());

      print(response);
      // show success message to user
    } catch (e) {
      print('Error sending email: $e');
      // show error message to user
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            "assets/images/navbar_logo.svg",
            semanticsLabel: 'Confirmation SVG',
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFF000000)),
            onPressed: () {
              // Add function to execute when menu icon is pressed
            },
          ),
        ],
      ),
      backgroundColor: const Color(0xFF000000),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 42, top: 27, bottom: 20),
              child: Row(
                children: [
                  SvgPicture.asset("assets/images/contact-icon.svg",
                      semanticsLabel: 'Confirmation SVG'),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    'Contact Us',
                    style: GoogleFonts.notoSans(
                        color: const Color(0xFFFFFFFF),
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      key: const Key("messageKey"),
                      controller: messageController,
                      style: GoogleFonts.notoSans(
                        color: const Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Leave us a message!',
                        hintStyle: GoogleFonts.notoSans(
                            color: const Color(0xFFF3F3F9),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFFFFFFF))),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFF3F3F9)),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFF3F3F9)),
                        ),
                        disabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFF3F3F9))),
                      ),
                      maxLines: 11, //
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      width: 90,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 10,
                            backgroundColor: const Color(0xFF000000),
                            side: const BorderSide(
                                color: Color(0xFFFFFFFF), width: 2),
                          ),
                          onPressed: () {
                            _submitForm(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7.5),
                            child: Center(
                                child: Text(
                              'Submit',
                              style: TextStyle(
                                  color: const Color(0xFFFFFFFF),
                                  fontSize: (14 / 360) * width,
                                  fontWeight: FontWeight.w700),
                            )),
                          )),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: Row(
                children: [
                  SvgPicture.asset("assets/images/contactmail.svg",
                      semanticsLabel: 'Confirmation SVG'),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'hello@tech387.com',
                    style: GoogleFonts.notoSans(
                        color: const Color(0xFFFFFFFF),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40.72, right: 19.28),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset("assets/images/contactpin.svg",
                      semanticsLabel: 'Confirmation SVG'),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Put Mladih Muslimana 2, City Gardens Residence,  71 000 Sarajevo, Bosnia and Herzegovina',
                          style: GoogleFonts.notoSans(
                              color: const Color(0xFFFFFFFF),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '14425 Falconhead Blvd, Bee Cave, TX 78738, United States',
                          style: GoogleFonts.notoSans(
                              color: const Color(0xFFFFFFFF),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 98,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
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
                          key: const Key('routed_to_loadingScreen'),
                          onTap: () async {
                            Navigator.pushNamed(
                                context, LoadingScreenMobile.routeName);
                            // Navigate to privacy page
                          },
                          child: Text(
                            "Privacy",
                            style: GoogleFonts.notoSans(
                              fontWeight: FontWeight.w400,
                              color: const Color.fromARGB(255, 142, 142, 142),
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
                                color: const Color.fromARGB(255, 142, 142, 142),
                                fontSize: 12.0),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          key: const Key('routed_to_LoadingScreen'),
                          onTap: () async {
                            Navigator.pushNamed(
                                context, LoadingScreenMobile.routeName);
                            // Navigate to privacy page
                          },
                          child: Text(
                            "Terms",
                            style: GoogleFonts.notoSans(
                                fontWeight: FontWeight.w400,
                                color: const Color.fromARGB(255, 142, 142, 142),
                                fontSize: 13.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
