import 'package:gmail_app/features/email_management/domain/entities/mail.dart';

abstract class MailRepository {
  Future<List<MailEntity>> getMails();
  Future<void> sendMail(MailEntity mail);
}
