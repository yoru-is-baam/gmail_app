import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gmail_app/core/constants/collections.dart';
import 'package:gmail_app/core/session_manager.dart';
import 'package:gmail_app/features/email_management/data/models/mail.dart';
import 'package:gmail_app/features/email_management/data/models/recipient_mail.dart';
import 'package:gmail_app/features/email_management/data/models/sender_mail.dart';
import 'package:rxdart/rxdart.dart';

class MailService {
  final FirebaseFirestore _firestore;
  static String? userId = SessionManager.currentUserId;
  static String? email = SessionManager.currentEmail;

  MailService(this._firestore);

  Future<List<MailModel>> getMails({
    bool? isStarred,
    bool? isDraft,
    bool? isInTrash,
  }) async {
    var queryTo = _firestore
        .collection(senderMailCollection)
        .where("to", arrayContains: email);

    var queryCc = _firestore
        .collection(senderMailCollection)
        .where("cc", arrayContains: email);

    var queryBcc = _firestore
        .collection(senderMailCollection)
        .where("bcc", arrayContains: email);

    if (isDraft != null) {
      queryTo = queryTo.where("isDraft", isEqualTo: isDraft);
      queryCc = queryCc.where("isDraft", isEqualTo: isDraft);
      queryBcc = queryBcc.where("isDraft", isEqualTo: isDraft);
    }

    if (isInTrash != null) {
      queryTo = queryTo.where("isInTrash", isEqualTo: isInTrash);
      queryCc = queryCc.where("isInTrash", isEqualTo: isInTrash);
      queryBcc = queryBcc.where("isInTrash", isEqualTo: isInTrash);
    }

    if (isStarred != null) {
      queryTo = queryTo.where("isStarred", isEqualTo: isStarred);
      queryCc = queryCc.where("isStarred", isEqualTo: isStarred);
      queryBcc = queryBcc.where("isStarred", isEqualTo: isStarred);
    }

    final queryToResult = await queryTo.get();
    final queryCcResult = await queryCc.get();
    final queryBccResult = await queryBcc.get();

    final allDocs = {
      ...queryToResult.docs,
      ...queryCcResult.docs,
      ...queryBccResult.docs,
    };

    final mails = allDocs.map((doc) {
      return MailModel.fromDocument(doc, doc);
    }).toList();

    mails.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

    return mails;
  }

  Stream<List<MailModel>> getReceivedMails({
    bool? isStarred,
    bool? isDraft,
    bool? isInTrash,
  }) {
    var queryReceivedMails = _firestore
        .collection(recipientMailCollection)
        .where("userId", isEqualTo: email);

    if (isDraft != null) {
      queryReceivedMails =
          queryReceivedMails.where("isDraft", isEqualTo: isDraft);
    }

    if (isInTrash != null) {
      queryReceivedMails =
          queryReceivedMails.where("isInTrash", isEqualTo: isInTrash);
    }

    if (isStarred != null) {
      queryReceivedMails =
          queryReceivedMails.where("isStarred", isEqualTo: isStarred);
    }

    final receivedMailStream = queryReceivedMails.snapshots();

    return receivedMailStream.switchMap((querySnapshot) async* {
      final mailIds = querySnapshot.docs.map((doc) => doc["mailId"]).toList();

      final senderMailQuery = _firestore
          .collection(senderMailCollection)
          .where(FieldPath.documentId, whereIn: mailIds);

      final senderMailSnapshot = await senderMailQuery.get();

      final mails = senderMailSnapshot.docs.map((senderDoc) {
        final recipientDoc = querySnapshot.docs.firstWhere(
          (doc) => doc.id == senderDoc.id,
        );
        return MailModel.fromDocument(
          senderDoc,
          recipientDoc,
        );
      }).toList();

      log(mails.toString());

      mails.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

      yield mails;
    });
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

  Future<void> updateMail(String mailId, Map<String, dynamic> fields) async {
    await _firestore
        .collection(senderMailCollection)
        .doc(mailId)
        .update(fields);
  }
}
