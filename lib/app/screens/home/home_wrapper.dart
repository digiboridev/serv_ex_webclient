import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/app/widgets/sidebar.dart';

class HomeWrapper extends ConsumerStatefulWidget {
  const HomeWrapper({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends ConsumerState<HomeWrapper> {
  @override
  Widget build(BuildContext context) {
    return const SidebarWrapper(child: ClipRect(child: AutoRouter()));
  }
}
