import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gmail_app/features/email_management/presentation/bloc/fetch_mail_based_on_label.dart';
import 'package:gmail_app/core/utils/show_custom_dialog.dart';
import 'package:gmail_app/core/utils/show_custom_snackbar.dart';
import 'package:gmail_app/core/utils/show_toast.dart';
import 'package:gmail_app/features/email_management/domain/entities/sender_mail.dart';
import 'package:gmail_app/features/email_management/presentation/bloc/label/label_cubit.dart';
import 'package:gmail_app/features/email_management/presentation/bloc/mail/remote/remote_mail_bloc.dart';
import 'package:gmail_app/features/email_management/presentation/bloc/mail/remote/remote_mail_event.dart';
import 'package:gmail_app/features/email_management/presentation/bloc/mail/remote/remote_mail_state.dart';
import 'package:gmail_app/features/email_management/presentation/widgets/compose_mail/divider_form_field.dart';
import 'package:gmail_app/features/email_management/presentation/widgets/compose_mail/label_form_field.dart';
import 'package:gmail_app/features/email_management/presentation/widgets/compose_mail/padded_widget.dart';
import 'package:gmail_app/features/email_management/presentation/widgets/compose_mail/recipient_form_field.dart';

class ComposeMailScreen extends HookWidget {
  const ComposeMailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedLabel = context.watch<LabelCubit>().state.selectedLabel;
    final toRecipients = useState<List<String>>([]);
    final ccRecipients = useState<List<String>>([]);
    final bccRecipients = useState<List<String>>([]);
    final isSaveDraftEnable = useState<bool>(false);
    final toController = useTextEditingController();
    final ccController = useTextEditingController();
    final bccController = useTextEditingController();
    final subjectController = useTextEditingController();
    final bodyController = useTextEditingController();

    useEffect(() {
      void toggleSaveDraft() {
        final hasRecipient = toRecipients.value.isNotEmpty ||
            ccRecipients.value.isNotEmpty ||
            bccRecipients.value.isNotEmpty;
        final hasContent =
            subjectController.text.isNotEmpty || bodyController.text.isNotEmpty;

        isSaveDraftEnable.value = hasRecipient || hasContent;
      }

      toRecipients.addListener(toggleSaveDraft);
      ccRecipients.addListener(toggleSaveDraft);
      bccRecipients.addListener(toggleSaveDraft);
      subjectController.addListener(toggleSaveDraft);
      bodyController.addListener(toggleSaveDraft);

      return () {
        toRecipients.removeListener(toggleSaveDraft);
        ccRecipients.removeListener(toggleSaveDraft);
        bccRecipients.removeListener(toggleSaveDraft);
        subjectController.removeListener(toggleSaveDraft);
        bodyController.removeListener(toggleSaveDraft);
      };
    }, [
      toRecipients,
      ccRecipients,
      bccRecipients,
      subjectController,
      bodyController
    ]);

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
        recipients.value = List.from(recipients.value)..add(recipient.trim());
      }

      controller.clear();
    }

    return BlocListener<RemoteMailBloc, RemoteMailState>(
      listener: (context, state) {
        if (state is RemoteMailSent) {
          Navigator.pop(context);
          fetchMailsBasedOnLabel(context, selectedLabel);
          showCustomSnackbar(context, "Sent mail successfully!");
        } else if (state is SaveAsDraftDone) {
          Navigator.pop(context);
          fetchMailsBasedOnLabel(context, selectedLabel);
          showToast("Message saved as draft.");
        } else if (state is RemoteMailError) {
          showCustomDialog(
            context,
            'Failed to send mail: ${state.error}',
          );
        }
      },
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
            IconButton(
              onPressed: () {
                if (toRecipients.value.isEmpty) {
                  showCustomDialog(context, "Add at least one recipient.");
                } else {
                  final mail = SenderMailEntity(
                    to: toRecipients.value,
                    cc: ccRecipients.value,
                    bcc: bccRecipients.value,
                    subject: subjectController.text.trim(),
                    body: bodyController.text.trim(),
                  );
                  BlocProvider.of<RemoteMailBloc>(context).add(SendMail(mail));
                }
              },
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
                  enabled: isSaveDraftEnable.value,
                  onTap: () {
                    final mail = SenderMailEntity(
                      to: toRecipients.value,
                      cc: ccRecipients.value,
                      bcc: bccRecipients.value,
                      subject: subjectController.text.trim(),
                      body: bodyController.text.trim(),
                      isDraft: true,
                    );
                    BlocProvider.of<RemoteMailBloc>(context)
                        .add(SaveAsDraft(mail));
                  },
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
                controller: subjectController,
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
                controller: bodyController,
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
