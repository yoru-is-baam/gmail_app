import 'package:flutter/material.dart';
import 'package:gmail_app/common/presentation/widgets/avatar.dart';
import 'package:gmail_app/features/email_management/presentation/widgets/mail_list/mail_list_item_text.dart';
import 'package:gmail_app/features/email_management/presentation/widgets/mail_list/star_toggle_button.dart';

class MailListItem extends StatelessWidget {
  final bool isStarred;
  final String name;
  final String? subject;
  final String? body;

  const MailListItem({
    super.key,
    this.isStarred = false,
    required this.name,
    this.subject,
    this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Avatar(
            imageUrl:
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRokEYt0yyh6uNDKL8uksVLlhZ35laKNQgZ9g&s",
            width: 40,
            height: 40,
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MailListItemText(
                      text: name,
                      fontSize: 16,
                      isRead: true,
                    ),
                    const MailListItemText(
                      text: "20:14",
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MailListItemText(
                            isRead: true,
                            text: subject ?? "(no subject)",
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          MailListItemText(
                            text: body ?? "",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 28,
                    ),
                    StarToggleButton(
                      onTap: () => {},
                      isStarred: isStarred,
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
