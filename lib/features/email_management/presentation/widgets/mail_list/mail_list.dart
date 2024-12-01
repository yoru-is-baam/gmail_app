import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gmail_app/features/email_management/presentation/bloc/mail/remote/remote_mail_bloc.dart';
import 'package:gmail_app/features/email_management/presentation/bloc/mail/remote/remote_mail_state.dart';
import 'package:gmail_app/features/email_management/presentation/widgets/mail_list/mail_list_item.dart';

class MailList extends StatelessWidget {
  const MailList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemoteMailBloc, RemoteMailState>(
      builder: (_, state) {
        if (state is RemoteMailLoading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }

        if (state is RemoteMailError) {
          return const Center(
            child: Icon(Icons.refresh),
          );
        }

        if (state is RemoteMailDone) {
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final mail = state.mails![index];

              return MailListItem(
                name: mail.id.toString(),
                subject: mail.subject,
                body: mail.body,
                isStarred: mail.isStarred,
                sentAt: mail.createdAt!,
              );
            },
            itemCount: state.mails!.length,
          );
        }

        return const SizedBox();
      },
    );
  }
}
