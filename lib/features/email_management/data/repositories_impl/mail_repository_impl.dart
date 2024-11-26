import 'package:gmail_app/config/resources/date_state.dart';
import 'package:gmail_app/features/email_management/data/data_sources/remote/mail_service.dart';
import 'package:gmail_app/features/email_management/data/models/mail.dart';
import 'package:gmail_app/features/email_management/domain/repositories/mail_repository.dart';

class MailRepositoryImpl implements MailRepository {
  final MailService _mailService;

  MailRepositoryImpl(this._mailService);

  @override
  Future<DataState<List<MailModel>>> getMails(String userId) async {
    try {
      final mails = await _mailService.getMails(userId);
      print(mails);
      return DataSuccess<List<MailModel>>(mails);
    } catch (e) {
      return DataFailed(e is Exception ? e : Exception('Unknown error'));
    }
  }
}
