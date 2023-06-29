// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';

class Company extends Equatable {
  final String id;
  final String publicId;
  final String name;
  final String email;
  // final List<String> membersIds;
  const Company({
    required this.id,
    required this.publicId,
    required this.name,
    required this.email,
    // required this.membersIds,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'publicId': publicId,
      'name': name,
      'email': email,
      // 'membersIds': membersIds,
    };
  }

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
      id: map['id'] as String,
      publicId: map['publicId'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      // membersIds: List<String>.from((map['membersIds'])),
    );
  }

  String toJson() => json.encode(toMap());

  factory Company.fromJson(String source) => Company.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      publicId,
      name,
      email,
      // membersIds,
    ];
  }
}
