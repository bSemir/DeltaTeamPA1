import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RowFooter extends StatelessWidget {
  final double widthLocation;
  final bool spaceText;
  final double widthImages;
  const RowFooter(
      {super.key,
      required this.widthLocation,
      required this.spaceText,
      required this.widthImages});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: widthLocation,
              child: Row(
                children: [
                  const Icon(
                    Icons.location_pin,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 11.25,
                  ),
                  spaceText
                      ? const SelectableText(
                          "Put Mladih Muslimana 2,\nCity Gardens Residence,\n71 000 Sarajevo, Bosnia and Herzegovina 14425 Falconhead Blvd, Bee Cave,\nTX 78738, United States",
                          style: TextStyle(fontSize: 10))
                      : const SelectableText(
                          "Put Mladih Muslimana 2, City Gardens Residence, 71 000 Sarajevo, Bosnia and Herzegovina 14425 Falconhead Blvd, Bee Cave, TX 78738, United States",
                          style: TextStyle(fontSize: 10),
                        ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: const [
                Icon(
                  Icons.mail,
                  size: 20,
                ),
                SizedBox(
                  width: 11.25,
                ),
                Text(
                  "hello@tech387.com",
                  style: TextStyle(fontSize: 10),
                )
              ],
            )
          ],
        ),
        const Spacer(),
        SizedBox(
          width: widthImages,
          child: Row(
            children: [
              Row(
                children: [
                  GestureDetector(
                    key: const Key('fbKey'),
                    onTap: () {
                      print("FACEBOOK");
                      launchUrl(Uri.parse('https://www.facebook.com/tech387'));
                    },
                    child: Image.asset(
                      "assets/images/facebook.png",
                      width: 37.5,
                      height: 37.37,
                    ),
                  ),
                  const SizedBox(
                    width: 18.5,
                  ),
                  GestureDetector(
                    key: const Key('instagramkey'),
                    onTap: () {
                      launchUrl(Uri.parse(
                          'https://www.instagram.com/tech387/?hl=en'));
                    },
                    child: Image.asset(
                      "assets/images/instagram.png",
                      width: 37.5,
                      height: 37.37,
                    ),
                  ),
                  const SizedBox(
                    width: 18.5,
                  ),
                  GestureDetector(
                    key: const Key('linkedinkey'),
                    onTap: () {
                      launchUrl(Uri.parse(
                          'https://www.linkedin.com/company/tech-387/mycompany/'));
                    },
                    child: Image.asset(
                      "assets/images/linkedin.png",
                      width: 37.5,
                      height: 37.37,
                    ),
                  ),
                  const SizedBox(
                    width: 18.5,
                  ),
                  GestureDetector(
                    key: const Key('keytech'),
                    onTap: () {
                      launchUrl(Uri.parse('https://www.tech387.com/'));
                    },
                    child: Image.asset(
                      "assets/images/tech387.png",
                      width: 37.5,
                      height: 37.37,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Spacer(),
        Row(
          children: const [
            Text("Privacy",
                style: TextStyle(
                    fontSize: 10, color: Color.fromRGBO(120, 120, 120, 1))),
            SizedBox(
              width: 45,
            ),
            Text(
              "Terms",
              style: TextStyle(
                  fontSize: 10, color: Color.fromRGBO(120, 120, 120, 1)),
            )
          ],
        )
      ],
    );
  }
}
