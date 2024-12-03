import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gmail_app/features/email_management/domain/entities/recipient_mail.dart';

class RecipientMailModel extends RecipientMailEntity {
  final String userId;

  RecipientMailModel({
    super.id,
    super.isStarred,
    super.isRead,
    super.isInTrash,
    required this.userId,
    super.labelIds,
  });

  factory RecipientMailModel.fromDocument(DocumentSnapshot doc) {
    var map = doc.data() as Map<String, dynamic>;

    return RecipientMailModel(
      id: doc.id,
      isStarred: map['isStarred'],
      isRead: map['isRead'],
      isInTrash: map['isInTrash'],
      labelIds:
          map['labelIds'] != null ? List<String>.from(map['labelIds']) : null,
      userId: map['userId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isStarred': isStarred,
      'isRead': isRead,
      'isInTrash': isInTrash,
      'labelIds': labelIds,
      'userId': userId,
    };
  }

  factory RecipientMailModel.fromEntity(
    RecipientMailEntity entity,
    String userId,
    List<String>? labelIds,
  ) {
    return RecipientMailModel(
      id: entity.id,
      isStarred: entity.isStarred,
      isRead: entity.isRead,
      isInTrash: entity.isInTrash,
      labelIds: labelIds,
      userId: userId,
    );
  }
}
