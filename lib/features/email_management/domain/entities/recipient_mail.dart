import 'package:gmail_app/features/email_management/domain/entities/base_mail.dart';

class RecipientMailEntity extends BaseMailEntity {
  RecipientMailEntity({
    super.id,
    super.isStarred,
    super.isRead,
    super.isInTrash,
    super.labelIds,
    super.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        isStarred,
        isRead,
        isInTrash,
        labelIds,
        createdAt,
      ];
}
