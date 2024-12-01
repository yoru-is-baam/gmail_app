import 'package:equatable/equatable.dart';

class MailEntity extends Equatable {
  final String? id;
  final String? subject;
  final String? body;
  final List<String>? attachments;
  final bool isDraft;
  final bool isStarred;
  final bool isRead;
  final bool isInTrash;
  final DateTime? createdAt;

  MailEntity({
    this.id,
    this.subject,
    this.body,
    this.attachments,
    this.isDraft = false,
    this.isStarred = false,
    this.isRead = true,
    this.isInTrash = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  @override
  List<Object?> get props => [id];
}
