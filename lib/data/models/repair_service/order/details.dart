// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/device_password.dart';

class RSOrderDetails extends Equatable {
  final String categoryId;
  final List<String> issueIds;
  final String description;
  final bool deviceWet;
  final String wetDescription;
  final bool accesoriesIncluded;
  final String accesoriesDescription;
  final bool hasWaranty;
  final DevicePassword? password;
  const RSOrderDetails({
    required this.categoryId,
    required this.issueIds,
    required this.description,
    required this.deviceWet,
    required this.wetDescription,
    required this.accesoriesIncluded,
    required this.accesoriesDescription,
    required this.hasWaranty,
    this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categoryId': categoryId,
      'issueIds': issueIds,
      'description': description,
      'deviceWet': deviceWet,
      'wetDescription': wetDescription,
      'accesoriesIncluded': accesoriesIncluded,
      'accesoriesDescription': accesoriesDescription,
      'hasWaranty': hasWaranty,
      'password': password?.toMap(),
    };
  }

  factory RSOrderDetails.fromMap(Map<String, dynamic> map) {
    return RSOrderDetails(
      categoryId: map['categoryId'] as String,
      issueIds: List<String>.from((map['issueIds'] as List)),
      description: map['description'] as String,
      deviceWet: map['deviceWet'] as bool,
      wetDescription: map['wetDescription'] as String,
      accesoriesIncluded: map['accesoriesIncluded'] as bool,
      accesoriesDescription: map['accesoriesDescription'] as String,
      hasWaranty: map['hasWaranty'] as bool,
      password: map['password'] != null ? DevicePassword.fromMap(map['password'] as Map<String, dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RSOrderDetails.fromJson(String source) => RSOrderDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      categoryId,
      issueIds,
      description,
      deviceWet,
      wetDescription,
      accesoriesIncluded,
      accesoriesDescription,
      hasWaranty,
      password ?? 0,
    ];
  }
}
