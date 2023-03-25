import 'dart:convert';
import 'package:equatable/equatable.dart';

class RSOrderDiagnosticDetails extends Equatable {
  final String employeeId;
  const RSOrderDiagnosticDetails({
    required this.employeeId,
  });

  RSOrderDiagnosticDetails copyWith({
    String? employeeId,
  }) {
    return RSOrderDiagnosticDetails(
      employeeId: employeeId ?? this.employeeId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'employeeId': employeeId,
    };
  }

  factory RSOrderDiagnosticDetails.fromMap(Map<String, dynamic> map) {
    return RSOrderDiagnosticDetails(
      employeeId: map['employeeId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RSOrderDiagnosticDetails.fromJson(String source) => RSOrderDiagnosticDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [employeeId];
}
