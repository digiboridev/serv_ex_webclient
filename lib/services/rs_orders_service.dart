// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:serv_expert_webclient/data/dto/repair_service/new_order.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/details.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/order.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/status.dart';
import 'package:serv_expert_webclient/data/reposiotories/repair_service/orders_repository.dart';

// TODO move to backend
class RSOrdersService {
  final RSOrdersRepository _ordersRepository;
  RSOrdersService({
    required RSOrdersRepository ordersRepository,
  }) : _ordersRepository = ordersRepository;

  Future createOrder({required RSNewOrderDTO order}) async {
    if (order.validate() == false) throw Exception('Invalid order');

    RSOrder newOrder = RSOrder(
      id: _ordersRepository.generateId(),
      customerInfo: order.customerInfo!,
      details: RSOrderDetails(
        categoryId: order.categoryId!,
        issueIds: order.issueIds!,
        description: order.description!,
        deviceWet: order.deviceWet!,
        wetDescription: order.wetDescription!,
        accesoriesIncluded: order.accesoriesIncluded!,
        accesoriesDescription: order.accesoriesDescription!,
        hasWaranty: order.hasWaranty!,
        hasPassword: order.hasPassword!,
      ),
      status: RSOrderStatus.newOrder,
      statusesDetails: const RSOrderStatusesDetails(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await _ordersRepository.setOrder(newOrder);
  }

  Future cancelOrder({required String orderId, required RSOCancellDetails details}) async {
    RSOrder order = await _ordersRepository.orderById(id: orderId);
    if (order.status == RSOrderStatus.canceled) throw Exception('Order already canceled');

    RSOrderStatusesDetails newStatusesDetails = order.statusesDetails.copyWith(
      cancellDetails: details,
    );

    RSOrder newOrder = order.copyWith(
      status: RSOrderStatus.canceled,
      statusesDetails: newStatusesDetails,
      updatedAt: DateTime.now(),
    );

    await _ordersRepository.setOrder(newOrder);
  }
}
