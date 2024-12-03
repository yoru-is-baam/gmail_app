import 'dart:developer';

import 'package:gmail_app/features/email_management/data/data_sources/remote/mail_service.dart';
import 'package:gmail_app/features/email_management/data/models/mail.dart';
import 'package:gmail_app/features/email_management/data/models/sender_mail.dart';
import 'package:gmail_app/features/email_management/domain/entities/mail.dart';
import 'package:gmail_app/features/email_management/domain/entities/sender_mail.dart';
import 'package:gmail_app/features/email_management/domain/repositories/mail_repository.dart';
import 'package:gmail_app/config/resources/date_state.dart';

class MailRepositoryImpl implements MailRepository {
  final MailService _mailService;

  MailRepositoryImpl(this._mailService);

  @override
  Future<DataState<List<MailModel>>> getMails({
    bool? isStarred,
    bool? isDraft,
    bool? isInTrash,
  }) async {
    try {
      final mails = await _mailService.getMails(
        isStarred: isStarred,
        isDraft: isDraft,
        isInTrash: isInTrash,
      );
      return DataSuccess<List<MailModel>>(mails);
    } catch (e) {
      return DataFailed(Exception('Failed to get mails: $e'));
    }
  }

  @override
  Future<DataState<void>> sendMail(SenderMailEntity mail) async {
    try {
      await _mailService.sendMail(SenderMailModel.fromEntity(mail, null));
      return const DataSuccess<void>();
    } catch (e) {
      return DataFailed(Exception('Failed to send mail: $e'));
    }
  }

  @override
  Future<DataState<void>> updateReceivedMail({
    required String mailId,
    required Map<String, dynamic> fields,
  }) async {
    try {
      await _mailService.updateReceivedMail(mailId, fields);
      return const DataSuccess<void>();
    } catch (e) {
      return DataFailed(Exception('Failed to update mail: $e'));
    }
  }

  @override
  Stream<List<MailModel>> getInboxMails({
    bool? isStarred,
    bool? isDraft,
    bool? isInTrash,
  }) {
    return _mailService.getInboxMails(
      isStarred: isStarred,
      isDraft: isDraft,
      isInTrash: isInTrash,
    );
  }

  @override
  Future<DataState<List<MailEntity>>> getSentMails({bool? isDraft}) async {
    try {
      final mails = await _mailService.getSentMails(isDraft: isDraft);
      log(mails.toString());
      return DataSuccess<List<MailModel>>(mails);
    } catch (e) {
      return DataFailed(Exception('Failed to get sent mails: $e'));
    }
  }

  @override
  Future<DataState<void>> saveAsDraft(SenderMailEntity mail) async {
    try {
      await _mailService.saveAsDraft(SenderMailModel.fromEntity(mail, null));
      return const DataSuccess<void>();
    } catch (e) {
      return DataFailed(Exception('Failed to save as draft: $e'));
    }
  }
}
