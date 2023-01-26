import 'dart:convert';
import 'package:equatable/equatable.dart';

class ClientContact extends Equatable {
  final String firstName;
  final String lastName;
  final String phone;
  const ClientContact({
    required this.firstName,
    required this.lastName,
    required this.phone,
  });

  ClientContact copyWith({
    String? firstName,
    String? lastName,
    String? phone,
  }) {
    return ClientContact(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
    };
  }

  factory ClientContact.fromMap(Map<String, dynamic> map) {
    return ClientContact(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      phone: map['phone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientContact.fromJson(String source) => ClientContact.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [firstName, lastName, phone];
}
