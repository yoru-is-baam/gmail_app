import 'package:gmail_app/config/resources/date_state.dart';
import 'package:gmail_app/core/usecase/usecase.dart';
import 'package:gmail_app/features/email_management/domain/entities/mail.dart';
import 'package:gmail_app/features/email_management/domain/repositories/mail_repository.dart';
import 'package:gmail_app/features/email_management/domain/usecases/params/get_mails_params.dart';

class GetMailsUseCase
    implements UseCase<DataState<List<MailEntity>>, GetMailsParams> {
  final MailRepository _mailRepository;

  GetMailsUseCase(this._mailRepository);

  @override
  Future<DataState<List<MailEntity>>> call({GetMailsParams? params}) {
    return _mailRepository.getMails(
      isStarred: params?.isStarred,
      isDraft: params?.isDraft,
      isInTrash: params?.isInTrash,
    );
  }
}
