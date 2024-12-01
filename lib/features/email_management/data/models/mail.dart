import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gmail_app/features/email_management/domain/entities/mail.dart';

class MailModel extends MailEntity {
  final String userId;
  final List<String>? labelIds;

  MailModel({
    super.id,
    super.subject,
    super.body,
    super.attachments,
    super.isDraft,
    super.isStarred,
    super.isRead,
    super.isInTrash,
    required this.userId,
    this.labelIds,
    super.createdAt,
  });

  factory MailModel.fromDocument(
    DocumentSnapshot senderDoc,
    DocumentSnapshot recipientDoc,
  ) {
    var senderMap = senderDoc.data() as Map<String, dynamic>;
    var recipientMap = senderDoc.data() as Map<String, dynamic>;

    return MailModel(
      id: senderDoc.id,
      subject: senderMap['subject'],
      body: senderMap['body'],
      attachments: senderMap['attachments'] != null
          ? List<String>.from(senderMap['attachments'])
          : null,
      isStarred: recipientMap['isStarred'],
      isRead: recipientMap['isRead'],
      isInTrash: recipientMap['isInTrash'],
      userId: recipientMap['userId'],
      labelIds: recipientMap['labelIds'] != null
          ? List<String>.from(recipientMap['labelIds'])
          : null,
      createdAt: (senderMap['createdAt'] as Timestamp).toDate(),
    );
  }
}
