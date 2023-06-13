// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/customer_info.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/details.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/status.dart';

enum PaymentStatus {
  notPaid,
  paid,
}

enum DeviceLocation {
  customer,
  laboratory,
}

class RSOrder extends Equatable {
  final String id;
  final RSOrderCustomerInfo customerInfo;
  final RSOrderDetails details;
  final RSOStatus status;
  final PaymentStatus paymentStatus;
  final DeviceLocation deviceLocation;
  final DateTime createdAt;
  final DateTime updatedAt;

  const RSOrder({
    required this.id,
    required this.customerInfo,
    required this.details,
    required this.status,
    required this.paymentStatus,
    required this.deviceLocation,
    required this.createdAt,
    required this.updatedAt,
  });

  RSOrder copyWith({
    String? id,
    RSOrderCustomerInfo? customerInfo,
    RSOrderDetails? details,
    RSOStatus? status,
    PaymentStatus? paymentStatus,
    DeviceLocation? deviceLocation,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RSOrder(
      id: id ?? this.id,
      customerInfo: customerInfo ?? this.customerInfo,
      details: details ?? this.details,
      status: status ?? this.status,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      deviceLocation: deviceLocation ?? this.deviceLocation,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'customerInfo': customerInfo.toMap(),
      'details': details.toMap(),
      'status': status.toMap(),
      'paymentStatus': paymentStatus.name,
      'deviceLocation': deviceLocation.name,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory RSOrder.fromMap(Map<String, dynamic> map) {
    return RSOrder(
      id: map['id'] as String,
      customerInfo: RSOrderCustomerInfo.fromMap(map['customerInfo'] as Map<String, dynamic>),
      details: RSOrderDetails.fromMap(map['details'] as Map<String, dynamic>),
      status: RSOStatus.fromMap(map['status'] as Map<String, dynamic>),
      paymentStatus: PaymentStatus.values.byName(map['paymentStatus'] as String),
      deviceLocation: DeviceLocation.values.byName(map['deviceLocation'] as String),
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
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
      paymentStatus,
      deviceLocation,
      createdAt,
      updatedAt,
    ];
  }
}
