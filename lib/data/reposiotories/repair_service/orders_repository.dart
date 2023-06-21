import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:serv_expert_webclient/data/dto/repair_service/new_order.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/customer_info.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/order.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/status_details/cancelled.dart';
import 'package:serv_expert_webclient/services/api_client.dart';

abstract class RSOrdersRepository {
  Future<RSOrder> createOrder(RSNewOrderDTO order);
  Future<RSOrder> order({required String id});
  Stream<RSOrder> orderStream({required String id});
  Future<List<RSOrder>> ordersByCustomer({required RSOrderCustomerInfo customerInfo});
  Stream<List<RSOrder>> ordersByCustomerStream({required RSOrderCustomerInfo customerInfo});
  Future<RSOrder> cancellOrder({required String id, required RSOCancellDetails details});
}

class RSOrdersRepositoryHttpImpl implements RSOrdersRepository {
  RSOrdersRepositoryHttpImpl({required ApiClient apiClient}) : _apiClient = apiClient;
  final ApiClient _apiClient;

  @override
  Future<RSOrder> createOrder(RSNewOrderDTO order) async {
    Map<String, dynamic> response = await _apiClient.post('/orders/', data: order.toMap());
    return RSOrder.fromMap(response);
  }

  @override
  Future<RSOrder> order({required String id}) async {
    Map<String, dynamic> response = await _apiClient.get('/orders/$id');
    return RSOrder.fromMap(response);
  }

  Stream<RSOrder> orderUpdatesLP({required String id}) async* {
    while (true) {
      Map<String, dynamic> response = await _apiClient.get('/orders/$id');
      RSOrder updatedOrder = RSOrder.fromMap(response);
      yield updatedOrder;
    }
  }

  Stream<RSOrder> orderUpdatesSSE({required String id}) async* {
    var events = _apiClient.sse('/orders/$id/updates_sse').handleError((e) {
      debugPrint('Order sse: error $e');
    });

    await for (var event in events) {
      debugPrint('Order sse: event');
      RSOrder updatedOrder = RSOrder.fromMap(event);
      yield updatedOrder;
    }
  }

  @override
  Stream<RSOrder> orderStream({required String id}) async* {
    RSOrder order = await this.order(id: id);
    yield order;
    debugPrint('Order stream: initial data loaded');

    while (true) {
      debugPrint('Order stream: connect');
      var updates = orderUpdatesSSE(id: id);
      await for (var updatedOrder in updates) {
        order = updatedOrder;
        yield order;
      }
      debugPrint('Order stream: disconnected');
      await Future.delayed(Duration(seconds: 3)); // Reconnect timeout
    }
  }

  @override
  Future<List<RSOrder>> ordersByCustomer({required RSOrderCustomerInfo customerInfo}) async {
    List response = await _apiClient.get('/orders/', queryParameters: customerInfo.toMap());
    return response.map((e) => RSOrder.fromMap(e)).toList();
  }

  Stream<RSOrder> ordersUpdatesLP({required RSOrderCustomerInfo customerInfo}) async* {
    while (true) {
      Map<String, dynamic> response = await _apiClient.get('/orders/updates_lp', queryParameters: customerInfo.toMap());
      RSOrder updatedOrder = RSOrder.fromMap(response);
      yield updatedOrder;
    }
  }

  Stream<RSOrder> ordersUpdatesSSE({required RSOrderCustomerInfo customerInfo}) async* {
    var events = _apiClient.sse('/orders/updates_sse', queryParameters: customerInfo.toMap()).handleError((e) {
      debugPrint('Orders sse: error $e');
    });

    await for (var event in events) {
      debugPrint('Orders sse: event');
      RSOrder updatedOrder = RSOrder.fromMap(event);
      yield updatedOrder;
    }
  }

  @override
  Stream<List<RSOrder>> ordersByCustomerStream({required RSOrderCustomerInfo customerInfo}) async* {
    List<RSOrder> orders = await ordersByCustomer(customerInfo: customerInfo);
    yield orders;
    debugPrint('Orders stream: initial data loaded');

    while (true) {
      debugPrint('Orders stream: connect');
      var updates = ordersUpdatesSSE(customerInfo: customerInfo);
      await for (var updatedOrder in updates) {
        if (orders.map((e) => e.id).contains(updatedOrder.id)) {
          // Replace existing order with updated one
          orders[orders.indexWhere((element) => element.id == updatedOrder.id)] = updatedOrder;
        } else {
          // Add new order to the beginning of the list
          orders.insert(0, updatedOrder);
        }
        yield orders;
      }
      debugPrint('Orders stream: disconnected');
      await Future.delayed(Duration(seconds: 3)); // Reconnect timeout
    }
  }

  @override
  Future<RSOrder> cancellOrder({required String id, required RSOCancellDetails details}) async {
    Map<String, dynamic> response = await _apiClient.post('/orders/$id/cancell', data: details.toMap());
    return RSOrder.fromMap(response);
  }
}
