import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/data/models/user/app_user.dart';
import 'package:serv_expert_webclient/data/reposiotories/users_repository.dart';
import 'package:serv_expert_webclient/global_providers.dart';
import 'package:serv_expert_webclient/utils/validators.dart';

final userByEmailOrPhoneProvider = FutureProvider.autoDispose.family<AppUser, String>((ref, searchString) async {
  UsersRepository usersRepository = ref.read(usersRepositoryProvider);
  return usersRepository.userByEmailOrPhone(emailOrPhone: searchString);
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
