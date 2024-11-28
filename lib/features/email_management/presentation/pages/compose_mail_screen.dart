import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gmail_app/features/email_management/presentation/widgets/compose_mail/divider_form_field.dart';
import 'package:gmail_app/features/email_management/presentation/widgets/compose_mail/email_chip.dart';
import 'package:gmail_app/features/email_management/presentation/widgets/compose_mail/label_form_field.dart';

class ComposeMailScreen extends HookWidget {
  const ComposeMailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.arrow_back_outlined,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.attachment_outlined),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.send),
        ),
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert),
          color: const Color(0xFFeaeef8),
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              onTap: () {},
              child: const Text('Discard'),
            ),
            PopupMenuItem<String>(
              onTap: () {},
              child: const Text('Save draft'),
            ),
            PopupMenuItem<String>(
              onTap: () {},
              child: const Text('Settings'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Row(
            children: [
              LabelFormField(label: "From"),
              Expanded(
                child: Text(
                  "hoanghuynhtuankiet69@gmail.com",
                  style: TextStyle(
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
        const DividerFormField(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LabelFormField(label: "To"),
              Expanded(
                child: Column(
                  children: [
                    const Wrap(
                      direction: Axis.vertical,
                      children: [
                        EmailChip(),
                        EmailChip(),
                      ],
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        const DividerFormField(),
      ],
    );
  }
}
