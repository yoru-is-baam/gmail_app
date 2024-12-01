import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gmail_app/config/resources/date_state.dart';
import 'package:gmail_app/features/email_management/domain/usecases/get_received_mails.dart';
import 'package:gmail_app/features/email_management/domain/usecases/send_mail.dart';
import 'package:gmail_app/features/email_management/domain/usecases/update_mail.dart';
import 'package:gmail_app/features/email_management/presentation/bloc/mail/remote/remote_mail_event.dart';
import 'package:gmail_app/features/email_management/presentation/bloc/mail/remote/remote_mail_state.dart';

class RemoteMailBloc extends Bloc<RemoteMailEvent, RemoteMailState> {
  final GetReceivedMailsUseCase _getReceivedMailsUseCase;
  // final GetMailsUseCase _getMailsUseCase;
  final SendMailUseCase _sendMailUseCase;
  final UpdateMailsUseCase _updateMailsUseCase;

  RemoteMailBloc(
    // this._getMailsUseCase,
    this._sendMailUseCase,
    this._updateMailsUseCase,
    this._getReceivedMailsUseCase,
  ) : super(const RemoteMailLoading()) {
    on<GetInboxMails>(onGetInboxMails);
    on<GetStarredMails>(onGetStarredMails);
    on<GetDraftMails>(onGetDraftMails);
    on<GetTrashMails>(onGetTrashMails);
    on<SendMail>(onSendMail);
    on<UpdateMail>(onUpdateMail);
  }

  void onUpdateMail(
    UpdateMail updateMail,
    Emitter<RemoteMailState> emit,
  ) async {
    final dataState = await _updateMailsUseCase(params: updateMail.fields);

    if (dataState is DataSuccess) {
      emit(const RemoteMailDone(null));
    }

    if (dataState is DataFailed) {
      emit(RemoteMailError(dataState.error!));
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

  void onGetInboxMails(
    GetInboxMails getInboxMails,
    Emitter<RemoteMailState> emit,
  ) async {
    await _handleGetMails(
      GetMailsParams(
        isInTrash: false,
        isDraft: false,
      ),
      emit,
    );
  }

  void onGetStarredMails(
    GetStarredMails getStarredMailsMails,
    Emitter<RemoteMailState> emit,
  ) async {
    await _handleGetMails(
      GetMailsParams(
        isInTrash: false,
        isStarred: true,
      ),
      emit,
    );
  }

  void onGetDraftMails(
    GetDraftMails getDraftMails,
    Emitter<RemoteMailState> emit,
  ) async {
    await _handleGetMails(
      GetMailsParams(
        isInTrash: false,
        isDraft: true,
      ),
      emit,
    );
  }

  void onGetTrashMails(
    GetTrashMails getTrashMails,
    Emitter<RemoteMailState> emit,
  ) async {
    await _handleGetMails(
      GetMailsParams(
        isInTrash: true,
      ),
      emit,
    );
  }

  Future<void> _handleGetMails(
    GetMailsParams params,
    Emitter<RemoteMailState> emit,
  ) async {
    emit(const RemoteMailLoading());

    await emit.forEach(
      _getReceivedMailsUseCase(params: params),
      onData: (mails) {
        log(mails.toString());
        return RemoteMailDone(mails);
      },
    );

    // final dataState = await _getMailsUseCase(params: params);

    // if (dataState is DataSuccess) {
    //   emit(RemoteMailDone(dataState.data));
    // }

    // if (dataState is DataFailed) {
    //   emit(RemoteMailError(dataState.error!));
    // }
  }
}
