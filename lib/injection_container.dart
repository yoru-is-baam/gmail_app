import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:gmail_app/features/email_management/data/data_sources/remote/mail_service.dart';
import 'package:gmail_app/features/email_management/data/repositories_impl/mail_repository_impl.dart';
import 'package:gmail_app/features/email_management/domain/repositories/mail_repository.dart';
import 'package:gmail_app/features/email_management/domain/usecases/get_mails.dart';
import 'package:gmail_app/features/email_management/domain/usecases/get_received_mails.dart';
import 'package:gmail_app/features/email_management/domain/usecases/send_mail.dart';
import 'package:gmail_app/features/email_management/domain/usecases/update_mail.dart';
import 'package:gmail_app/features/email_management/presentation/bloc/mail/remote/remote_mail_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dependencies
  sl.registerSingleton<MailService>(MailService(FirebaseFirestore.instance));

  sl.registerSingleton<MailRepository>(MailRepositoryImpl(sl()));

  // Use cases
  sl.registerSingleton<SendMailUseCase>(SendMailUseCase(sl()));

  sl.registerSingleton<GetMailsUseCase>(GetMailsUseCase(sl()));

  sl.registerSingleton<GetReceivedMailsUseCase>(GetReceivedMailsUseCase(sl()));

  sl.registerSingleton<UpdateMailsUseCase>(UpdateMailsUseCase(sl()));

  // Blocs
  sl.registerFactory<RemoteMailBloc>(() => RemoteMailBloc(sl(), sl(), sl()));
}
