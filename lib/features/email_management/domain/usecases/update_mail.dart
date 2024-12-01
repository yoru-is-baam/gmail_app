import 'package:gmail_app/config/resources/date_state.dart';
import 'package:gmail_app/core/usecase/usecase.dart';
import 'package:gmail_app/features/email_management/domain/repositories/mail_repository.dart';

class UpdateMailsUseCase
    implements UseCase<DataState<void>, UpdateMailsParams> {
  final MailRepository _mailRepository;

  UpdateMailsUseCase(this._mailRepository);

  @override
  Future<DataState<void>> call({UpdateMailsParams? params}) {
    return _mailRepository.updateMail(
      mailId: params!.mailId,
      fields: params.toMap(),
    );
  }
}

class UpdateMailsParams {
  final String mailId;
  final bool? isDraft;
  final bool? isStarred;
  final bool? isInTrash;

  UpdateMailsParams({
    required this.mailId,
    this.isStarred,
    this.isDraft,
    this.isInTrash,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    if (isStarred != null) map["isStarred"] = isStarred;
    if (isDraft != null) map['isDraft'] = isDraft;
    if (isInTrash != null) map['isInTrash'] = isInTrash;

    return map;
  }
}
