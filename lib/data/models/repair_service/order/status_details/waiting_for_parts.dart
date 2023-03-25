import 'dart:convert';
import 'package:equatable/equatable.dart';

class RSOrderWaitingForPartsDetails extends Equatable {
  final String employeeId;
  const RSOrderWaitingForPartsDetails({
    required this.employeeId,
  });

  RSOrderWaitingForPartsDetails copyWith({
    String? employeeId,
  }) {
    return RSOrderWaitingForPartsDetails(
      employeeId: employeeId ?? this.employeeId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'employeeId': employeeId,
    };
  }

  factory RSOrderWaitingForPartsDetails.fromMap(Map<String, dynamic> map) {
    return RSOrderWaitingForPartsDetails(
      employeeId: map['employeeId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RSOrderWaitingForPartsDetails.fromJson(String source) => RSOrderWaitingForPartsDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [employeeId];
}
