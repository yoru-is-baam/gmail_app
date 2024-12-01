import 'package:gmail_app/config/resources/date_state.dart';
import 'package:gmail_app/core/usecase/usecase.dart';
import 'package:gmail_app/features/email_management/domain/entities/sender_mail.dart';
import 'package:gmail_app/features/email_management/domain/repositories/mail_repository.dart';

class SendMailUseCase implements UseCase<void, SenderMailEntity> {
  final MailRepository _mailRepository;

  SendMailUseCase(this._mailRepository);

  @override
  Future<DataState<void>> call({SenderMailEntity? params}) {
    return _mailRepository.sendMail(params!);
  }
}
