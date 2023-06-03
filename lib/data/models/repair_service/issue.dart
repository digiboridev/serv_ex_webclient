// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class RSIssue extends Equatable {
  final String id;
  final String title;
  final String description;

  const RSIssue({
    required this.id,
    required this.title,
    required this.description,
  });

  RSIssue copyWith({
    String? id,
    String? title,
    String? description,
  }) {
    return RSIssue(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
    };
  }

  factory RSIssue.fromMap(Map<String, dynamic> map) {
    return RSIssue(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RSIssue.fromJson(String source) => RSIssue.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, title, description];
}
