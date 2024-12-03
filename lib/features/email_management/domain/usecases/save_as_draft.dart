import 'package:gmail_app/config/resources/date_state.dart';
import 'package:gmail_app/core/usecase/usecase.dart';
import 'package:gmail_app/features/email_management/domain/entities/sender_mail.dart';
import 'package:gmail_app/features/email_management/domain/repositories/mail_repository.dart';

class SaveAsDraftUseCase implements UseCase<DataState<void>, SenderMailEntity> {
  final MailRepository _mailRepository;

  SaveAsDraftUseCase(this._mailRepository);

  @override
  Future<DataState<void>> call({SenderMailEntity? params}) {
    return _mailRepository.saveAsDraft(params!);
  }
}
