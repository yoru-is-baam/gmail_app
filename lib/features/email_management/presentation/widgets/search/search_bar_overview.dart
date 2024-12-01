import 'package:flutter/material.dart';
import 'package:gmail_app/common/presentation/widgets/avatar.dart';

class SearchBarOverview extends StatelessWidget {
  final void Function()? onPressed;

  const SearchBarOverview({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      backgroundColor: WidgetStateProperty.all(
        const Color(0xFFdee4ec),
      ),
      elevation: WidgetStateProperty.all(0),
      leading: IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.menu),
      ),
      trailing: [
        GestureDetector(
          onTap: () {},
          child: const Avatar(
            width: 38,
            height: 38,
            imageUrl:
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRZpm4kYnGGLtzvpqte11fSAoxKW-D-gNXOsA&s",
          ),
        )
      ],
      hintText: "Search in mail",
    );
  }
}
