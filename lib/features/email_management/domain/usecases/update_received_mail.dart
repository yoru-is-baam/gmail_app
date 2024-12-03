import 'package:gmail_app/config/resources/date_state.dart';
import 'package:gmail_app/core/usecase/usecase.dart';
import 'package:gmail_app/features/email_management/domain/repositories/mail_repository.dart';
import 'package:gmail_app/features/email_management/domain/usecases/params/update_mail_params.dart';

class UpdateReceivedMailUseCase
    implements UseCase<DataState<void>, UpdateMailParams> {
  final MailRepository _mailRepository;

  UpdateReceivedMailUseCase(this._mailRepository);

  @override
  Future<DataState<void>> call({UpdateMailParams? params}) {
    return _mailRepository.updateReceivedMail(
      mailId: params!.mailId,
      fields: params.toMap(),
    );
  }
}
