// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';

class RSOrderDetails extends Equatable {
  final String vendorId;
  final String categoryId;
  final List<String> breakingTypeIds;
  final String description;
  final bool deviceWet;
  final String wetDescription;
  final bool accesoriesIncluded;
  final String accesoriesDescription;
  final bool hasWaranty;
  final bool hasPassword; // TODO add password field
  const RSOrderDetails({
    required this.vendorId,
    required this.categoryId,
    required this.breakingTypeIds,
    required this.description,
    required this.deviceWet,
    required this.wetDescription,
    required this.accesoriesIncluded,
    required this.accesoriesDescription,
    required this.hasWaranty,
    required this.hasPassword,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'vendorId': vendorId,
      'categoryId': categoryId,
      'breakingTypeIds': breakingTypeIds,
      'description': description,
      'deviceWet': deviceWet,
      'wetDescription': wetDescription,
      'accesoriesIncluded': accesoriesIncluded,
      'accesoriesDescription': accesoriesDescription,
      'hasWaranty': hasWaranty,
      'hasPassword': hasPassword,
    };
  }

  factory RSOrderDetails.fromMap(Map<String, dynamic> map) {
    return RSOrderDetails(
      vendorId: map['vendorId'] as String,
      categoryId: map['categoryId'] as String,
      breakingTypeIds: List<String>.from((map['breakingTypeIds'] as List)),
      description: map['description'] as String,
      deviceWet: map['deviceWet'] as bool,
      wetDescription: map['wetDescription'] as String,
      accesoriesIncluded: map['accesoriesIncluded'] as bool,
      accesoriesDescription: map['accesoriesDescription'] as String,
      hasWaranty: map['hasWaranty'] as bool,
      hasPassword: map['hasPassword'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory RSOrderDetails.fromJson(String source) => RSOrderDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      vendorId,
      categoryId,
      breakingTypeIds,
      description,
      deviceWet,
      wetDescription,
      accesoriesIncluded,
      accesoriesDescription,
      hasWaranty,
      hasPassword,
    ];
  }

  RSOrderDetails copyWith({
    String? vendorId,
    String? categoryId,
    List<String>? breakingTypeIds,
    String? description,
    bool? deviceWet,
    String? wetDescription,
    bool? accesoriesIncluded,
    String? accesoriesDescription,
    bool? hasWaranty,
    bool? hasPassword,
  }) {
    return RSOrderDetails(
      vendorId: vendorId ?? this.vendorId,
      categoryId: categoryId ?? this.categoryId,
      breakingTypeIds: breakingTypeIds ?? this.breakingTypeIds,
      description: description ?? this.description,
      deviceWet: deviceWet ?? this.deviceWet,
      wetDescription: wetDescription ?? this.wetDescription,
      accesoriesIncluded: accesoriesIncluded ?? this.accesoriesIncluded,
      accesoriesDescription: accesoriesDescription ?? this.accesoriesDescription,
      hasWaranty: hasWaranty ?? this.hasWaranty,
      hasPassword: hasPassword ?? this.hasPassword,
    );
  }
}
