import 'dart:convert';
import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String name;
  final String imageUri;

  /// If null, then this is a top-level category else it is a subcategory of the parent category
  final String? parent;
  final List<String> issues;
  const Category({
    required this.id,
    required this.name,
    required this.imageUri,
    this.parent,
    this.issues = const [],
  });

  Category copyWith({
    String? id,
    String? name,
    String? imageUri,
    String? parent,
    List<String>? issues,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUri: imageUri ?? this.imageUri,
      parent: parent ?? this.parent,
      issues: issues ?? this.issues,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'imageUri': imageUri,
      'parent': parent,
      'issues': issues,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as String,
      name: map['name'] as String,
      imageUri: map['imageUri'] == null
          ? 'https://firebasestorage.googleapis.com/v0/b/serv-expert.appspot.com/o/rs_categories%2Fmonitor.png?alt=media&token=e0d5d2da-5701-46f3-bbfb-83a7a5aa622f'
          : map['imageUri'] as String,
      parent: map['parent'] != null ? map['parent'] as String : null,
      issues: List<String>.from(map['issues']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) => Category.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, name, parent ?? 0, issues];
}
