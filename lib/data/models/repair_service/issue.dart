// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';

class RSIssue extends Equatable {
  final String id;
  final String name;
  final String categoryId;
  const RSIssue({
    required this.id,
    required this.name,
    required this.categoryId,
  });

  RSIssue copyWith({
    String? id,
    String? name,
    String? categoryId,
  }) {
    return RSIssue(
      id: id ?? this.id,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'categoryId': categoryId,
    };
  }

  factory RSIssue.fromMap(Map<String, dynamic> map) {
    return RSIssue(
      id: map['id'] as String,
      name: map['name'] as String,
      categoryId: map['categoryId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RSIssue.fromJson(String source) => RSIssue.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, name, categoryId];
}
