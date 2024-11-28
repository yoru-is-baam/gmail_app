import 'package:flutter/material.dart';
import 'package:gmail_app/features/email_management/presentation/widgets/mail_list/mail_list_item.dart';

class MailList extends StatelessWidget {
  const MailList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return const MailListItem(
          name: "Notion",
          body: "Have a nothing",
          isStarred: true,
        );
      },
      itemCount: 5,
    );
  }
}
