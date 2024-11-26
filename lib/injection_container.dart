import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:gmail_app/features/email_management/data/data_sources/remote/mail_service.dart';
import 'package:gmail_app/features/email_management/data/repositories_impl/mail_repository_impl.dart';
import 'package:gmail_app/features/email_management/domain/repositories/mail_repository.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dependencies
  sl.registerSingleton<MailService>(MailService(FirebaseFirestore.instance));

  sl.registerSingleton<MailRepository>(MailRepositoryImpl(sl()));
}
