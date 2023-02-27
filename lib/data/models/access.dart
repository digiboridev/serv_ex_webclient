// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

enum PermissionType {
  onwer,
  employee,
}

class Access extends Equatable {
  final List<String> membersIds;
  final List<Permission> permissions;
  const Access({
    required this.membersIds,
    required this.permissions,
  });

  /// This is a factory constructor, it returns a new instance of this class
  factory Access.blank() => const Access(membersIds: [], permissions: []);

  /// Check if a member is in the access list
  bool isMember(String memberId) => membersIds.contains(memberId);

  /// Get the permission type of a member
  PermissionType getPermissionType(String memberId) {
    if (isMember(memberId)) {
      return permissions.firstWhere((element) => element.memberId == memberId).type;
    } else {
      throw Exception('Member not found');
    }
  }

  /// Add a new member to the access list
  Access addMember(String memberId, PermissionType type) {
    if (isMember(memberId)) {
      throw Exception('Member already exists');
    } else {
      return copyWith(
        membersIds: [...membersIds, memberId],
        permissions: [...permissions, Permission(memberId: memberId, type: type)],
      );
    }
  }

  /// Remove a member from the access list
  Access removeMember(String memberId) {
    if (isMember(memberId)) {
      return copyWith(
        membersIds: membersIds.where((element) => element != memberId).toList(),
        permissions: permissions.where((element) => element.memberId != memberId).toList(),
      );
    } else {
      throw Exception('Member not found');
    }
  }

  /// Update the permission type of a member
  Access updateMember(String memberId, PermissionType type) {
    if (isMember(memberId)) {
      return copyWith(
        permissions: permissions.map((e) => e.memberId == memberId ? e.copyWith(type: type) : e).toList(),
      );
    } else {
      throw Exception('Member not found');
    }
  }

  Access copyWith({
    List<String>? membersIds,
    List<Permission>? permissions,
  }) {
    return Access(
      membersIds: membersIds ?? this.membersIds,
      permissions: permissions ?? this.permissions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'membersIds': membersIds,
      'permissions': permissions.map((x) => x.toMap()).toList(),
    };
  }

  factory Access.fromMap(Map<String, dynamic> map) {
    return Access(
      membersIds: List<String>.from(map['membersIds']),
      permissions: List<Permission>.from(
        (map['permissions'] as List).map<Permission>(
          (x) => Permission.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Access.fromJson(String source) => Access.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [membersIds, permissions];
}

class Permission extends Equatable {
  final String memberId;
  final PermissionType type;
  const Permission({
    required this.memberId,
    required this.type,
  });

  Permission copyWith({
    String? memberId,
    PermissionType? type,
  }) {
    return Permission(
      memberId: memberId ?? this.memberId,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'memberId': memberId,
      'type': type.name,
    };
  }

  factory Permission.fromMap(Map<String, dynamic> map) {
    return Permission(
      memberId: map['memberId'] as String,
      type: PermissionType.values.byName(map['type'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Permission.fromJson(String source) => Permission.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [memberId, type];
}
