import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gmail_app/core/constants/label.dart';
import 'package:gmail_app/core/constants/routes.dart';
import 'package:gmail_app/core/utils/enum_util.dart';
import 'package:gmail_app/features/email_management/presentation/bloc/mail/remote/remote_mail_bloc.dart';
import 'package:gmail_app/features/email_management/presentation/bloc/mail/remote/remote_mail_event.dart';
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
    final selectedLabel = useState<Label>(Label.inbox);

    void changeSelectedLabel(BuildContext context, Label label) {
      // close the drawer
      Navigator.of(context).pop();

      selectedLabel.value = label;

      switch (label) {
        case Label.inbox:
          context.read<RemoteMailBloc>().add(const GetInboxMails());
          break;
        case Label.starred:
          context.read<RemoteMailBloc>().add(const GetStarredMails());
          break;
        case Label.sent:
          context.read<RemoteMailBloc>().add(const GetSentMails());
          break;
        case Label.drafts:
          context.read<RemoteMailBloc>().add(const GetDraftMails());
          break;
        case Label.trash:
          context.read<RemoteMailBloc>().add(const GetTrashMails());
          break;
        default:
          context.read<RemoteMailBloc>().add(const GetInboxMails());
          break;
      }
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
                        selectedLabel.value,
                      ),
                      fontSize: 14,
                    ),
                  ),
                  const MailList(),
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
                isActive: selectedLabel.value == Label.inbox,
                onTap: () => changeSelectedLabel(context, Label.inbox),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  top: 30,
                  left: 30,
                  right: 30,
                  bottom: 5,
                ),
                child: LabelItemText(
                  text: "All labels",
                  fontSize: 14,
                ),
              ),
              LabelItem(
                iconData: Icons.star_border_outlined,
                title: "Starred",
                isActive: selectedLabel.value == Label.starred,
                onTap: () => changeSelectedLabel(context, Label.starred),
              ),
              LabelItem(
                iconData: Icons.send_outlined,
                title: "Sent",
                isActive: selectedLabel.value == Label.sent,
                onTap: () => changeSelectedLabel(context, Label.sent),
              ),
              LabelItem(
                iconData: Ionicons.document_outline,
                title: "Drafts",
                isActive: selectedLabel.value == Label.drafts,
                onTap: () => changeSelectedLabel(context, Label.drafts),
              ),
              LabelItem(
                iconData: Icons.delete_outline_outlined,
                title: "Trash",
                isActive: selectedLabel.value == Label.trash,
                onTap: () => changeSelectedLabel(context, Label.trash),
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
