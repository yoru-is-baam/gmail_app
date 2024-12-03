import 'package:gmail_app/features/email_management/domain/entities/base_mail.dart';

class MailEntity extends BaseMailEntity {
  final String? subject;
  final String? body;
  final List<String>? attachments;
  final bool? isDraft;

  MailEntity({
    super.id,
    this.subject,
    this.body,
    this.attachments,
    this.isDraft,
    super.isStarred,
    super.isRead,
    super.isInTrash,
    super.labelIds,
    super.createdAt,
  });

  @override
  List<Object?> get props => [id, subject, body, attachments, isDraft];

  MailEntity copyWith({
    String? id,
    String? subject,
    String? body,
    List<String>? attachments,
    bool? isDraft,
    bool? isStarred,
    bool? isRead,
    bool? isInTrash,
    List<String>? labelIds,
    DateTime? createdAt,
  }) {
    return MailEntity(
      id: id ?? this.id,
      subject: subject ?? this.subject,
      body: body ?? this.body,
      attachments: attachments ?? this.attachments,
      isDraft: isDraft ?? this.isDraft,
      isStarred: isStarred ?? this.isStarred,
      isRead: isRead ?? this.isRead,
      isInTrash: isInTrash ?? this.isInTrash,
      labelIds: labelIds ?? this.labelIds,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
