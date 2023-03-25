import 'dart:convert';
import 'package:equatable/equatable.dart';

class RSOrderSign extends Equatable {
  final String namePath;
  final String signPath;
  const RSOrderSign({
    required this.namePath,
    required this.signPath,
  });

  RSOrderSign copyWith({
    String? namePath,
    String? signPath,
  }) {
    return RSOrderSign(
      namePath: namePath ?? this.namePath,
      signPath: signPath ?? this.signPath,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'namePath': namePath,
      'signPath': signPath,
    };
  }

  factory RSOrderSign.fromMap(Map<String, dynamic> map) {
    return RSOrderSign(
      namePath: map['namePath'] as String,
      signPath: map['signPath'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RSOrderSign.fromJson(String source) => RSOrderSign.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [namePath, signPath];
}
