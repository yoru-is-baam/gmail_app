import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gmail_app/features/email_management/domain/entities/recipient_mail.dart';

class RecipientMailModel extends RecipientMailEntity {
  final String userId;

  const RecipientMailModel({
    super.id,
    super.isStarred,
    super.isRead,
    super.isInTrash,
    required this.userId,
  });

  factory RecipientMailModel.fromDocument(DocumentSnapshot doc) {
    var map = doc.data() as Map<String, dynamic>;

    return RecipientMailModel(
      id: doc.id,
      isStarred: map['isStarred'],
      isRead: map['isRead'],
      isInTrash: map['isInTrash'],
      userId: map['userId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isStarred': isStarred,
      'isRead': isRead,
      'isInTrash': isInTrash,
      'userId': userId,
    };
  }

  factory RecipientMailModel.fromEntity(
    RecipientMailEntity entity,
    String userId,
    String mailId,
  ) {
    return RecipientMailModel(
      id: entity.id,
      isStarred: entity.isStarred,
      isRead: entity.isRead,
      isInTrash: entity.isInTrash,
      userId: userId,
    );
  }
}
