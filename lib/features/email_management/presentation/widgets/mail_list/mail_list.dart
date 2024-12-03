import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmail_app/features/email_management/domain/entities/mail.dart';
import 'package:gmail_app/features/email_management/presentation/widgets/mail_list/mail_list_item.dart';

class MailList extends StatelessWidget {
  final List<MailEntity> mails;
  final void Function(String mailId, bool isStarred)? onTap;

  const MailList({
    super.key,
    required this.mails,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final mail = mails[index];

        return MailListItem(
          key: ValueKey(mail.id),
          name: mail.id.toString(),
          subject: mail.subject,
          body: mail.body,
          isStarred: mail.isStarred,
          isDraft: mail.isDraft,
          isRead: mail.isRead,
          sentAt: mail.createdAt!,
          onTap: () => onTap!(mail.id!, mail.isStarred),
        );
      },
      itemCount: mails.length,
    );
  }
}
