// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Issue extends Equatable {
  final String id;
  final String title;
  final String description;

  const Issue({
    required this.id,
    required this.title,
    required this.description,
  });

  Issue copyWith({
    String? id,
    String? title,
    String? description,
  }) {
    return Issue(
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

  factory Issue.fromMap(Map<String, dynamic> map) {
    return Issue(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Issue.fromJson(String source) => Issue.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, title, description];
}
