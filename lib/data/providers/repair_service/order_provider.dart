
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/order.dart';
import 'package:serv_expert_webclient/data/reposiotories/repair_service/orders_repository.dart';
import 'package:serv_expert_webclient/global_providers.dart';

final rsOrderStreamProvider = StreamProvider.autoDispose.family<RSOrder, String>((ref, orderId) {
  RSOrdersRepository ordersRepository = ref.read(rsOrdersRepositoryProvider);
  return ordersRepository.orderByIdStream(id: orderId);
});
