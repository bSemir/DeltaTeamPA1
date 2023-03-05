import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color color;
  final Function buttonFunction;
  final Widget content;

  const CustomButton({
    Key? key,
    required this.content,
    required this.buttonFunction,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 60,
      width: (296 / 360) * width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
        ),
        onPressed: () {
          buttonFunction();
        },
        child: content,
      ),
    );
  }
}
