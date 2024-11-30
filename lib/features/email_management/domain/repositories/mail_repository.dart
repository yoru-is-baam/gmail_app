import 'package:gmail_app/config/resources/date_state.dart';
import 'package:gmail_app/features/email_management/domain/entities/mail.dart';

abstract class MailRepository {
  Future<List<MailEntity>> getMails();
  Future<DataState<void>> sendMail(MailEntity mail);
}
