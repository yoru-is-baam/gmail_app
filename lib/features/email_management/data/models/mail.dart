import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gmail_app/features/email_management/domain/entities/mail.dart';

class MailModel extends MailEntity {
  final String userId;

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
    super.labelIds,
    super.createdAt,
  });

  factory MailModel.fromDocument(DocumentSnapshot doc) {
    var map = doc.data() as Map<String, dynamic>;

    return MailModel(
      id: doc.id,
      subject: map['subject'],
      body: map['body'],
      attachments: map['attachments'] != null
          ? List<String>.from(map['attachments'])
          : null,
      isStarred: map['isStarred'],
      isRead: map['isRead'],
      isDraft: map['isDraft'],
      isInTrash: map['isInTrash'],
      userId: map['userId'],
      labelIds:
          map['labelIds'] != null ? List<String>.from(map['labelIds']) : null,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  factory MailModel.fromDocuments(
    DocumentSnapshot senderDoc,
    DocumentSnapshot recipientDoc,
  ) {
    var senderMap = senderDoc.data() as Map<String, dynamic>;
    var recipientMap = recipientDoc.data() as Map<String, dynamic>;

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
