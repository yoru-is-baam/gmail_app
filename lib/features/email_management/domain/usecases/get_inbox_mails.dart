import 'package:gmail_app/core/usecase/usecase.dart';
import 'package:gmail_app/features/email_management/domain/entities/mail.dart';
import 'package:gmail_app/features/email_management/domain/repositories/mail_repository.dart';
import 'package:gmail_app/features/email_management/domain/usecases/params/get_mails_params.dart';

class GetInboxMailsUseCase
    implements UseCaseStream<List<MailEntity>, GetMailsParams> {
  final MailRepository _mailRepository;

  GetInboxMailsUseCase(this._mailRepository);

  @override
  Stream<List<MailEntity>> call({GetMailsParams? params}) {
    return _mailRepository.getInboxMails(
      isStarred: params?.isStarred,
      isDraft: params?.isDraft,
      isInTrash: params?.isInTrash,
    );
  }
}
