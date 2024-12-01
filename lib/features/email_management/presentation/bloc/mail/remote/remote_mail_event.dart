import 'package:equatable/equatable.dart';
import 'package:gmail_app/features/email_management/domain/entities/sender_mail.dart';
import 'package:gmail_app/features/email_management/domain/usecases/update_mail.dart';

abstract class RemoteMailEvent extends Equatable {
  final SenderMailEntity? mail;
  final UpdateMailsParams? fields;

  const RemoteMailEvent({
    this.mail,
    this.fields,
  });

  @override
  List<Object?> get props => [mail, fields];
}

class GetInboxMails extends RemoteMailEvent {
  const GetInboxMails();
}

class GetStarredMails extends RemoteMailEvent {
  const GetStarredMails();
}

class GetSentMails extends RemoteMailEvent {
  const GetSentMails();
}

class GetDraftMails extends RemoteMailEvent {
  const GetDraftMails();
}

class GetTrashMails extends RemoteMailEvent {
  const GetTrashMails();
}

class SendMail extends RemoteMailEvent {
  const SendMail(SenderMailEntity mail) : super(mail: mail);
}

class UpdateMail extends RemoteMailEvent {
  const UpdateMail(UpdateMailsParams fields) : super(fields: fields);
}
