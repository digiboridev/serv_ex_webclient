import 'dart:convert';
import 'package:equatable/equatable.dart';

class RSOrderAcceptDetails extends Equatable {
  final String deviceName;
  final String problemDescription;
  final String conditionDescription;
  final bool diagnosticRequired;
  final String deviceImage;
  final String employeeId;
  const RSOrderAcceptDetails({
    required this.deviceName,
    required this.problemDescription,
    required this.conditionDescription,
    required this.diagnosticRequired,
    required this.deviceImage,
    required this.employeeId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'deviceName': deviceName,
      'problemDescription': problemDescription,
      'conditionDescription': conditionDescription,
      'diagnosticRequired': diagnosticRequired,
      'deviceImage': deviceImage,
      'employeeId': employeeId,
    };
  }

  factory RSOrderAcceptDetails.fromMap(Map<String, dynamic> map) {
    return RSOrderAcceptDetails(
      deviceName: map['deviceName'] as String,
      problemDescription: map['problemDescription'] as String,
      conditionDescription: map['conditionDescription'] as String,
      diagnosticRequired: map['diagnosticRequired'] as bool,
      deviceImage: map['deviceImage'] as String,
      employeeId: map['employeeId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RSOrderAcceptDetails.fromJson(String source) => RSOrderAcceptDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      deviceName,
      problemDescription,
      conditionDescription,
      diagnosticRequired,
      deviceImage,
      employeeId,
    ];
  }
}
