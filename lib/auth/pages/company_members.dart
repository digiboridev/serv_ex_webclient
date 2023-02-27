import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/core/app_colors.dart';
import 'package:serv_expert_webclient/core/text_styles.dart';
import 'package:serv_expert_webclient/core/validators.dart';
import 'package:serv_expert_webclient/data/models/user/app_user.dart';
import 'package:serv_expert_webclient/data/reposiotories/app_users_repository.dart';
import 'package:serv_expert_webclient/global_providers.dart';
import 'package:serv_expert_webclient/widgets/fillable_scrollable_wrapper.dart';
import 'package:serv_expert_webclient/auth/auth_screen.dart';
import 'package:serv_expert_webclient/widgets/layouter.dart';
import 'package:serv_expert_webclient/widgets/min_spacer.dart';
import 'package:serv_expert_webclient/widgets/regular_button.dart';

final userDataProvider = FutureProvider.autoDispose.family<AppUser, String>((ref, appUserId) async {
  AppUsersRepository appUsersRepository = ref.read(appUsersRepositoryProvider);
  return appUsersRepository.appUserById(id: appUserId);
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
          const Text('ADD COMPANY MEMBERS', style: AppTextStyles.headline),
          const SizedBox(
            height: 86,
          ),
          TextButton(
            onPressed: onAddMemeber,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.add,
                  color: AppColors.primary,
                  size: 18,
                ),
                Text('Add member', style: AppTextStyles.btnText.copyWith(color: AppColors.primary)),
              ],
            ),
          ),
          const SizedBox(
            height: 42,
          ),
          ...editableMembersIds.map((memberId) {
            return SizedBox(
              width: 345,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: memberTile(memberId, true),
              ),
            );
          }).toList(),
          if (editableMembersIds.isNotEmpty)
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
          const Text('ADD COMPANY MEMBERS', style: AppTextStyles.headlineTablet),
          const SizedBox(
            height: 86,
          ),
          TextButton(
            onPressed: onAddMemeber,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.add,
                  color: AppColors.primary,
                  size: 32,
                ),
                Text('Add member', style: AppTextStyles.btnTextTablet.copyWith(color: AppColors.primary)),
              ],
            ),
          ),
          const SizedBox(
            height: 42,
          ),
          ...editableMembersIds.map((memberId) {
            return SizedBox(width: 546, child: memberTile(memberId, false));
          }).toList(),
          if (editableMembersIds.isNotEmpty)
            const SizedBox(
              height: 32,
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

  Widget memberTile(String memberId, bool isMobile) {
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
                  size: isMobile ? 24 : 32,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(appUser.firstName, style: isMobile ? AppTextStyles.formText : AppTextStyles.formTextTablet),
                const SizedBox(
                  width: 8,
                ),
                Text(appUser.lastName, style: isMobile ? AppTextStyles.formText : AppTextStyles.formTextTablet),
                const Spacer(),
                // Dont allow to delete first member because it is always company owner
                if (editableMembersIds.indexOf(memberId) != 0)
                  IconButton(
                    onPressed: () {
                      setState(() => editableMembersIds.remove(appUser.id));
                    },
                    icon: Icon(
                      Icons.delete,
                      size: isMobile ? 24 : 32,
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

final userByEmailOrPhoneProvider = FutureProvider.autoDispose.family<AppUser, String>((ref, searchString) async {
  AppUsersRepository appUsersRepository = ref.read(appUsersRepositoryProvider);
  return appUsersRepository.findAppUserByEmailOrPhone(searchString);
});

class AddMemberDialog extends ConsumerStatefulWidget {
  const AddMemberDialog({required this.membersIds, super.key});

  final List<String> membersIds;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddMemberDialogState();
}

class _AddMemberDialogState extends ConsumerState<AddMemberDialog> {
  String searchString = '';

  @override
  Widget build(BuildContext context) {
    AsyncValue<AppUser> userData = ref.watch(userByEmailOrPhoneProvider(searchString));

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'ADD MEMBER',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            searchField(),
            const SizedBox(
              height: 16,
            ),
            if (searchString.isNotEmpty && userData is AsyncLoading) const CircularProgressIndicator(),
            if (searchString.isNotEmpty && userData is AsyncError)
              const Text(
                'User not found',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            if (searchString.isNotEmpty && userData is AsyncData<AppUser>) ...[
              Text(
                '${userData.value.firstName} ${userData.value.lastName} ${userData.value.email} ${userData.value.phone}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              if (widget.membersIds.contains(userData.value.id))
                const Text(
                  'User already added',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              if (widget.membersIds.contains(userData.value.id))
                const SizedBox(
                  height: 16,
                ),
              if (!widget.membersIds.contains(userData.value.id))
                addButton(() {
                  Navigator.of(context).pop(userData.value);
                }),
            ],
          ],
        ),
      ),
    );
  }

  Widget searchField() {
    return SizedBox(
      width: 600,
      child: TextFormField(
        keyboardType: TextInputType.text,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter email or phone';
          }
          if (!AppValidators.isValidEmail(value) && !AppValidators.isValidPhone(value)) {
            return 'Please enter correct email or phone';
          }
          return null;
        },
        onChanged: (value) {
          searchString = '';
          if (AppValidators.isValidEmail(value) || AppValidators.isValidPhone(value)) {
            searchString = value;
          }
          setState(() {});
        },
        onFieldSubmitted: (value) {
          // searchString = value;
          // ref.refresh(userByEmailOrPhoneProvider(searchString));
          setState(() {
            searchString = value;
          });
        },
        decoration: InputDecoration(
          counter: const SizedBox(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[800]),
          labelText: 'Email or phone',
          fillColor: Colors.white70,
        ),
      ),
    );
  }

  Widget addButton(VoidCallback onTap) {
    return SizedBox(
      width: 600,
      child: Material(
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Ink(
            // width: 600,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text(
                'ADD',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
