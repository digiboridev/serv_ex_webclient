import 'dart:convert';
import 'package:equatable/equatable.dart';

class RSCategory extends Equatable {
  final String id;
  final String name;

  /// If null, then this is a top-level category else it is a subcategory of the parent category
  final String? parentId;
  const RSCategory({
    required this.id,
    required this.name,
    this.parentId,
  });

  RSCategory copyWith({
    String? id,
    String? name,
    String? parentId,
  }) {
    return RSCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      parentId: parentId ?? this.parentId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'parentId': parentId,
    };
  }

  factory RSCategory.fromMap(Map<String, dynamic> map) {
    return RSCategory(
      id: map['id'] as String,
      name: map['name'] as String,
      parentId: map['parentId'] != null ? map['parentId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RSCategory.fromJson(String source) => RSCategory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, name, parentId ?? 0];
}
