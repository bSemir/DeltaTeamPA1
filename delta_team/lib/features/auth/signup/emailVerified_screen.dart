import 'package:flutter/material.dart';

class EmailVerifiedScreen extends StatefulWidget {
  const EmailVerifiedScreen({super.key});

  @override
  State<EmailVerifiedScreen> createState() => _EmailVerifiedScreenState();
}

class _EmailVerifiedScreenState extends State<EmailVerifiedScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1133,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/paBackground.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 742,
            height: 465,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 85,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Image.asset("images/check_circle.png"),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Email Verified",
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 13),
                  child: Text(
                    "Your email is successfully verified",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400),
                  ),
                ),
                //user inputs digits field
              ],
            ),
          )
        ],
      ),
    );
    ;
  }
}
