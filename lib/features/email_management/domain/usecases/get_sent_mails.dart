import 'package:gmail_app/config/resources/date_state.dart';
import 'package:gmail_app/core/usecase/usecase.dart';
import 'package:gmail_app/features/email_management/domain/entities/mail.dart';
import 'package:gmail_app/features/email_management/domain/repositories/mail_repository.dart';
import 'package:gmail_app/features/email_management/domain/usecases/params/get_sent_mails_params.dart';

class GetSentMailsUseCase
    implements UseCase<DataState<List<MailEntity>>, GetSentMailsParams> {
  final MailRepository _mailRepository;

  GetSentMailsUseCase(this._mailRepository);

  @override
  Future<DataState<List<MailEntity>>> call({GetSentMailsParams? params}) {
    return _mailRepository.getSentMails(isDraft: params?.isDraft);
  }
}
