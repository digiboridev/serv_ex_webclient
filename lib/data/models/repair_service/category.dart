import 'dart:convert';
import 'package:equatable/equatable.dart';

enum RSCType {
  category,
  subcategory,
  option,
}

class RepairServiceCategory extends Equatable {
  final String id;
  final String name;
  final bool global;
  final RSCType type;
  final String? parentId;
  const RepairServiceCategory({
    required this.id,
    required this.name,
    required this.global,
    required this.type,
    this.parentId,
  });

  RepairServiceCategory copyWith({
    String? id,
    String? name,
    bool? global,
    RSCType? type,
    String? parentId,
  }) {
    return RepairServiceCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      global: global ?? this.global,
      type: type ?? this.type,
      parentId: parentId ?? this.parentId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'global': global,
      'type': type.name,
      'parentId': parentId,
    };
  }

  factory RepairServiceCategory.fromMap(Map<String, dynamic> map) {
    return RepairServiceCategory(
      id: map['id'] as String,
      name: map['name'] as String,
      global: map['global'] as bool,
      type: RSCType.values.byName(map['type'] as String),
      parentId: map['parentId'] != null ? map['parentId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RepairServiceCategory.fromJson(String source) => RepairServiceCategory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      global,
      type,
      parentId ?? 0,
    ];
  }
}
