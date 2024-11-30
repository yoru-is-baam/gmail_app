import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gmail_app/config/resources/date_state.dart';
import 'package:gmail_app/features/email_management/domain/usecases/send_mail.dart';
import 'package:gmail_app/features/email_management/presentation/bloc/mail/remote/remote_mail_event.dart';
import 'package:gmail_app/features/email_management/presentation/bloc/mail/remote/remote_mail_state.dart';

class RemoteMailBloc extends Bloc<RemoteMailEvent, RemoteMailState> {
  final SendMailUseCase _sendMailUseCase;

  RemoteMailBloc(this._sendMailUseCase) : super(const RemoteMailLoading()) {
    on<SendMail>(onSendMail);
  }

  void onSendMail(
    SendMail sendMail,
    Emitter<RemoteMailState> emit,
  ) async {
    final dataState = await _sendMailUseCase(params: sendMail.mail);

    if (dataState is DataSuccess) {
      emit(const RemoteMailDone(null));
    }

    if (dataState is DataFailed) {
      emit(RemoteMailError(dataState.error!));
    }
  }
}
