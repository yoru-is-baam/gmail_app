import 'package:flutter/material.dart';

class MailListItemText extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final bool isRead;

  const MailListItemText({
    super.key,
    required this.text,
    this.isRead = false,
    this.fontWeight,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: isRead ? FontWeight.bold : fontWeight,
        fontSize: fontSize,
      ),
    );
  }
}
