import 'package:flutter/material.dart';

class PaddedWidget extends StatelessWidget {
  final Widget child;

  const PaddedWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: child,
    );
  }
}
