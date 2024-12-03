import 'package:equatable/equatable.dart';
import 'package:gmail_app/features/email_management/domain/entities/mail.dart';

abstract class RemoteMailState extends Equatable {
  final List<MailEntity>? inboxMails;
  final List<MailEntity>? starredMails;
  final List<MailEntity>? sentMails;
  final Exception? error;

  const RemoteMailState({
    this.inboxMails,
    this.starredMails,
    this.sentMails,
    this.error,
  });

  @override
  List<Object?> get props => [
        inboxMails,
        starredMails,
        sentMails,
        error,
      ];
}

class RemoteMailLoading extends RemoteMailState {
  const RemoteMailLoading();
}

class RemoteMailInboxDone extends RemoteMailState {
  const RemoteMailInboxDone(List<MailEntity>? inboxMails)
      : super(inboxMails: inboxMails);
}

class RemoteMailStarredDone extends RemoteMailState {
  const RemoteMailStarredDone(List<MailEntity>? starredMails)
      : super(starredMails: starredMails);
}

class RemoteMailSentDone extends RemoteMailState {
  const RemoteMailSentDone(List<MailEntity>? sentMails)
      : super(sentMails: sentMails);
}

class RemoteMailSent extends RemoteMailState {
  const RemoteMailSent();
}

class SaveAsDraftDone extends RemoteMailState {
  const SaveAsDraftDone();
}

class RemoteMailError extends RemoteMailState {
  const RemoteMailError(Exception error) : super(error: error);
}
