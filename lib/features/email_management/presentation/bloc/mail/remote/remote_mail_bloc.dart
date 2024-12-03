import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gmail_app/config/resources/date_state.dart';
import 'package:gmail_app/features/email_management/domain/entities/mail.dart';
import 'package:gmail_app/features/email_management/domain/usecases/get_inbox_mails.dart';
import 'package:gmail_app/features/email_management/domain/usecases/get_mails.dart';
import 'package:gmail_app/features/email_management/domain/usecases/get_sent_mails.dart';
import 'package:gmail_app/features/email_management/domain/usecases/params/get_mails_params.dart';
import 'package:gmail_app/features/email_management/domain/usecases/params/get_sent_mails_params.dart';
import 'package:gmail_app/features/email_management/domain/usecases/save_as_draft.dart';
import 'package:gmail_app/features/email_management/domain/usecases/send_mail.dart';
import 'package:gmail_app/features/email_management/domain/usecases/update_received_mail.dart';
import 'package:gmail_app/features/email_management/presentation/bloc/mail/remote/remote_mail_event.dart';
import 'package:gmail_app/features/email_management/presentation/bloc/mail/remote/remote_mail_state.dart';

class RemoteMailBloc extends Bloc<RemoteMailEvent, RemoteMailState> {
  final GetInboxMailsUseCase _getInboxMailsUseCase;
  final GetSentMailsUseCase _getSentMailsUseCase;
  final GetMailsUseCase _getMailsUseCase;
  final SendMailUseCase _sendMailUseCase;
  final SaveAsDraftUseCase _saveAsDraftUseCase;
  final UpdateReceivedMailUseCase _updateReceivedMailUseCase;

  RemoteMailBloc(
    this._getMailsUseCase,
    this._sendMailUseCase,
    this._updateReceivedMailUseCase,
    this._getInboxMailsUseCase,
    this._getSentMailsUseCase,
    this._saveAsDraftUseCase,
  ) : super(const RemoteMailLoading()) {
    on<GetInboxMails>(onGetInboxMails);
    on<GetSentMails>(onGetSentMails);
    on<GetStarredMails>(onGetStarredMails);
    on<GetDraftMails>(onGetDraftMails);
    on<GetTrashMails>(onGetTrashMails);
    on<SendMail>(onSendMail);
    on<SaveAsDraft>(onSaveAsDraft);
    on<UpdateReceivedMail>(onUpdateReceivedMail);
  }

  void onUpdateReceivedMail(
    UpdateReceivedMail updateReceivedMail,
    Emitter<RemoteMailState> emit,
  ) async {
    final currentState = state;

    if (currentState is RemoteMailInboxDone &&
        currentState.inboxMails != null) {
      final updatedMails = List<MailEntity>.from(currentState.inboxMails!);

      final index = updatedMails.indexWhere(
        (mail) => mail.id == updateReceivedMail.fields!.mailId,
      );

      if (index != -1) {
        final updatedMail = updatedMails[index].copyWith(
          isStarred: updateReceivedMail.fields?.isStarred,
        );

        updatedMails[index] = updatedMail;

        emit(RemoteMailInboxDone(updatedMails));

        final dataState = await _updateReceivedMailUseCase(
          params: updateReceivedMail.fields,
        );

        if (dataState is DataFailed) {
          emit(RemoteMailError(dataState.error!));
        }
      } else {
        emit(RemoteMailError(Exception("No email found")));
      }
    } else {
      emit(RemoteMailError(Exception("Invalid state for update")));
    }
  }

  void onSendMail(
    SendMail sendMail,
    Emitter<RemoteMailState> emit,
  ) async {
    final dataState = await _sendMailUseCase(params: sendMail.mail);

    if (dataState is DataSuccess) {
      emit(const RemoteMailSent());
    }

    if (dataState is DataFailed) {
      emit(RemoteMailError(dataState.error!));
    }
  }

  void onSaveAsDraft(
    SaveAsDraft saveAsDraft,
    Emitter<RemoteMailState> emit,
  ) async {
    final dataState = await _saveAsDraftUseCase(params: saveAsDraft.mail);

    if (dataState is DataSuccess) {
      emit(const SaveAsDraftDone());
    }

    if (dataState is DataFailed) {
      emit(RemoteMailError(dataState.error!));
    }
  }

  void onGetInboxMails(
    GetInboxMails getInboxMails,
    Emitter<RemoteMailState> emit,
  ) async {
    emit(const RemoteMailLoading());

    await emit.forEach(
      _getInboxMailsUseCase(
        params: GetMailsParams(
          isInTrash: false,
        ),
      ),
      onData: (mails) {
        return RemoteMailInboxDone(mails);
      },
    );
  }

  void onGetStarredMails(
    GetStarredMails getStarredMailsMails,
    Emitter<RemoteMailState> emit,
  ) async {
    emit(const RemoteMailLoading());

    final dataState = await _getMailsUseCase(
      params: GetMailsParams(
        isInTrash: false,
        isStarred: true,
      ),
    );

    if (dataState is DataSuccess) {
      emit(RemoteMailStarredDone(dataState.data));
    }

    if (dataState is DataFailed) {
      emit(RemoteMailError(dataState.error!));
    }
  }

  void onGetSentMails(
    GetSentMails getSentMails,
    Emitter<RemoteMailState> emit,
  ) async {
    emit(const RemoteMailLoading());

    final dataState = await _getSentMailsUseCase(
      params: GetSentMailsParams(
        isDraft: false,
      ),
    );

    if (dataState is DataSuccess) {
      emit(RemoteMailSentDone(dataState.data));
    }

    if (dataState is DataFailed) {
      emit(RemoteMailError(dataState.error!));
    }
  }

  void onGetDraftMails(
    GetDraftMails getDraftMails,
    Emitter<RemoteMailState> emit,
  ) async {
    emit(const RemoteMailLoading());

    final dataState = await _getSentMailsUseCase(
      params: GetSentMailsParams(
        isDraft: true,
      ),
    );

    if (dataState is DataSuccess) {
      emit(RemoteMailSentDone(dataState.data));
    }

    if (dataState is DataFailed) {
      emit(RemoteMailError(dataState.error!));
    }
  }

  void onGetTrashMails(
    GetTrashMails getTrashMails,
    Emitter<RemoteMailState> emit,
  ) async {
    // await _handleGetMails(
    //   GetMailsParams(
    //     isInTrash: true,
    //   ),
    //   emit,
    // );
  }
}
