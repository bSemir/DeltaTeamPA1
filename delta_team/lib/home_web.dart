import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:delta_team/features/auth/loadingScreens/loadingscreen_mobile.dart';
import 'package:delta_team/features/auth/login/amplify_auth.dart';
import 'package:delta_team/features/auth/login/login_mobile/loginmobile_body.dart';
import 'package:delta_team/features/auth/login/login_web/loginweb_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreenWeb extends StatelessWidget {
  static const routeName = '/homeweb';
  const HomeScreenWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
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
                    print(e.message);
                  }
                });
              },
              child: SvgPicture.asset('assets/images/logotop.svg'),
            ),
            Text('HomePage',
                style: GoogleFonts.notoSans(
                  fontSize: 45.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ))
          ],
        ),
      ),
    );
  }
}
