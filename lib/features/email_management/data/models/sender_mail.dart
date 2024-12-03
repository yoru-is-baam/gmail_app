import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gmail_app/core/session_manager.dart';
import 'package:gmail_app/features/email_management/domain/entities/sender_mail.dart';

class SenderMailModel extends SenderMailEntity {
  final String userId;

  SenderMailModel({
    super.id,
    required super.to,
    super.cc,
    super.bcc,
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

  factory SenderMailModel.fromDocument(DocumentSnapshot doc) {
    var map = doc.data() as Map<String, dynamic>;

    return SenderMailModel(
      id: doc.id,
      to: List<String>.from(map['to']),
      cc: map['cc'] != null ? List<String>.from(map['cc']) : null,
      bcc: map['bcc'] != null ? List<String>.from(map['bcc']) : null,
      subject: map['subject'],
      body: map['body'],
      attachments: map['attachments'] != null
          ? List<String>.from(map['attachments'])
          : null,
      isDraft: map['isDraft'],
      isStarred: map['isStarred'],
      isRead: map['isRead'],
      isInTrash: map['isInTrash'],
      userId: map['userId'],
      labelIds:
          map['labelIds'] != null ? List<String>.from(map['labelIds']) : null,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'to': to,
      'cc': cc,
      'bcc': bcc,
      'subject': subject,
      'body': body,
      'attachments': attachments,
      'isDraft': isDraft,
      'isStarred': isStarred,
      'isRead': isRead,
      'isInTrash': isInTrash,
      'userId': userId,
      'labelIds': labelIds,
      'createdAt': createdAt,
    };
  }

  factory SenderMailModel.fromEntity(
    SenderMailEntity entity,
    List<String>? labelIds,
  ) {
    return SenderMailModel(
      id: entity.id,
      to: entity.to,
      cc: entity.cc,
      bcc: entity.bcc,
      subject: entity.subject,
      body: entity.body,
      attachments: entity.attachments,
      isDraft: entity.isDraft,
      isStarred: entity.isStarred,
      isRead: entity.isRead,
      isInTrash: entity.isInTrash,
      userId: SessionManager.currentUserId!,
      labelIds: labelIds,
      createdAt: entity.createdAt,
    );
  }

  @override
  SenderMailModel copyWith({
    String? id,
    List<String>? to,
    List<String>? cc,
    List<String>? bcc,
    String? subject,
    String? body,
    List<String>? attachments,
    bool? isDraft,
    bool? isStarred,
    bool? isRead,
    bool? isInTrash,
    List<String>? labelIds,
    DateTime? createdAt,
    String? userId,
  }) {
    return SenderMailModel(
      id: id ?? this.id,
      to: to ?? this.to,
      cc: cc ?? this.cc,
      bcc: bcc ?? this.bcc,
      subject: subject ?? this.subject,
      body: body ?? this.body,
      attachments: attachments ?? this.attachments,
      isDraft: isDraft ?? this.isDraft,
      isStarred: isStarred ?? this.isStarred,
      isRead: isRead ?? this.isRead,
      isInTrash: isInTrash ?? this.isInTrash,
      userId: userId ?? this.userId,
      labelIds: labelIds ?? this.labelIds,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
