import 'package:equatable/equatable.dart';

abstract class BaseMailEntity extends Equatable {
  final String? id;
  final bool isStarred;
  final bool isRead;
  final bool isInTrash;
  final List<String>? labelIds;
  final DateTime? createdAt;

  BaseMailEntity({
    this.id,
    this.labelIds,
    this.isStarred = false,
    this.isRead = false,
    this.isInTrash = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  @override
  List<Object?> get props => [id, isStarred, isRead, isInTrash, createdAt];
}
