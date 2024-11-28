import 'package:flutter/material.dart';
import 'package:gmail_app/common/presentation/widgets/avatar.dart';

class EmailChip extends StatelessWidget {
  const EmailChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      avatar: const Avatar(
        imageUrl:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRokEYt0yyh6uNDKL8uksVLlhZ35laKNQgZ9g&s",
        width: 20,
        height: 20,
      ),
      label: Container(
        constraints: const BoxConstraints(
          maxWidth: 200,
        ),
        child: const Text(
          'hoanghuynhtuankiet@gmail.com',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
