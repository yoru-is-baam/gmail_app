import 'package:gmail_app/core/usecase/usecase.dart';
import 'package:gmail_app/features/email_management/domain/entities/mail.dart';
import 'package:gmail_app/features/email_management/domain/repositories/mail_repository.dart';

class GetReceivedMailsUseCase
    implements UseCaseStream<List<MailEntity>, GetMailsParams> {
  final MailRepository _mailRepository;

  GetReceivedMailsUseCase(this._mailRepository);

  @override
  Stream<List<MailEntity>> call({GetMailsParams? params}) {
    return _mailRepository.getReceivedMails(
      isStarred: params?.isStarred,
      isDraft: params?.isDraft,
      isInTrash: params?.isInTrash,
    );
  }
}

class GetMailsParams {
  final bool? isDraft;
  final bool? isStarred;
  final bool? isInTrash;

  GetMailsParams({
    this.isStarred,
    this.isDraft,
    this.isInTrash,
  });
}
