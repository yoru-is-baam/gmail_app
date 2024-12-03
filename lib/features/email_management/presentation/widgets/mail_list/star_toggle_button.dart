import 'package:flutter/material.dart';

class StarToggleButton extends StatelessWidget {
  final bool isStarred;
  final void Function()? onTap;

  const StarToggleButton({
    super.key,
    this.onTap,
    this.isStarred = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: isStarred
          ? const Icon(
              Icons.star_outlined,
              color: Color(0xFF0075b1),
            )
          : const Icon(Icons.star_border_outlined),
    );
  }
}
