import 'package:flutter/material.dart';
import 'package:gmail_app/core/constants/routes.dart';
import 'package:gmail_app/features/email_management/presentation/widgets/mail_list/mail_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildBody() {
    return const SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text("Search bar"),
            MailList(),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => Navigator.pushNamed(context, composeMailRoute),
      backgroundColor: const Color(0xFFc8dded),
      icon: const Icon(Icons.mode_edit_outlined),
      label: const Text("Compose"),
    );
  }
}
