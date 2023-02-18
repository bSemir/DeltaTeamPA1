import 'package:flutter/material.dart';

class CongratsCard extends StatelessWidget {
  const CongratsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('name'),
          const Text('Congratulations'),
          const Text('You’ve successfully created an account'),
        ],
      ),
    );
  }
}
