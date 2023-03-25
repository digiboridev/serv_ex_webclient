import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/repair_part.dart';

class RSOrderConfirmedOfferDetails extends Equatable {
  final bool confirmationSkipped;
  final List<RepairPart> parts;

  const RSOrderConfirmedOfferDetails({
    required this.confirmationSkipped,
    required this.parts,
  });

  RSOrderConfirmedOfferDetails copyWith({
    bool? confirmationSkipped,
    List<RepairPart>? parts,
  }) {
    return RSOrderConfirmedOfferDetails(
      confirmationSkipped: confirmationSkipped ?? this.confirmationSkipped,
      parts: parts ?? this.parts,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'confirmationSkipped': confirmationSkipped,
      'parts': parts.map((x) => x.toMap()).toList(),
    };
  }

  factory RSOrderConfirmedOfferDetails.fromMap(Map<String, dynamic> map) {
    return RSOrderConfirmedOfferDetails(
      confirmationSkipped: map['confirmationSkipped'] as bool,
      parts: List<RepairPart>.from(
        (map['parts'] as List).map<RepairPart>(
          (x) => RepairPart.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory RSOrderConfirmedOfferDetails.fromJson(String source) => RSOrderConfirmedOfferDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [confirmationSkipped, parts];
}
