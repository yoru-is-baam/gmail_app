import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gmail_app/core/constants/collections.dart';
import 'package:gmail_app/core/session_manager.dart';
import 'package:gmail_app/features/email_management/data/models/mail.dart';

class MailService {
  final FirebaseFirestore _firestore;
  static String? userId = SessionManager.currentUserId;

  MailService(this._firestore);

  Future<List<MailModel>> getMails() async {
    final querySnapshot = await _firestore
        .collection(mailCollection)
        .where("userId", isEqualTo: userId)
        .get();

    return querySnapshot.docs.map((doc) {
      return MailModel.fromMap(doc.data());
    }).toList();
  }

  Future<void> sendMail(MailModel mail) async {
    await _firestore.collection(mailCollection).add(mail.toMap());
  }
}
