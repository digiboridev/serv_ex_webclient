import 'dart:convert';
import 'package:equatable/equatable.dart';

class RSVendor extends Equatable {
  final String id;
  final String name;
  const RSVendor({
    required this.id,
    required this.name,
  });

  RSVendor copyWith({
    String? id,
    String? name,
  }) {
    return RSVendor(
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

  factory RSVendor.fromMap(Map<String, dynamic> map) {
    return RSVendor(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RSVendor.fromJson(String source) => RSVendor.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, name];
}
