import 'dart:async';
import 'package:serv_expert_webclient/data/dto/repair_service/new_order.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/customer_info.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/order.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/status_details/cancelled.dart';
import 'package:serv_expert_webclient/services/api_client.dart';

abstract class RSOrdersRepository {
  Future<RSOrder> createOrder(RSNewOrderDTO order);
  Future<RSOrder> orderById({required String id, bool forceNetwork = false});
  Future<List<RSOrder>> ordersByCustomer({required RSOrderCustomerInfo customerInfo});
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
  Future<RSOrder> orderById({required String id, bool forceNetwork = false}) async {
    Map<String, dynamic> response = await _apiClient.get('/orders/$id');
    return RSOrder.fromMap(response);
  }

  @override
  Future<List<RSOrder>> ordersByCustomer({required RSOrderCustomerInfo customerInfo}) async {
    List response = await _apiClient.get('/orders/', queryParameters: customerInfo.toMap());
    return response.map((e) => RSOrder.fromMap(e)).toList();
  }

  @override
  Future<RSOrder> cancellOrder({required String id, required RSOCancellDetails details}) async {
    Map<String, dynamic> response = await _apiClient.post('/orders/$id/cancell', data: details.toMap());
    return RSOrder.fromMap(response);
  }
}
