import 'package:equatable/equatable.dart';
import 'package:gmail_app/features/email_management/domain/entities/mail.dart';

abstract class RemoteMailState extends Equatable {
  final List<MailEntity>? mails;
  final Exception? error;

  const RemoteMailState({
    this.mails,
    this.error,
  });

  @override
  List<Object?> get props => [mails, error];
}

class RemoteMailLoading extends RemoteMailState {
  const RemoteMailLoading();
}

class RemoteMailDone extends RemoteMailState {
  const RemoteMailDone(List<MailEntity>? mails) : super(mails: mails);
}

class RemoteMailError extends RemoteMailState {
  const RemoteMailError(Exception error) : super(error: error);
}
