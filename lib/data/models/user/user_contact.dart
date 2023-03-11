import 'dart:convert';
import 'package:equatable/equatable.dart';

class AppUserContact extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String phone;
  const AppUserContact({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
    };
  }

  factory AppUserContact.fromMap(Map<String, dynamic> map) {
    return AppUserContact(
      id: map['id'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      phone: map['phone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUserContact.fromJson(String source) => AppUserContact.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, firstName, lastName, phone];
}
