import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gmail_app/config/routes/routes.dart';
import 'package:gmail_app/config/theme/app_themes.dart';
import 'package:gmail_app/features/email_management/presentation/pages/home_screen.dart';
import 'package:gmail_app/injection_container.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme(),
      onGenerateRoute: AppRoutes.onGenerateRoutes,
      home: const HomeScreen(),
    );
  }
}
