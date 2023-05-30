import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/auth/components/company_member_dialog.dart';
import 'package:serv_expert_webclient/core/app_colors.dart';
import 'package:serv_expert_webclient/core/text_styles.dart';
import 'package:serv_expert_webclient/data/models/user/app_user.dart';
import 'package:serv_expert_webclient/data/reposiotories/user_repository.dart';
import 'package:serv_expert_webclient/global_providers.dart';
import 'package:serv_expert_webclient/utils/ui_utils.dart';
import 'package:serv_expert_webclient/widgets/fillable_scrollable_wrapper.dart';
import 'package:serv_expert_webclient/auth/auth_screen.dart';
import 'package:serv_expert_webclient/widgets/headline.dart';
import 'package:serv_expert_webclient/widgets/min_spacer.dart';
import 'package:serv_expert_webclient/widgets/regular_button.dart';

final userDataProvider = FutureProvider.autoDispose.family<AppUser, String>((ref, appUserId) async {
  UserRepository userRepository = ref.read(userRepositoryProvider);
  return userRepository.appUser();
});

class AuthCompanyMembers extends ConsumerStatefulWidget {
  const AuthCompanyMembers({
    Key? key,
    required this.membersIds,
  }) : super(key: key);

  final List<String> membersIds;

  @override
  ConsumerState<AuthCompanyMembers> createState() => _AuthCompanyMembersState();
}

class _AuthCompanyMembersState extends ConsumerState<AuthCompanyMembers> {
  List<String> editableMembersIds = [];

  onContinue() {
    ref.read(authScreenControllerProvider.notifier).submitCompanyMembersIds(
          membersIds: editableMembersIds,
        );
  }

  onAddMemeber() async {
    var result = await showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          child: AddMemberDialog(
            membersIds: editableMembersIds,
          ),
        );
      },
    );
    if (result is AppUser) {
      setState(() => editableMembersIds.add(result.id));
    }
  }

  @override
  void initState() {
    super.initState();
    editableMembersIds = widget.membersIds;
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
          const Headline(text: 'ADD COMPANY MEMBERS'),
          SizedBox(height: whenLayout<double>(mobile: 84.ms, tablet: 72.ts)),
          TextButton(
            onPressed: onAddMemeber,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add,
                  color: AppColors.primary,
                  size: whenLayout<double>(mobile: 18.ms, tablet: 32.ts),
                ),
                Text(
                  'Add member',
                  style: TextStyle(
                    fontSize: whenLayout<double>(mobile: 18.ms, tablet: 24.ts),
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: whenLayout<double>(mobile: 32.ms, tablet: 48.ts)),
          ...editableMembersIds.map((memberId) {
            return SizedBox(
              width: whenLayout<double>(mobile: 345.ms, tablet: 546.ts),
              child: memberTile(memberId),
            );
          }).toList(),
          if (editableMembersIds.isNotEmpty) SizedBox(height: whenLayout<double>(mobile: 32.ms, tablet: 48.ts)),
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

  Widget memberTile(String memberId) {
    return Consumer(
      builder: (context, ref, child) {
        AsyncValue<AppUser> userData = ref.watch(userDataProvider(memberId));
        return userData.when(
          data: (appUser) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.person,
                  color: AppColors.black,
                  size: whenLayout<double>(mobile: 24.ms, tablet: 32.ts),
                ),
                SizedBox(width: whenLayout<double>(mobile: 4.ms, tablet: 8.ts)),
                Text(
                  appUser.firstName,
                  style: TextStyle(
                    fontSize: whenLayout<double>(mobile: 16.ms, tablet: 24.ts),
                    fontWeight: FontWeight.w400,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(width: whenLayout<double>(mobile: 4.ms, tablet: 8.ts)),
                Text(
                  appUser.lastName,
                  style: TextStyle(
                    fontSize: whenLayout<double>(mobile: 16.ms, tablet: 24.ts),
                    fontWeight: FontWeight.w400,
                    color: AppColors.black,
                  ),
                ),
                const Spacer(),
                // Dont allow to delete first member because it is always company owner
                if (editableMembersIds.indexOf(memberId) != 0)
                  IconButton(
                    onPressed: () {
                      setState(() => editableMembersIds.remove(appUser.id));
                    },
                    icon: Icon(
                      Icons.delete,
                      size: whenLayout<double>(mobile: 24.ms, tablet: 32.ts),
                    ),
                    color: AppColors.primary,
                  ),
              ],
            );
          },
          loading: () {
            return const Text('Loading...', style: AppTextStyles.formText);
          },
          error: (error, stackTrace) {
            return const Text('Error', style: AppTextStyles.formText);
          },
        );
      },
    );
  }
}
