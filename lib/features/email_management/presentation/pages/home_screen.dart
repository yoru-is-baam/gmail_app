import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gmail_app/core/constants/label.dart';
import 'package:gmail_app/core/constants/routes.dart';
import 'package:gmail_app/core/utils/enum_util.dart';
import 'package:gmail_app/features/email_management/presentation/bloc/fetch_mail_based_on_label.dart';
import 'package:gmail_app/features/email_management/domain/usecases/params/update_mail_params.dart';
import 'package:gmail_app/features/email_management/presentation/bloc/label/label_cubit.dart';
import 'package:gmail_app/features/email_management/presentation/bloc/label/label_state.dart';
import 'package:gmail_app/features/email_management/presentation/bloc/mail/remote/remote_mail_bloc.dart';
import 'package:gmail_app/features/email_management/presentation/bloc/mail/remote/remote_mail_event.dart';
import 'package:gmail_app/features/email_management/presentation/bloc/mail/remote/remote_mail_state.dart';
import 'package:gmail_app/features/email_management/presentation/widgets/label/label_dialog.dart';
import 'package:gmail_app/features/email_management/presentation/widgets/label/label_item.dart';
import 'package:gmail_app/features/email_management/presentation/widgets/label/label_item_text.dart';
import 'package:gmail_app/features/email_management/presentation/widgets/mail_list/mail_list.dart';
import 'package:gmail_app/features/email_management/presentation/widgets/search/search_bar_overview.dart';
import 'package:ionicons/ionicons.dart';

class HomeScreen extends StatefulHookWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RemoteMailBloc>().add(const GetInboxMails());
  }

  @override
  Widget build(BuildContext context) {
    final selectedLabel = context.watch<LabelCubit>().state.selectedLabel;

    void changeSelectedLabel(BuildContext context, Label label) {
      // close the drawer
      Navigator.of(context).pop();

      context.read<LabelCubit>().updateLabel(label);
    }

    return Scaffold(
      body: Builder(
        builder: (context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 12,
                      right: 12,
                      bottom: 0,
                    ),
                    child: SearchBarOverview(
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 15,
                    ),
                    child: LabelItemText(
                      text: EnumUtil.convertToCapitalization(
                        selectedLabel,
                      ),
                      fontSize: 14,
                    ),
                  ),
                  BlocListener<LabelCubit, LabelState>(
                    listener: (context, state) {
                      final updatedLabel = state.selectedLabel;
                      fetchMailsBasedOnLabel(context, updatedLabel);
                    },
                    child: BlocBuilder<RemoteMailBloc, RemoteMailState>(
                      builder: (_, state) {
                        if (state is RemoteMailLoading) {
                          return const Center(
                            child: CupertinoActivityIndicator(),
                          );
                        }

                        if (state is RemoteMailError) {
                          return const Center(
                            child: Icon(Icons.refresh),
                          );
                        }

                        if (state is RemoteMailInboxDone) {
                          return MailList(
                            mails: state.inboxMails!,
                            onTap: (mailId, isStarred) {
                              log(mailId + isStarred.toString());
                              context.read<RemoteMailBloc>().add(
                                    UpdateReceivedMail(
                                      UpdateMailParams(
                                        mailId: mailId,
                                        isStarred: !isStarred,
                                      ),
                                    ),
                                  );
                            },
                          );
                        }

                        if (state is RemoteMailSentDone) {
                          return MailList(mails: state.sentMails!);
                        }

                        if (state is RemoteMailStarredDone) {
                          return MailList(mails: state.starredMails!);
                        }

                        return const SizedBox();
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      drawer: SafeArea(
        child: Drawer(
          backgroundColor: const Color(0xFFe0ecf6),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 30,
                  right: 30,
                  bottom: 15,
                ),
                child: Text(
                  "Gmail",
                  style: TextStyle(
                    color: Color(0xFFe04329),
                    fontSize: 19,
                  ),
                ),
              ),
              const Divider(
                thickness: 0.6,
                color: Color(0xFFa7acac),
              ),
              LabelItem(
                iconData: Icons.inbox_rounded,
                title: "Inbox",
                isActive: selectedLabel == Label.inbox,
                onTap: () => changeSelectedLabel(context, Label.inbox),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 12,
                  left: 30,
                  right: 30,
                  bottom: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const LabelItemText(
                      text: "All labels",
                      fontSize: 14,
                    ),
                    IconButton(
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => LabelDialog(),
                      ),
                      icon: const Icon(
                        Icons.add_circle_outline_outlined,
                      ),
                    ),
                  ],
                ),
              ),
              LabelItem(
                iconData: Icons.star_border_outlined,
                title: "Starred",
                isActive: selectedLabel == Label.starred,
                onTap: () => changeSelectedLabel(context, Label.starred),
              ),
              LabelItem(
                iconData: Icons.send_outlined,
                title: "Sent",
                isActive: selectedLabel == Label.sent,
                onTap: () => changeSelectedLabel(context, Label.sent),
              ),
              LabelItem(
                iconData: Ionicons.document_outline,
                title: "Drafts",
                isActive: selectedLabel == Label.drafts,
                onTap: () => changeSelectedLabel(context, Label.drafts),
              ),
              LabelItem(
                iconData: Icons.delete_outline_outlined,
                title: "Trash",
                isActive: selectedLabel == Label.trash,
                onTap: () => changeSelectedLabel(context, Label.trash),
              ),
              LabelItem(
                color: Colors.pink[300],
                iconData: Icons.label_outline_rounded,
                title: "Recruitment",
                onTap: () {},
              ),
              LabelItem(
                color: Colors.cyan[400],
                iconData: Icons.label_outline_rounded,
                title: "Services",
                onTap: () {},
              ),
              const Divider(
                thickness: 0.6,
                color: Color(0xFFa7acac),
              ),
              LabelItem(
                iconData: Ionicons.settings_outline,
                title: "Setting",
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, composeMailRoute),
        backgroundColor: const Color(0xFFc8dded),
        icon: const Icon(Icons.mode_edit_outlined),
        label: const Text("Compose"),
      ),
    );
  }
}
