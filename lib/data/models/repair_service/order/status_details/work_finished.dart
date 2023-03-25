import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/sign.dart';

enum FinishedAfterType {
  diagnistic,
  offer,
}

class RSOrderWorkFinishedDetails extends Equatable {
  final String? employeeId;
  final FinishedAfterType finishedAfter;
  final bool paymentRequired;
  final bool signRequested;
  final RSOrderSign? signnature;
  const RSOrderWorkFinishedDetails({
    this.employeeId,
    required this.finishedAfter,
    required this.paymentRequired,
    required this.signRequested,
    this.signnature,
  });

  RSOrderWorkFinishedDetails copyWith({
    String? employeeId,
    FinishedAfterType? finishedAfter,
    bool? paymentRequired,
    bool? signRequested,
    RSOrderSign? signnature,
  }) {
    return RSOrderWorkFinishedDetails(
      employeeId: employeeId ?? this.employeeId,
      finishedAfter: finishedAfter ?? this.finishedAfter,
      paymentRequired: paymentRequired ?? this.paymentRequired,
      signRequested: signRequested ?? this.signRequested,
      signnature: signnature ?? this.signnature,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'employeeId': employeeId,
      'finishedAfter': finishedAfter.name,
      'paymentRequired': paymentRequired,
      'signRequested': signRequested,
      'signnature': signnature?.toMap(),
    };
  }

  factory RSOrderWorkFinishedDetails.fromMap(Map<String, dynamic> map) {
    return RSOrderWorkFinishedDetails(
      employeeId: map['employeeId'] != null ? map['employeeId'] as String : null,
      finishedAfter: FinishedAfterType.values.byName(map['finishedAfter'] as String),
      paymentRequired: map['paymentRequired'] as bool,
      signRequested: map['signRequested'] as bool,
      signnature: map['signnature'] != null ? RSOrderSign.fromMap(map['signnature'] as Map<String, dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RSOrderWorkFinishedDetails.fromJson(String source) => RSOrderWorkFinishedDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      employeeId ?? 0,
      finishedAfter,
      paymentRequired,
      signRequested,
      signnature ?? 0,
    ];
  }
}
