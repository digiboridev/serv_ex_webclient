// ignore_for_file: unused_local_variable

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/app/widgets/sidebar.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/order.dart';
import 'package:serv_expert_webclient/data/providers/repair_service/order_provider.dart';

class OrderScreenLoader extends ConsumerWidget {
  const OrderScreenLoader({@PathParam('orderId') required this.orderId, super.key});
  final String orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<RSOrder> orderData = ref.watch(rsOrderStreamProvider(orderId));

    return SidebarWrapper(
      child: Container(
        color: Colors.white,
        child: orderData.when(
          data: (order) => ClipRect(child: AutoRouter()),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text(error.toString())),
        ),
      ),
    );
  }
}
