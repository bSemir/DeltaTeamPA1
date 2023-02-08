// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget leading;
  final Widget action;

  const CustomAppBar({
    super.key,
    this.title = '',
    required this.leading,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 70.0,
      padding: EdgeInsets.only(
          left: (50 / 1440) * width, right: (50 / 1440) * width),
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF),
      ),
      child: Row(
        children: [
          leading == null
              ? SizedBox(width: (170 / 1440) * width, height: 34.0)
              : SizedBox(
                  width: (170 / 1440) * width,
                  height: 34.0,
                  child: leading,
                ),
          Expanded(
            child: Container(
              height: 22.0,
              width: (62 / 1440) * width,
              alignment: Alignment.center,
              child: Text(
                title,
                style: GoogleFonts.notoSans(
                  fontWeight: FontWeight.w400,
                  fontSize: (16 / 1440) * width,
                  color: const Color(0xFF000000),
                ),
              ),
            ),
          ),
          SizedBox(
            width: (83 / 1440) * width,
          ),
          action == null
              ? SizedBox(width: (92 / 1440) * width, height: 34.0)
              : SizedBox(
                  width: (92 / 1440) * width,
                  height: 34.0,
                  child: action,
                ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70.0);
}
