// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:serv_expert_webclient/data/models/user/user_contact.dart';

class AppUser extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final List<AppUserContact> contacts;
  AppUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    List<AppUserContact>? contacts,
  }) : contacts = contacts ?? [];

  AppUser copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? phone,
    String? email,
    List<AppUserContact>? contacts,
  }) {
    return AppUser(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      contacts: contacts ?? this.contacts,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'email': email,
      'contacts': contacts.map((x) => x.toMap()).toList(),
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      contacts: List<AppUserContact>.from(map['contacts'].map((x) => AppUserContact.fromMap(x as Map<String, dynamic>))),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) => AppUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      firstName,
      lastName,
      phone,
      email,
      contacts,
    ];
  }
}
