import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/customer_info.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/details.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/status.dart';

class RSOrder extends Equatable {
  final String id;
  final RSOrderCustomerInfo customerInfo;
  final RSOrderDetails details;
  final RSOrderStatus status;
  final RSOrderStatusesDetails statusesDetails;
  final DateTime createdAt;
  final DateTime updatedAt;

  const RSOrder({
    required this.id,
    required this.customerInfo,
    required this.details,
    required this.status,
    required this.statusesDetails,
    required this.createdAt,
    required this.updatedAt,
  });

  RSOrder copyWith({
    String? id,
    RSOrderCustomerInfo? customerInfo,
    RSOrderDetails? details,
    RSOrderStatus? status,
    RSOrderStatusesDetails? statusesDetails,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RSOrder(
      id: id ?? this.id,
      customerInfo: customerInfo ?? this.customerInfo,
      details: details ?? this.details,
      status: status ?? this.status,
      statusesDetails: statusesDetails ?? this.statusesDetails,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'customerInfo': customerInfo.toMap(),
      'details': details.toMap(),
      'status': status.name,
      'statusesDetails': statusesDetails.toMap(),
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory RSOrder.fromMap(Map<String, dynamic> map) {
    return RSOrder(
      id: map['id'] as String,
      customerInfo: RSOrderCustomerInfo.fromMap(map['customerInfo'] as Map<String, dynamic>),
      details: RSOrderDetails.fromMap(map['details'] as Map<String, dynamic>),
      status: RSOrderStatus.values.byName(map['status'] as String),
      statusesDetails: RSOrderStatusesDetails.fromMap(map['statusesDetails'] as Map<String, dynamic>),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory RSOrder.fromJson(String source) => RSOrder.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      customerInfo,
      details,
      status,
      statusesDetails,
      createdAt,
      updatedAt,
    ];
  }
}
