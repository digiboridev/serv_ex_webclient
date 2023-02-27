import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:serv_expert_webclient/data/models/access.dart';

class RSVendor extends Equatable {
  final String id;
  final String name;
  final Access access;
  const RSVendor({
    required this.id,
    required this.name,
    required this.access,
  });

  RSVendor copyWith({
    String? id,
    String? name,
    Access? access,
  }) {
    return RSVendor(
      id: id ?? this.id,
      name: name ?? this.name,
      access: access ?? this.access,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'access': access.toMap(),
    };
  }

  factory RSVendor.fromMap(Map<String, dynamic> map) {
    return RSVendor(
      id: map['id'] as String,
      name: map['name'] as String,
      access: Access.fromMap(map['access'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory RSVendor.fromJson(String source) => RSVendor.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, name];
}
