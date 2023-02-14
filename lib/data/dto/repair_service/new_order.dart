import 'dart:convert';

enum DevicePasswordType {
  graphic,
  numeric,
}

class RSNewOrderDTO {
  String? vendorId;
  String? categoryId;
  List<String>? breakingTypeIds;
  String? description;
  bool? deviceWet;
  String? wetDescription;
  bool? accesoriesIncluded;
  String? accesoriesDescription;
  bool? hasWaranty;
  bool? hasPassword;
  DevicePasswordType? passwordType;

  RSNewOrderDTO({
    this.vendorId,
    this.categoryId,
    this.breakingTypeIds,
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
    if (vendorId == null || vendorId!.isEmpty) return false;
    if (categoryId == null || categoryId!.isEmpty) return false;
    if (breakingTypeIds == null || breakingTypeIds!.isEmpty) return false;
    if (description == null || description!.isEmpty) return false;
    if (deviceWet == null) return false;
    if (deviceWet! && (wetDescription == null || wetDescription!.isEmpty)) return false;
    if (accesoriesIncluded == null) return false;
    if (accesoriesIncluded! && (accesoriesDescription == null || accesoriesDescription!.isEmpty)) return false;
    if (hasWaranty == null) return false;
    if (hasPassword == null) return false;
    if (passwordType == null) return false;
    return true;
  }

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
      'passwordType': passwordType?.name,
    };
  }

  String toJson() => json.encode(toMap());
}
