import 'package:equatable/equatable.dart';

class SenderMailEntity extends Equatable {
  final String? id;
  final List<String> to;
  final List<String>? cc;
  final List<String>? bcc;
  final String? subject;
  final String? body;
  final List<String>? attachments;
  final bool isDraft;
  final bool isStarred;
  final bool isRead;
  final bool isInTrash;
  final DateTime? createdAt;

  SenderMailEntity({
    this.id,
    required this.to,
    this.cc,
    this.bcc,
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
  List<Object?> get props => [id, to];
}
