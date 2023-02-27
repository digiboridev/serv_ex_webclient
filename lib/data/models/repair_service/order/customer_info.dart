import 'dart:convert';
import 'package:equatable/equatable.dart';

enum RSOrderCustomerType {
  personal,
  company,
}

class RSOrderCustomerInfo extends Equatable {
  final RSOrderCustomerType customerType;
  final String customerId;
  const RSOrderCustomerInfo({
    required this.customerType,
    required this.customerId,
  });

  RSOrderCustomerInfo copyWith({
    RSOrderCustomerType? customerType,
    String? customerId,
  }) {
    return RSOrderCustomerInfo(
      customerType: customerType ?? this.customerType,
      customerId: customerId ?? this.customerId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'customerType': customerType.name,
      'customerId': customerId,
    };
  }

  factory RSOrderCustomerInfo.fromMap(Map<String, dynamic> map) {
    return RSOrderCustomerInfo(
      customerType: RSOrderCustomerType.values.byName(map['customerType'] as String),
      customerId: map['customerId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RSOrderCustomerInfo.fromJson(String source) => RSOrderCustomerInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [customerType, customerId];
}
