import 'package:equatable/equatable.dart';
import 'package:gmail_app/features/email_management/domain/entities/mail.dart';

abstract class RemoteMailEvent extends Equatable {
  final MailEntity? mail;

  const RemoteMailEvent({this.mail});

  @override
  List<Object?> get props => [mail];
}

class GetMails extends RemoteMailEvent {
  const GetMails();
}

class SendMail extends RemoteMailEvent {
  const SendMail(MailEntity mail) : super(mail: mail);
}
