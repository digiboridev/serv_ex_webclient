import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/auth/components/new_contact_dialog.dart';
import 'package:serv_expert_webclient/core/app_colors.dart';
import 'package:serv_expert_webclient/data/dto/repair_service/new_contact.dart';
import 'package:serv_expert_webclient/utils/ui_utils.dart';
import 'package:serv_expert_webclient/widgets/fillable_scrollable_wrapper.dart';
import 'package:serv_expert_webclient/auth/auth_screen.dart';
import 'package:serv_expert_webclient/widgets/headline.dart';
import 'package:serv_expert_webclient/widgets/min_spacer.dart';
import 'package:serv_expert_webclient/widgets/regular_button.dart';

class AuthAppUserContacts extends ConsumerStatefulWidget {
  const AuthAppUserContacts({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<AuthAppUserContacts> createState() => _AuthAppUserContactsState();
}

class _AuthAppUserContactsState extends ConsumerState<AuthAppUserContacts> {
  List<NewContactDTO> editableContacts = [];

  onContinue() {
    ref.read(authScreenControllerProvider.notifier).submitAppUserContacts(contacts: editableContacts);
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
    MediaQuery.of(context);

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Container(
        color: Colors.white,
        child: body,
      ),
    );
  }

  Widget get body {
    return FillableScrollableWrapper(
      child: Column(
        children: [
          MinSpacer(flex: whenLayout<int>(mobile: 2, tablet: 1), minHeight: 32),
          const Headline(text: 'ADD CONTACTS'),
          SizedBox(height: whenLayout<double>(mobile: 48.ms, tablet: 72.ts)),
          TextButton(
            onPressed: onAddContact,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add,
                  color: AppColors.primary,
                  size: whenLayout<double>(mobile: 18.ms, tablet: 32.ts),
                ),
                Text(
                  'Add contact',
                  style: TextStyle(
                    fontSize: whenLayout<double>(mobile: 18.ms, tablet: 24.ts),
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: whenLayout<double>(mobile: 42.ms, tablet: 54.ts)),
          ...editableContacts
              .map(
                (contact) => SizedBox(
                  width: whenLayout<double>(mobile: 345.ms, tablet: 546.ts),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: AppColors.black,
                        size: whenLayout<double>(mobile: 24.ms, tablet: 32.ts),
                      ),
                      SizedBox(width: whenLayout<double>(mobile: 4.ms, tablet: 6.ts)),
                      Text(
                        contact.firstName,
                        style: TextStyle(
                          fontSize: whenLayout<double>(mobile: 16.ms, tablet: 24.ts),
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(width: whenLayout<double>(mobile: 4.ms, tablet: 6.ts)),
                      Text(
                        contact.lastName,
                        style: TextStyle(
                          fontSize: whenLayout<double>(mobile: 16.ms, tablet: 24.ts),
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          setState(() => editableContacts.remove(contact));
                        },
                        icon: Icon(
                          Icons.delete,
                          size: whenLayout<double>(mobile: 24.ms, tablet: 32.ts),
                        ),
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
          if (editableContacts.isNotEmpty) SizedBox(height: whenLayout<double>(mobile: 32.ms, tablet: 64.ts)),
          SizedBox(
            width: whenLayout<double>(mobile: 345.ms, tablet: 546.ts),
            child: RegularButton(
              text: 'CONTINUE',
              textStyle: TextStyle(
                fontSize: whenLayout<double>(mobile: 18.ms, tablet: 24.ts),
                fontWeight: FontWeight.w500,
                color: AppColors.white,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: whenLayout<double>(mobile: 16.ms, tablet: 24.ts),
                vertical: whenLayout<double>(mobile: 12.ms, tablet: 18.ts),
              ),
              onTap: onContinue,
            ),
          ),
          const MinSpacer(flex: 1, minHeight: 32),
        ],
      ),
    );
  }
}
