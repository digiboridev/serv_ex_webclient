import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/auth/components/new_contact_dialog.dart';
import 'package:serv_expert_webclient/core/app_colors.dart';
import 'package:serv_expert_webclient/core/text_styles.dart';
import 'package:serv_expert_webclient/data/dto/repair_service/new_contact.dart';
import 'package:serv_expert_webclient/data/models/client/client_contact.dart';
import 'package:serv_expert_webclient/widgets/fillable_scrollable_wrapper.dart';
import 'package:serv_expert_webclient/auth/auth_screen.dart';
import 'package:serv_expert_webclient/widgets/layouter.dart';
import 'package:serv_expert_webclient/widgets/min_spacer.dart';
import 'package:serv_expert_webclient/widgets/regular_button.dart';

class AuthClientContacts extends ConsumerStatefulWidget {
  const AuthClientContacts({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<AuthClientContacts> createState() => _AuthClientContactsState();
}

class _AuthClientContactsState extends ConsumerState<AuthClientContacts> {
  List<NewContactDTO> editableContacts = [];

  onContinue() {
    List<ClientContact> clientContacts = editableContacts
        .map(
          (e) => ClientContact(
            firstName: e.firstName,
            lastName: e.lastName,
            phone: e.phone,
          ),
        )
        .toList();

    ref.read(authScreenControllerProvider.notifier).submitClientContacts(contacts: clientContacts);
  }

  onAddContact() async {
    var result = await showDialog(
      context: context,
      builder: (_) {
        return const Dialog(
          child: AddContactDialog(),
        );
      },
    );
    if (result is NewContactDTO) {
      setState(() => editableContacts.add(result));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Container(
        color: Colors.white,
        child: Layouter(mobileLayout: mobileBody, tabletLayout: tabletBody),
      ),
    );
  }

  Widget get mobileBody {
    return FillableScrollableWrapper(
      child: Column(
        children: [
          const MinSpacer(
            minHeight: 32,
            flex: 2,
          ),
          const Text('ADD CONTACTS', style: AppTextStyles.headline),
          const SizedBox(
            height: 48,
          ),
          TextButton(
            onPressed: onAddContact,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.add,
                  color: AppColors.primary,
                  size: 18,
                ),
                Text('Add contact', style: AppTextStyles.btnText.copyWith(color: AppColors.primary)),
              ],
            ),
          ),
          const SizedBox(
            height: 42,
          ),
          ...editableContacts
              .map(
                (contact) => SizedBox(
                  width: 345,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.person,
                          color: AppColors.black,
                          size: 24,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(contact.firstName, style: AppTextStyles.formText),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(contact.lastName, style: AppTextStyles.formText),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            setState(() => editableContacts.remove(contact));
                          },
                          icon: const Icon(
                            Icons.delete,
                            size: 24,
                          ),
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
          if (editableContacts.isNotEmpty)
            const SizedBox(
              height: 32,
            ),
          SizedBox(
            width: 345,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: RegularButton(
                text: 'CONTINUE',
                textStyle: AppTextStyles.btnText,
                onTap: onContinue,
              ),
            ),
          ),
          const MinSpacer(
            minHeight: 32,
            flex: 1,
          ),
        ],
      ),
    );
  }

  Widget get tabletBody {
    return FillableScrollableWrapper(
      child: Column(
        children: [
          const MinSpacer(
            minHeight: 32,
          ),
          const Text('ADD CONTACTS', style: AppTextStyles.headlineTablet),
          const SizedBox(
            height: 72,
          ),
          TextButton(
            onPressed: onAddContact,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.add,
                  color: AppColors.primary,
                  size: 32,
                ),
                Text('Add contact', style: AppTextStyles.btnTextTablet.copyWith(color: AppColors.primary)),
              ],
            ),
          ),
          const SizedBox(
            height: 52,
          ),
          ...editableContacts
              .map(
                (contact) => SizedBox(
                  width: 546,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.person,
                        color: AppColors.black,
                        size: 32,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(contact.firstName, style: AppTextStyles.formTextTablet),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(contact.lastName, style: AppTextStyles.formTextTablet),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          setState(() => editableContacts.remove(contact));
                        },
                        icon: const Icon(
                          Icons.delete,
                          size: 32,
                        ),
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
          if (editableContacts.isNotEmpty)
            const SizedBox(
              height: 64,
            ),
          SizedBox(
            width: 546,
            child: RegularButton(
              text: 'CONTINUE',
              textStyle: AppTextStyles.btnTextTablet,
              onTap: onContinue,
            ),
          ),
          const MinSpacer(
            minHeight: 32,
          ),
        ],
      ),
    );
  }
}
