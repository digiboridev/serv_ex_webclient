import 'dart:convert';
import 'package:equatable/equatable.dart';

class RepairServiceVendor extends Equatable {
  final String id;
  final String name;
  const RepairServiceVendor({
    required this.id,
    required this.name,
  });

  RepairServiceVendor copyWith({
    String? id,
    String? name,
  }) {
    return RepairServiceVendor(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory RepairServiceVendor.fromMap(Map<String, dynamic> map) {
    return RepairServiceVendor(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RepairServiceVendor.fromJson(String source) => RepairServiceVendor.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, name];
}
