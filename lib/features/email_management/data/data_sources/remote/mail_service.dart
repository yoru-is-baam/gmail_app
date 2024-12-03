import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gmail_app/core/constants/collections.dart';
import 'package:gmail_app/core/session_manager.dart';
import 'package:gmail_app/features/email_management/data/models/mail.dart';
import 'package:gmail_app/features/email_management/data/models/recipient_mail.dart';
import 'package:gmail_app/features/email_management/data/models/sender_mail.dart';

class MailService {
  final FirebaseFirestore _firestore;
  static String? userId = SessionManager.currentUserId;
  static String? email = SessionManager.currentEmail;

  MailService(this._firestore);

  Future<List<MailModel>> getSentMails({bool? isDraft}) async {
    var querySentMails = _firestore
        .collection(senderMailCollection)
        .where("userId", isEqualTo: userId);

    if (isDraft != null) {
      querySentMails = querySentMails.where(
        "isDraft",
        isEqualTo: isDraft,
      );
    }

    final querySentMailsResult = await querySentMails.get();

    final mails = querySentMailsResult.docs.map(
      (senderDoc) {
        return MailModel.fromDocument(senderDoc);
      },
    ).toList();

    mails.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

    return mails;
  }

  Future<List<MailModel>> getMails({
    bool? isStarred,
    bool? isDraft,
    bool? isInTrash,
  }) async {
    var querySenderMails = _firestore
        .collection(senderMailCollection)
        .where("userId", isEqualTo: userId);
    var queryRecipientMails = _firestore
        .collection(recipientMailCollection)
        .where("userId", isEqualTo: email);

    if (isDraft != null) {
      querySenderMails = querySenderMails.where(
        "isDraft",
        isEqualTo: isDraft,
      );
    }

    if (isInTrash != null) {
      querySenderMails = querySenderMails.where(
        "isInTrash",
        isEqualTo: isInTrash,
      );
      queryRecipientMails = queryRecipientMails.where(
        "isInTrash",
        isEqualTo: isInTrash,
      );
    }

    if (isStarred != null) {
      querySenderMails = querySenderMails.where(
        "isStarred",
        isEqualTo: isStarred,
      );
      queryRecipientMails = queryRecipientMails.where(
        "isStarred",
        isEqualTo: isStarred,
      );
    }

    final List<MailModel> mails = [];

    final queryRecipientMailsResult = await queryRecipientMails.get();
    final querySenderMailsResult = await querySenderMails.get();

    for (var senderDoc in querySenderMailsResult.docs) {
      mails.add(MailModel.fromDocument(senderDoc));
    }

    final mailIds =
        queryRecipientMailsResult.docs.map((doc) => doc.id).toList();

    if (mailIds.isNotEmpty) {
      final querySenderMailsResultByMailIdsFromRecipientMails = await _firestore
          .collection(senderMailCollection)
          .where(FieldPath.documentId, whereIn: mailIds)
          .get();

      for (var recipientDoc in queryRecipientMailsResult.docs) {
        final mailId = recipientDoc.id;

        final senderDoc =
            querySenderMailsResultByMailIdsFromRecipientMails.docs.firstWhere(
          (doc) => doc.id == mailId,
        );

        mails.add(MailModel.fromDocuments(senderDoc, recipientDoc));
      }
    }

    mails.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

    return mails;
  }

  Stream<List<MailModel>> getInboxMails({
    bool? isStarred,
    bool? isDraft,
    bool? isInTrash,
  }) {
    var queryInboxMails = _firestore
        .collection(recipientMailCollection)
        .where("userId", isEqualTo: email);

    if (isDraft != null) {
      queryInboxMails = queryInboxMails.where(
        "isDraft",
        isEqualTo: isDraft,
      );
    }

    if (isInTrash != null) {
      queryInboxMails = queryInboxMails.where(
        "isInTrash",
        isEqualTo: isInTrash,
      );
    }

    if (isStarred != null) {
      queryInboxMails = queryInboxMails.where(
        "isStarred",
        isEqualTo: isStarred,
      );
    }

    return queryInboxMails.snapshots().map(
      (querySnapshot) {
        final mailIds = querySnapshot.docs.map((doc) => doc.id).toList();

        return _firestore
            .collection(senderMailCollection)
            .where(FieldPath.documentId, whereIn: mailIds)
            .get()
            .then(
          (senderMailSnapshot) {
            final mails = senderMailSnapshot.docs.map(
              (senderDoc) {
                final recipientDoc = querySnapshot.docs.firstWhere(
                  (doc) => doc.id == senderDoc.id,
                );
                return MailModel.fromDocuments(senderDoc, recipientDoc);
              },
            ).toList();

            mails.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

            return mails;
          },
        );
      },
    ).asyncMap((future) => future);
  }

  Future<void> sendMail(SenderMailModel mail) async {
    WriteBatch batch = _firestore.batch();

    final senderMailDocRef = _firestore.collection(senderMailCollection).doc();
    batch.set(senderMailDocRef, mail.toMap());

    List<String> recipients = [];
    recipients.addAll(mail.to);
    if (mail.cc != null) recipients.addAll(mail.cc!);
    if (mail.bcc != null) recipients.addAll(mail.bcc!);

    for (var recipient in recipients) {
      final recipientMail = RecipientMailModel(
        userId: recipient,
      );

      final recipientMailDocRef = _firestore
          .collection(recipientMailCollection)
          .doc(senderMailDocRef.id);
      batch.set(recipientMailDocRef, recipientMail.toMap());
    }

    await batch.commit();
  }

  Future<void> updateReceivedMail(
    String mailId,
    Map<String, dynamic> fields,
  ) async {
    await _firestore
        .collection(recipientMailCollection)
        .doc(mailId)
        .update(fields);
  }

  Future<void> saveAsDraft(SenderMailModel mail) async {
    final senderMailDocRef = mail.id != null
        ? _firestore.collection(senderMailCollection).doc(mail.id)
        : _firestore.collection(senderMailCollection).doc();

    final draftMail = mail.copyWith(
      isDraft: true,
      createdAt: mail.createdAt ?? DateTime.now(),
    );

    await senderMailDocRef.set(draftMail.toMap(), SetOptions(merge: true));
  }
}
