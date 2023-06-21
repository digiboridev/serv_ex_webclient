import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/app/widgets/sidebar.dart';
import 'package:serv_expert_webclient/core/app_colors.dart';
import 'package:serv_expert_webclient/data/models/user/app_user.dart';
import 'package:serv_expert_webclient/app/app_providers.dart';
import 'package:serv_expert_webclient/services/auth_data_repository.dart';
import 'package:serv_expert_webclient/utils/sse_connection.dart';
import 'package:serv_expert_webclient/widgets/fillable_scrollable_wrapper.dart';
import 'package:universal_html/html.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    super.initState();

    test();
  }

  test() async {
    var acces = AuthDataRepository().accessToken;
    SSEConnection.connect(
      url: 'http://localhost:3000/orders/customer_orders_updates_sse',
      headers: {'authorization': 'Bearer $acces'},
    ).listen(
      (event) {
        debugPrint('Event: $event');
      },
      onError: (e) {
        debugPrint('Error: $e');
      },
      onDone: () {
        debugPrint('Done:');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    AppUser appUser = ref.read(currentAppUserStreamProvider).value!;

    return SidebarWrapper(
      child: Container(
        color: Colors.white,
        child: FillableScrollableWrapper(
          child: Column(
            children: [
              header(),
              info(appUser),
            ],
          ),
        ),
      ),
    );
  }

  Widget info(AppUser appUser) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            offset: const Offset(0, 4),
            blurRadius: 8,
          ),
        ],
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
          Text('Profile', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
