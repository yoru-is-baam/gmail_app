import 'package:equatable/equatable.dart';

class RecipientMailEntity extends Equatable {
  final String? id;
  final bool isStarred;
  final bool isRead;
  final bool isInTrash;

  const RecipientMailEntity({
    this.id,
    this.isStarred = false,
    this.isRead = false,
    this.isInTrash = false,
  });

  @override
  List<Object?> get props => [id, isStarred, isRead, isInTrash];
}
