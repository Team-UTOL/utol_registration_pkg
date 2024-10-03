library registration_pkg;

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final onPressed;
  final Widget child;
  final style;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.child,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(16.0),
          backgroundColor: Colors.blue,
          elevation: 9.0,
          textStyle: const TextStyle(
            fontSize: 20,
          ),
        ),
        child: child);
  }
}
