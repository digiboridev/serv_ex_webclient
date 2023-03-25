import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/sign.dart';

class RSOrderClosedDetails extends Equatable {
  final String employeeId;
  final RSOrderSign signnature;

  const RSOrderClosedDetails({
    required this.employeeId,
    required this.signnature,
  });

  RSOrderClosedDetails copyWith({
    String? employeeId,
    RSOrderSign? signnature,
  }) {
    return RSOrderClosedDetails(
      employeeId: employeeId ?? this.employeeId,
      signnature: signnature ?? this.signnature,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'employeeId': employeeId,
      'signnature': signnature.toMap(),
    };
  }

  factory RSOrderClosedDetails.fromMap(Map<String, dynamic> map) {
    return RSOrderClosedDetails(
      employeeId: map['employeeId'] as String,
      signnature: RSOrderSign.fromMap(map['signnature'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory RSOrderClosedDetails.fromJson(String source) => RSOrderClosedDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [employeeId, signnature];
}
