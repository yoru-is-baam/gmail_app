import 'package:flutter/material.dart';
import 'package:gmail_app/core/utils/get_random_color.dart';

class EmailChip extends StatelessWidget {
  final String? imageUrl;
  final String email;
  final void Function() onDeleted;

  const EmailChip({
    super.key,
    this.imageUrl,
    required this.email,
    required this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      onDeleted: onDeleted,
      backgroundColor: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      avatar: CircleAvatar(
        backgroundColor: getRandomColor(),
        child: Text(
          email[0].toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      label: Container(
        constraints: const BoxConstraints(
          maxWidth: 200,
        ),
        child: Text(
          email,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
