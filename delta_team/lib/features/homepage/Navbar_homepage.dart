import 'package:flutter/material.dart';

class NavbarHomePage extends StatefulWidget {
  const NavbarHomePage({super.key});

  @override
  State<NavbarHomePage> createState() => _NavbarHomePageState();
}

class _NavbarHomePageState extends State<NavbarHomePage> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: const [
        Icon(
          Icons.account_circle_rounded,
          color: Colors.green,
          size: 50,
        ),
      ],
    );
  }
}
