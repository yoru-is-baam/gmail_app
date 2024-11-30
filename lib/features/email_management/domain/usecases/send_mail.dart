import 'package:gmail_app/config/resources/date_state.dart';
import 'package:gmail_app/core/usecase/usecase.dart';
import 'package:gmail_app/features/email_management/domain/entities/mail.dart';
import 'package:gmail_app/features/email_management/domain/repositories/mail_repository.dart';

class SendMailUseCase implements UseCase<void, MailEntity> {
  final MailRepository _mailRepository;

  SendMailUseCase(this._mailRepository);

  @override
  Future<DataState<void>> call({MailEntity? params}) {
    return _mailRepository.sendMail(params!);
  }
}
