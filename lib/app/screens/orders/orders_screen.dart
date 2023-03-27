import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/app/app_providers.dart';
import 'package:serv_expert_webclient/app/controllers/contributor_controller.dart';
import 'package:serv_expert_webclient/data/providers/repair_service/category_provider.dart';
import 'package:serv_expert_webclient/app/widgets/sidebar.dart';
import 'package:serv_expert_webclient/core/app_colors.dart';
import 'package:serv_expert_webclient/data/models/repair_service/category.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/order.dart';
import 'package:serv_expert_webclient/data/reposiotories/repair_service/orders_repository.dart';
import 'package:serv_expert_webclient/global_providers.dart';
import 'package:serv_expert_webclient/router.gr.dart';

final ordersStreamProvider = StreamProvider.autoDispose<List<RSOrder>>((ref) {
  ContributorState contributorState = ref.watch(contributorControllerProvider);
  RSOrdersRepository ordersRepository = ref.read(rsOrdersRepositoryProvider);
  if (contributorState is CSAssigned) {
    return ordersRepository.ordersByCustomerIdStream(id: contributorState.id, descending: true);
  } else {
    throw Exception('You have to be assigned to get this resource');
  }
});

class OrdersScreen extends ConsumerStatefulWidget {
  const OrdersScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends ConsumerState<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    AsyncValue<List<RSOrder>> ordersState = ref.watch(ordersStreamProvider);

    return SidebarWrapper(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            header(),
            Expanded(
              child: ordersState.when(
                data: (orders) => ordersList(orders),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text(error.toString())),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ordersList(List<RSOrder> orders) {
    return ListView(
      children: orders.map((e) => orderInfo(e)).toList(),
    );
  }

  Widget orderInfo(RSOrder order) {
    return GestureDetector(
      onTap: () {
        context.router.push(OrderScreen(orderId: order.id));
      },
      child: Container(
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
                const Text('Id:'),
                const SizedBox(
                  width: 4,
                ),
                Text(order.id),
              ],
            ),
            Row(
              children: [
                const Text('Status:'),
                const SizedBox(
                  width: 4,
                ),
                Text(order.status.currentStatus.name),
              ],
            ),
            Row(
              children: [
                const Text('Created:'),
                const SizedBox(
                  width: 4,
                ),
                Text(order.createdAt.toString()),
              ],
            ),
            Consumer(
              builder: (context, ref, child) {
                AsyncValue<RSCategory> categoryData = ref.watch(rsCategoryProvider(order.details.categoryId));

                return Row(
                  children: [
                    const Text('Category:'),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      categoryData.when(
                        data: (category) => category.name,
                        loading: () => 'Loading...',
                        error: (error, stack) => error.toString(),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget header() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: const [
          Text('Orders', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
