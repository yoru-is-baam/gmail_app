import 'package:flutter/material.dart';
import 'package:gmail_app/features/email_management/presentation/widgets/compose_mail/email_chip.dart';
import 'package:gmail_app/features/email_management/presentation/widgets/compose_mail/label_form_field.dart';

class RecipientFormField extends StatelessWidget {
  final String label;
  final List<String> recipients;
  final void Function(String) onFieldSubmitted;
  final void Function(String) onDeleted;
  final TextEditingController controller;

  const RecipientFormField({
    super.key,
    required this.label,
    required this.recipients,
    required this.onFieldSubmitted,
    required this.onDeleted,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LabelFormField(label: label),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...recipients.map((recipient) {
                return EmailChip(
                  email: recipient,
                  onDeleted: () => onDeleted(recipient),
                );
              }),
              TextFormField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                controller: controller,
                onFieldSubmitted: onFieldSubmitted,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
