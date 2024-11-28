import 'package:flutter/material.dart';

class LabelFormField extends StatelessWidget {
  final String label;

  const LabelFormField({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 17,
        ),
      ),
    );
  }
}
