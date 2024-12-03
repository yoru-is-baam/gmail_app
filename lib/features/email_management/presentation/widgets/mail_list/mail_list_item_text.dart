import 'package:flutter/material.dart';

class MailListItemText extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final bool? isRead;
  final bool? isDraft;

  const MailListItemText({
    super.key,
    required this.text,
    this.isRead,
    this.isDraft,
    this.fontWeight,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      isDraft != null && isDraft! ? "Draft" : text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: isRead != null && isRead! ? fontWeight : FontWeight.bold,
        fontSize: fontSize,
        color: isDraft != null && isDraft! ? const Color(0xFFe83e23) : null,
      ),
    );
  }
}
