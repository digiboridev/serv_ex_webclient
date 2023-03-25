import 'dart:convert';
import 'package:equatable/equatable.dart';

class RSOrderInProgressDetails extends Equatable {
  final String employeeId;
  const RSOrderInProgressDetails({
    required this.employeeId,
  });

  RSOrderInProgressDetails copyWith({
    String? employeeId,
  }) {
    return RSOrderInProgressDetails(
      employeeId: employeeId ?? this.employeeId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'employeeId': employeeId,
    };
  }

  factory RSOrderInProgressDetails.fromMap(Map<String, dynamic> map) {
    return RSOrderInProgressDetails(
      employeeId: map['employeeId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RSOrderInProgressDetails.fromJson(String source) => RSOrderInProgressDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [employeeId];
}
