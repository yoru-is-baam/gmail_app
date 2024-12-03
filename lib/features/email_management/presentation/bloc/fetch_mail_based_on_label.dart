import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gmail_app/core/constants/label.dart';
import 'package:gmail_app/features/email_management/presentation/bloc/mail/remote/remote_mail_bloc.dart';
import 'package:gmail_app/features/email_management/presentation/bloc/mail/remote/remote_mail_event.dart';

void fetchMailsBasedOnLabel(BuildContext context, Label selectedLabel) {
  switch (selectedLabel) {
    case Label.inbox:
      context.read<RemoteMailBloc>().add(const GetInboxMails());
      break;
    case Label.starred:
      context.read<RemoteMailBloc>().add(const GetStarredMails());
      break;
    case Label.sent:
      context.read<RemoteMailBloc>().add(const GetSentMails());
      break;
    case Label.drafts:
      context.read<RemoteMailBloc>().add(const GetDraftMails());
      break;
    case Label.trash:
      context.read<RemoteMailBloc>().add(const GetTrashMails());
      break;
    default:
      context.read<RemoteMailBloc>().add(const GetInboxMails());
      break;
  }
}
