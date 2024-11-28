import 'package:flutter/material.dart';
import 'package:gmail_app/core/constants/routes.dart';
import 'package:gmail_app/features/email_management/presentation/pages/compose_mail_screen.dart';
import 'package:gmail_app/features/email_management/presentation/pages/home_screen.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return _materialRoute(const HomeScreen());
      case composeMailRoute:
        return _materialRoute(const ComposeMailScreen());
      default:
        return _materialRoute(const HomeScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
