import 'package:gmail_app/features/email_management/domain/entities/base_mail.dart';

class SenderMailEntity extends BaseMailEntity {
  final List<String> to;
  final List<String>? cc;
  final List<String>? bcc;
  final String? subject;
  final String? body;
  final List<String>? attachments;
  final bool isDraft;

  SenderMailEntity({
    super.id,
    required this.to,
    this.cc,
    this.bcc,
    this.subject,
    this.body,
    this.attachments,
    this.isDraft = false,
    super.isStarred,
    super.isRead = true,
    super.isInTrash,
    super.labelIds,
    super.createdAt,
  });

  @override
  List<Object?> get props => [id, to, isDraft];

  SenderMailEntity copyWith({
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
  }) {
    return SenderMailEntity(
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
      labelIds: labelIds ?? this.labelIds,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
