// ignore_for_file: deprecated_member_use

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:delta_team/features/homepage/Navbar_homepage.dart';
import 'package:delta_team/features/homepage/homepage_sidebar.dart';
import 'package:delta_team/features/homepage/provider/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
// ignore: unused_import

class ContactMeScreen extends StatefulWidget {
  const ContactMeScreen({super.key});

  @override
  State<ContactMeScreen> createState() => _ContactMeScreenState();
}

// Future<void> signInUser() async {
//   try {
//     await Amplify.Auth.signIn(
//       username: 'bhitoshdrgb@eurokool.com',
//       password: 'Pass123!',
//     );
//     safePrint('Loginovan');
//   } on AuthException catch (e) {
//     safePrint(e.message);
//   }
// }

bool isMessageSent = false;

class _ContactMeScreenState extends State<ContactMeScreen> {
  final _contactFormKey = GlobalKey<FormState>();
  final contactController = TextEditingController();

  Future<void> fetchCurrentUserAttributes(ContactWeb authProvider) async {
    try {
      final result = await Amplify.Auth.fetchUserAttributes();
      for (final element in result) {
        print('key: ${element.userAttributeKey}; value: ${element.value}');
        final attributeName = element.userAttributeKey
            .toString()
            .split(' ')
            .last
            .replaceAll('"', '');
        if (attributeName == "given_name") {
          authProvider.setName(element.value);
        } else if (attributeName == "email") {
          authProvider.setEmail(element.value);
        }
      }
      print("_----------------------------_");
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    double maxwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Row(
        children: [
          Expanded(
              flex: 3,
              child: Container(color: Colors.black, child: const Sidebar())),
          Expanded(
            flex: 7,
            child: MediaQuery.of(context).size.height > 670
                ? Column(
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.only(top: 10, bottom: 10, right: 50),
                        child: NavbarHomePage(),
                      ),
                      MediaQuery.of(context).size.height > 670
                          ? const SizedBox(height: 100)
                          : const SizedBox(),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 35,
                                  ),
                                  RichText(
                                    textAlign: TextAlign.right,
                                    text: TextSpan(
                                      text: 'CONTACT US\n',
                                      style: GoogleFonts.notoSans(
                                        fontSize: 32,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              'You are more than welcome to leave your\nmessage and we will be in touch shortly.\n\n\n',
                                          style: GoogleFonts.notoSans(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: maxwidth * (30 / 1440),
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    width: maxwidth * (350 / 1440),
                                    child: Form(
                                      key: _contactFormKey,
                                      child: TextFormField(
                                        key: const Key('contactField'),
                                        controller: contactController,
                                        validator: (value) {
                                          if (value == "" || value == null) {
                                            setState(() {
                                              isMessageSent = false;
                                            });
                                            return "Please type your message before sending";
                                          } else if (value.length < 10) {
                                            setState(() {
                                              isMessageSent = false;
                                            });
                                            return "Your message has to contain at least 10 characters";
                                          }
                                          safePrint('MessageSent');
                                          setState(() {
                                            isMessageSent = true;
                                          });
                                          return null;
                                        },
                                        maxLines: 8,
                                        decoration: InputDecoration(
                                          hintText: 'Your Message',
                                          hintStyle: GoogleFonts.notoSans(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF22E974),
                                            ),
                                          ),
                                          border: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                            ),
                                          ),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        style: GoogleFonts.notoSans(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: isMessageSent,
                                    child: Column(
                                      children: const [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Your message has been sent.',
                                          style: TextStyle(
                                            color: Color(0xFF22E974),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (_contactFormKey.currentState!.validate()) {
                                try {
                                  final restOperation = Amplify.API.post(
                                    'api/user/form',
                                    apiName: 'contactEmailDelta',
                                    body: HttpPayload.json(
                                      {
                                        'question':
                                            contactController.text.toString(),
                                      },
                                    ),
                                  );
                                  final response = await restOperation.response;
                                  safePrint('POST call succeeded');
                                  safePrint(response.decodeBody());
                                } on ApiException catch (e) {
                                  safePrint('POST call failed: ${e.message}');
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                minimumSize: const Size(141, 55)),
                            child: const Text(
                              'Submit',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: maxwidth * (110 / 1440),
                              ),
                              Flexible(
                                child: InkWell(
                                  child: Image.asset(
                                    'assets/images/facebook.png',
                                  ),
                                  onTap: () => launch(
                                      'https://www.facebook.com/tech387'),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: InkWell(
                                  child: Image.asset(
                                    'assets/images/instagram.png',
                                  ),
                                  onTap: () => launch(
                                      'https://www.instagram.com/tech387/?hl=en'),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: InkWell(
                                  child: Image.asset(
                                    'assets/images/linkedin.png',
                                  ),
                                  onTap: () => launch(
                                      'https://www.linkedin.com/company/tech-387/mycompany/'),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: InkWell(
                                  child: Image.asset(
                                    'assets/images/tech387.png',
                                  ),
                                  onTap: () =>
                                      launch('https://www.tech387.com/'),
                                ),
                              ),
                              const SizedBox(
                                width: 40,
                              ),
                              SizedBox(
                                width: maxwidth * (355 / 1440),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () async {
                                        await launchUrl(Uri.parse(
                                            'https://www.google.ba/maps/place/Tech387/@43.8538483,18.4205947,17z/data=!3m1!4b1!4m6!3m5!1s0x4758c903ae6b4fe1:0xa4116c0159094813!8m2!3d43.8538483!4d18.4227834!16s%2Fg%2F11h_6q3_47'));
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Image.asset(
                                            'assets/images/pin.png',
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Flexible(
                                            child: Text(
                                              'Put Mladih Muslimana 2, City Gardens Residence, 71 000 Sarajevo, Bosnia and Herzegovina\n 14425 Falconhead Blvd, Bee Cave, TX 78738, United States',
                                              style: GoogleFonts.notoSans(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Flexible(
                                          child: Image.asset(
                                            'assets/images/mail.png',
                                          ),
                                        ),
                                        SizedBox(
                                          width: maxwidth * (10 / 1440),
                                        ),
                                        Text(
                                          'hello@tech387.com',
                                          style: GoogleFonts.notoSans(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                : SingleChildScrollView(
                    child: Column(
                    children: [
                      const NavbarHomePage(),
                      MediaQuery.of(context).size.height > 670
                          ? const SizedBox(height: 100)
                          : const SizedBox(),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 35,
                                  ),
                                  RichText(
                                    textAlign: TextAlign.right,
                                    text: TextSpan(
                                      text: 'CONTACT US\n',
                                      style: GoogleFonts.notoSans(
                                        fontSize: 32,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              'You are more than welcome to leave your\nmessage and we will be in touch shortly.\n\n\n',
                                          style: GoogleFonts.notoSans(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: maxwidth * (30 / 1440),
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    width: maxwidth * (350 / 1440),
                                    child: Form(
                                      key: _contactFormKey,
                                      child: TextFormField(
                                        key: const Key('contactField'),
                                        controller: contactController,
                                        validator: (value) {
                                          if (value == "" || value == null) {
                                            setState(() {
                                              isMessageSent = false;
                                            });
                                            return "Please type your message before sending";
                                          } else if (value.length < 10) {
                                            setState(() {
                                              isMessageSent = false;
                                            });
                                            return "Your message has to contain at least 10 characters";
                                          }
                                          safePrint('MessageSent');
                                          setState(() {
                                            isMessageSent = true;
                                          });
                                          return null;
                                        },
                                        maxLines: 8,
                                        decoration: InputDecoration(
                                          hintText: 'Your Message',
                                          hintStyle: GoogleFonts.notoSans(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF22E974),
                                            ),
                                          ),
                                          border: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                            ),
                                          ),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        style: GoogleFonts.notoSans(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: isMessageSent,
                                    child: Column(
                                      children: const [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Your message has been sent.',
                                          style: TextStyle(
                                            color: Color(0xFF22E974),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (_contactFormKey.currentState!.validate()) {
                                final authProvider = Provider.of<ContactWeb>(
                                    context,
                                    listen: false);
                                await fetchCurrentUserAttributes(authProvider);
                                final name = authProvider.name;
                                final email = authProvider.email;
                                try {
                                  final restOperation = Amplify.API.post(
                                    'api/user/form',
                                    apiName: 'contactEmailDelta',
                                    body: HttpPayload.json(
                                      {
                                        'question':
                                            contactController.text.toString(),
                                        'name': name,
                                        'email': email
                                      },
                                    ),
                                  );
                                  final response = await restOperation.response;
                                  safePrint('POST call succeeded');
                                  safePrint(response.decodeBody());
                                } on ApiException catch (e) {
                                  safePrint('POST call failed: ${e.message}');
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                minimumSize: const Size(141, 55)),
                            child: const Text(
                              'Submit',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: maxwidth * (110 / 1440),
                              ),
                              Flexible(
                                child: InkWell(
                                  child: Image.asset(
                                    'assets/images/facebook.png',
                                  ),
                                  onTap: () => launch(
                                      'https://www.facebook.com/tech387'),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: InkWell(
                                  child: Image.asset(
                                    'assets/images/instagram.png',
                                  ),
                                  onTap: () => launch(
                                      'https://www.instagram.com/tech387/?hl=en'),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: InkWell(
                                  child: Image.asset(
                                    'assets/images/linked.png',
                                  ),
                                  onTap: () => launch(
                                      'https://www.linkedin.com/company/tech-387/mycompany/'),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: InkWell(
                                  child: Image.asset(
                                    'assets/images/tech.png',
                                  ),
                                  onTap: () =>
                                      launch('https://www.tech387.com/'),
                                ),
                              ),
                              const SizedBox(
                                width: 40,
                              ),
                              SizedBox(
                                width: maxwidth * (355 / 1440),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () async {
                                        await launchUrl(Uri.parse(
                                            'https://www.google.ba/maps/place/Tech387/@43.8538483,18.4205947,17z/data=!3m1!4b1!4m6!3m5!1s0x4758c903ae6b4fe1:0xa4116c0159094813!8m2!3d43.8538483!4d18.4227834!16s%2Fg%2F11h_6q3_47'));
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Image.asset(
                                            'assets/images/pinlocation.png',
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Flexible(
                                            child: Text(
                                              'Put Mladih Muslimana 2, City Gardens Residence, 71 000 Sarajevo, Bosnia and Herzegovina\n 14425 Falconhead Blvd, Bee Cave, TX 78738, United States',
                                              style: GoogleFonts.notoSans(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Flexible(
                                          child: Image.asset(
                                            'assets/images/mail.png',
                                          ),
                                        ),
                                        SizedBox(
                                          width: maxwidth * (10 / 1440),
                                        ),
                                        Text(
                                          'hello@tech387.com',
                                          style: GoogleFonts.notoSans(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )),
          ),
        ],
      ),
    );
  }
}
