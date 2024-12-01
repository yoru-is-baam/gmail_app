import 'package:flutter/material.dart';

class LabelItemText extends StatelessWidget {
  final String text;
  final double? fontSize;

  const LabelItemText({
    super.key,
    required this.text,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: const Color(0XFF44484e),
        fontSize: fontSize ?? 15,
      ),
    );
  }
}
