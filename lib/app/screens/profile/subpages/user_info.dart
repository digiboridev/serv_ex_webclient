import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/data/models/user/app_user.dart';
import 'package:serv_expert_webclient/app/providers/app_providers.dart';
import 'package:serv_expert_webclient/widgets/fillable_scrollable_wrapper.dart';

class AppUserInfoPage extends ConsumerStatefulWidget {
  const AppUserInfoPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppUserInfoPageState();
}

class _AppUserInfoPageState extends ConsumerState<AppUserInfoPage> {
  @override
  Widget build(BuildContext context) {
    AppUser appUser = ref.read(currentAppUserStreamProvider).value!;

    return Container(
      color: Colors.white,
      child: FillableScrollableWrapper(
        child: Column(
          children: [
            header(),
            info(appUser),
          ],
        ),
      ),
    );
  }

  Widget info(AppUser appUser) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.deepPurple.withOpacity(0.05),
        border: Border.all(
          color: Colors.deepPurple.withOpacity(0.25),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: const [
              Text('Info', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            ],
          ),
          Row(
            children: [
              const Text('Name:'),
              const SizedBox(
                width: 4,
              ),
              Text('${appUser.firstName} ${appUser.lastName}'),
            ],
          ),
          Row(
            children: [
              const Text('Email:'),
              const SizedBox(
                width: 4,
              ),
              Text(appUser.email),
            ],
          ),
          Row(
            children: [
              const Text('Phone:'),
              const SizedBox(
                width: 4,
              ),
              Text(appUser.phone),
            ],
          ),
        ],
      ),
    );
  }

  Widget header() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: const [
          Text('User info', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
