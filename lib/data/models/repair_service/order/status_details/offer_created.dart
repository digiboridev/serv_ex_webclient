import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/repair_part.dart';

class RSOrderOfferCreatedDetails extends Equatable {
  final String employeeId;
  final String employeeNick;
  final List<RepairPart> parts;
  final bool confirmationRequired;
  final bool withPayment;
  final bool prepayRequired;
  final String noteForClient;
  final String noteForEmployee;
  final bool afterDiagnostic;

  const RSOrderOfferCreatedDetails({
    required this.employeeId,
    required this.employeeNick,
    required this.parts,
    required this.confirmationRequired,
    required this.withPayment,
    required this.prepayRequired,
    required this.noteForClient,
    required this.noteForEmployee,
    required this.afterDiagnostic,
  });

  RSOrderOfferCreatedDetails copyWith({
    String? employeeId,
    String? employeeNick,
    List<RepairPart>? parts,
    bool? confirmationRequired,
    bool? withPayment,
    bool? prepayRequired,
    String? noteForClient,
    String? noteForEmployee,
    bool? afterDiagnostic,
  }) {
    return RSOrderOfferCreatedDetails(
      employeeId: employeeId ?? this.employeeId,
      employeeNick: employeeNick ?? this.employeeNick,
      parts: parts ?? this.parts,
      confirmationRequired: confirmationRequired ?? this.confirmationRequired,
      withPayment: withPayment ?? this.withPayment,
      prepayRequired: prepayRequired ?? this.prepayRequired,
      noteForClient: noteForClient ?? this.noteForClient,
      noteForEmployee: noteForEmployee ?? this.noteForEmployee,
      afterDiagnostic: afterDiagnostic ?? this.afterDiagnostic,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'employeeId': employeeId,
      'employeeNick': employeeNick,
      'parts': parts.map((x) => x.toMap()).toList(),
      'confirmationRequired': confirmationRequired,
      'withPayment': withPayment,
      'prepayRequired': prepayRequired,
      'noteForClient': noteForClient,
      'noteForEmployee': noteForEmployee,
      'afterDiagnostic': afterDiagnostic,
    };
  }

  factory RSOrderOfferCreatedDetails.fromMap(Map<String, dynamic> map) {
    return RSOrderOfferCreatedDetails(
      employeeId: map['employeeId'] as String,
      employeeNick: map['employeeNick'] as String,
      parts: List<RepairPart>.from(
        (map['parts'] as List).map<RepairPart>(
          (x) => RepairPart.fromMap(x as Map<String, dynamic>),
        ),
      ),
      confirmationRequired: map['confirmationRequired'] as bool,
      withPayment: map['withPayment'] as bool,
      prepayRequired: map['prepayRequired'] as bool,
      noteForClient: map['noteForClient'] as String,
      noteForEmployee: map['noteForEmployee'] as String,
      afterDiagnostic: map['afterDiagnostic'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory RSOrderOfferCreatedDetails.fromJson(String source) => RSOrderOfferCreatedDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      employeeId,
      employeeNick,
      parts,
      confirmationRequired,
      withPayment,
      prepayRequired,
      noteForClient,
      noteForEmployee,
      afterDiagnostic,
    ];
  }
}
