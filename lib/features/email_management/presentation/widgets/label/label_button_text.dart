import 'package:flutter/material.dart';

class LabelButtonText extends StatelessWidget {
  final String text;

  const LabelButtonText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 15,
      ),
    );
  }
}
