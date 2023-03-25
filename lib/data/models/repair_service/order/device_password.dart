// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';

abstract class DevicePassword {
  String get type;

  Map<String, dynamic> toMap();

  factory DevicePassword.fromMap(Map<String, dynamic> map) {
    switch (map['type'] as String) {
      case 'pattern':
        return PatternPassword.fromMap(map);
      case 'numeric':
        return NumericPassword.fromMap(map);
      default:
        throw Exception('Unknown type');
    }
  }

  factory DevicePassword.pattern({required int dimensions, required List<int> points}) => PatternPassword(dimensions: dimensions, points: points);
  factory DevicePassword.numeric({required String password}) => NumericPassword(password: password);
}

class PatternPassword extends Equatable implements DevicePassword {
  @override
  final String type;
  final int dimensions;
  final List<int> points;
  const PatternPassword({
    required this.dimensions,
    required this.points,
  }) : type = 'pattern';

  PatternPassword copyWith({
    int? dimensions,
    List<int>? points,
  }) {
    return PatternPassword(
      dimensions: dimensions ?? this.dimensions,
      points: points ?? this.points,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'dimensions': dimensions,
      'points': points,
    };
  }

  factory PatternPassword.fromMap(Map<String, dynamic> map) {
    return PatternPassword(
      dimensions: map['dimensions'] as int,
      points: List<int>.from((map['points'] as List)),
    );
  }

  String toJson() => json.encode(toMap());

  factory PatternPassword.fromJson(String source) => PatternPassword.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [type, dimensions, points];
}

class NumericPassword extends Equatable implements DevicePassword {
  @override
  final String type;
  final String password;
  const NumericPassword({
    required this.password,
  }) : type = 'numeric';

  NumericPassword copyWith({
    String? password,
  }) {
    return NumericPassword(
      password: password ?? this.password,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'password': password,
    };
  }

  factory NumericPassword.fromMap(Map<String, dynamic> map) {
    return NumericPassword(
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NumericPassword.fromJson(String source) => NumericPassword.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [type, password];
}
