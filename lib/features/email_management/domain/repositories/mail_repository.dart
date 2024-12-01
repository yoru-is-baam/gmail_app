import 'package:gmail_app/config/resources/date_state.dart';
import 'package:gmail_app/features/email_management/domain/entities/mail.dart';
import 'package:gmail_app/features/email_management/domain/entities/sender_mail.dart';

abstract class MailRepository {
  Future<DataState<List<MailEntity>>> getMails({
    bool? isStarred,
    bool? isDraft,
    bool? isInTrash,
  });
  Future<DataState<void>> sendMail(SenderMailEntity mail);
  Future<DataState<void>> updateMail({
    required String mailId,
    required Map<String, dynamic> fields,
  });
  Stream<List<MailEntity>> getReceivedMails({
    bool? isStarred,
    bool? isDraft,
    bool? isInTrash,
  });
}
