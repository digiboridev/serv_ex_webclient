// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String name;
  final String imageUri;

  /// If null, then this is a top-level category else it is a subcategory of the parent category
  final String? parentId;
  const Category({
    required this.id,
    required this.name,
    required this.imageUri,
    this.parentId,
  });

  Category copyWith({
    String? id,
    String? name,
    String? imageUri,
    String? parentId,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUri: imageUri ?? this.imageUri,
      parentId: parentId ?? this.parentId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'imageUri': imageUri,
      'parentId': parentId,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as String,
      name: map['name'] as String,
      imageUri: map['imageUri'] == null
          ? 'https://firebasestorage.googleapis.com/v0/b/serv-expert.appspot.com/o/rs_categories%2Fmonitor.png?alt=media&token=e0d5d2da-5701-46f3-bbfb-83a7a5aa622f'
          : map['imageUri'] as String,
      parentId: map['parentId'] != null ? map['parentId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) => Category.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      imageUri,
      parentId ?? 0,
    ];
  }
}
