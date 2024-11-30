import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gmail_app/core/utils/show_custom_dialog.dart';
import 'package:gmail_app/features/email_management/domain/entities/mail.dart';
import 'package:gmail_app/features/email_management/presentation/bloc/mail/remote/remote_mail_bloc.dart';
import 'package:gmail_app/features/email_management/presentation/bloc/mail/remote/remote_mail_event.dart';
import 'package:gmail_app/features/email_management/presentation/bloc/mail/remote/remote_mail_state.dart';
import 'package:gmail_app/features/email_management/presentation/widgets/compose_mail/divider_form_field.dart';
import 'package:gmail_app/features/email_management/presentation/widgets/compose_mail/label_form_field.dart';
import 'package:gmail_app/features/email_management/presentation/widgets/compose_mail/padded_widget.dart';
import 'package:gmail_app/features/email_management/presentation/widgets/compose_mail/recipient_form_field.dart';
import 'package:gmail_app/injection_container.dart';

class ComposeMailScreen extends HookWidget {
  const ComposeMailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final toRecipients = useState<List<String>>([]);
    final ccRecipients = useState<List<String>>([]);
    final bccRecipients = useState<List<String>>([]);
    final toController = useTextEditingController();
    final ccController = useTextEditingController();
    final bccController = useTextEditingController();

    final isAdvancedRecipientFormFieldOpen = useState<bool>(false);

    void toggleAdvancedRecipientForm() {
      isAdvancedRecipientFormFieldOpen.value =
          !isAdvancedRecipientFormFieldOpen.value;
    }

    void deleteRecipientFromList(
      ValueNotifier<List<String>> recipients,
      String recipient,
    ) {
      recipients.value = List.from(recipients.value)..remove(recipient);
    }

    void addRecipientToList(
      ValueNotifier<List<String>> recipients,
      TextEditingController controller,
      String recipient,
    ) {
      if (recipient.isNotEmpty && !recipients.value.contains(recipient)) {
        recipients.value = List.from(recipients.value)..add(recipient);
      }

      controller.clear();
    }

    return BlocProvider(
      create: (_) => RemoteMailBloc(sl()),
      child: Scaffold(
        appBar: AppBar(
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
            BlocConsumer<RemoteMailBloc, RemoteMailState>(
              listener: (context, state) {
                if (state is RemoteMailDone) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Mail sent successfully!')),
                  );
                } else if (state is RemoteMailError) {
                  print(state.error);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to send mail: ${state.error}'),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return IconButton(
                  onPressed: () {
                    if (toRecipients.value.isEmpty) {
                      showCustomDialog(context, "Add at least one recipient.");
                    } else {
                      final mail = MailEntity(
                        to: toRecipients.value,
                        cc: ccRecipients.value,
                        bcc: bccRecipients.value,
                      );
                      BlocProvider.of<RemoteMailBloc>(context)
                          .add(SendMail(mail));
                    }
                  },
                  icon: const Icon(Icons.send),
                );
              },
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
        ),
        body: ListView(
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
            Row(
              children: [
                Expanded(
                  child: PaddedWidget(
                    child: RecipientFormField(
                      label: "To",
                      recipients: toRecipients.value,
                      onDeleted: (recipient) => deleteRecipientFromList(
                        toRecipients,
                        recipient,
                      ),
                      controller: toController,
                      onFieldSubmitted: (value) => addRecipientToList(
                        toRecipients,
                        toController,
                        value,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: toggleAdvancedRecipientForm,
                  icon: AnimatedRotation(
                    duration: const Duration(milliseconds: 500),
                    turns: isAdvancedRecipientFormFieldOpen.value ? 0.5 : 0.0,
                    child: const Icon(
                      Icons.keyboard_arrow_down_outlined,
                    ),
                  ),
                ),
              ],
            ),
            if (isAdvancedRecipientFormFieldOpen.value) ...[
              const DividerFormField(),
              PaddedWidget(
                child: RecipientFormField(
                  label: "Cc",
                  recipients: ccRecipients.value,
                  onDeleted: (recipient) => deleteRecipientFromList(
                    ccRecipients,
                    recipient,
                  ),
                  controller: ccController,
                  onFieldSubmitted: (value) => addRecipientToList(
                    ccRecipients,
                    ccController,
                    value,
                  ),
                ),
              ),
              const DividerFormField(),
              PaddedWidget(
                child: RecipientFormField(
                  label: "Bcc",
                  recipients: bccRecipients.value,
                  onDeleted: (recipient) => deleteRecipientFromList(
                    bccRecipients,
                    recipient,
                  ),
                  controller: bccController,
                  onFieldSubmitted: (value) => addRecipientToList(
                    bccRecipients,
                    bccController,
                    value,
                  ),
                ),
              )
            ],
            const DividerFormField(),
            PaddedWidget(
              child: TextFormField(
                cursorColor: const Color(0xFF005e8e),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Subject",
                  hintStyle: TextStyle(
                    fontSize: 19,
                  ),
                ),
              ),
            ),
            const DividerFormField(),
            PaddedWidget(
              child: TextFormField(
                cursorColor: const Color(0xFF005e8e),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Compose email",
                  hintStyle: TextStyle(
                    fontSize: 19,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
