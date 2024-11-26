import 'package:equatable/equatable.dart';

class MailEntity extends Equatable {
  final int? id;
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

  const MailEntity({
    required this.id,
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
  });

  @override
  List<Object?> get props => [id, to];
}
