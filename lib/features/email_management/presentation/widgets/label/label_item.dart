import 'package:flutter/material.dart';
import 'package:gmail_app/features/email_management/presentation/widgets/label/label_item_text.dart';

class LabelItem extends StatelessWidget {
  final IconData iconData;
  final Color? color;
  final String title;
  final String? numberOfMails;
  final bool isActive;
  final void Function() onTap;

  const LabelItem({
    super.key,
    required this.iconData,
    required this.title,
    this.numberOfMails,
    this.color,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Material(
        color: isActive ? const Color(0xFFd1e4f4) : Colors.transparent,
        borderRadius: BorderRadius.circular(50),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: onTap,
          child: ListTile(
            leading: Icon(iconData, color: color),
            title: LabelItemText(text: title),
            trailing: numberOfMails != null
                ? LabelItemText(text: numberOfMails!)
                : null,
          ),
        ),
      ),
    );
  }
}
