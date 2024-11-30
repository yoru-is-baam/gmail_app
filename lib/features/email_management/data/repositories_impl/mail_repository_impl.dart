import 'package:gmail_app/features/email_management/data/data_sources/remote/mail_service.dart';
import 'package:gmail_app/features/email_management/data/models/mail.dart';
import 'package:gmail_app/features/email_management/domain/entities/mail.dart';
import 'package:gmail_app/features/email_management/domain/repositories/mail_repository.dart';
import 'package:gmail_app/config/resources/date_state.dart';

class MailRepositoryImpl implements MailRepository {
  final MailService _mailService;

  MailRepositoryImpl(this._mailService);

  @override
  Future<List<MailModel>> getMails() async {
    try {
      final mails = await _mailService.getMails();
      return mails;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<DataState<void>> sendMail(MailEntity mail) async {
    try {
      await _mailService.sendMail(MailModel.fromEntity(mail, null));
      return const DataSuccess<void>();
    } catch (e) {
      print(e);
      return DataFailed<void>(Exception('Failed to send mail: $e'));
    }
  }
}
