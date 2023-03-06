// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:serv_expert_webclient/data/models/repair_service/order/customer_info.dart';

enum DevicePasswordType {
  graphic,
  numeric,
}

class RSNewOrderDTO {
  RSOrderCustomerInfo? customerInfo;
  String? categoryId;
  List<String>? issueIds;
  String? description;
  bool? deviceWet;
  String? wetDescription;
  bool? accesoriesIncluded;
  String? accesoriesDescription;
  bool? hasWaranty;
  bool? hasPassword;
  DevicePasswordType? passwordType;

  RSNewOrderDTO({
    this.customerInfo,
    this.categoryId,
    this.issueIds,
    this.description,
    this.deviceWet,
    this.wetDescription,
    this.accesoriesIncluded,
    this.accesoriesDescription,
    this.hasWaranty,
    this.hasPassword,
    this.passwordType,
  });

  bool validate() {
    if (customerInfo == null) return false;
    if (categoryId == null || categoryId!.isEmpty) return false;
    if (issueIds == null || issueIds!.isEmpty) return false;
    if (description == null || description!.isEmpty) return false;
    if (deviceWet == null) return false;
    if (deviceWet! && (wetDescription == null || wetDescription!.isEmpty)) return false;
    if (accesoriesIncluded == null) return false;
    if (accesoriesIncluded! && (accesoriesDescription == null || accesoriesDescription!.isEmpty)) return false;
    if (hasWaranty == null) return false;
    if (hasPassword == null) return false;
    if (hasPassword! && passwordType == null) return false;
    return true;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'customerInfo': customerInfo?.toMap(),
      'category': categoryId,
      'issues': issueIds,
      'description': description,
      'deviceWet': deviceWet,
      'wetDescription': wetDescription,
      'accesoriesIncluded': accesoriesIncluded,
      'accesoriesDescription': accesoriesDescription,
      'hasWaranty': hasWaranty,
      'hasPassword': hasPassword,
      'passwordType': passwordType?.name,
    };
  }

  String toJson() => json.encode(toMap());
}
