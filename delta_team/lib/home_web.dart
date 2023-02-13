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
      body: Center(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/images/Banner.png', width: 1600
                    // height: 477,

                    )
              ],
            ),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     InkWell(
            //       onTap: () async {
            //         WidgetsBinding.instance.addPostFrameCallback((_) {
            //           Navigator.of(context).pop();
            //           try {
            //             signOutCurrentUser(null, null, context);
            //             safePrint('User Signed Out');
            //             Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) => const MyDesktopBody()),
            //             );
            //           } on AmplifyException catch (e) {
            //             safePrint(e.message);
            //           }
            //         });
            //       },
            //       child: Image.asset('assets/images/logotop.png'),
            //     ),
            //     Text('HomePage',
            //         style: GoogleFonts.notoSans(
            //           fontSize: 32.0,
            //           color: Colors.black,
            //           fontWeight: FontWeight.w400,
            //         ))
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
