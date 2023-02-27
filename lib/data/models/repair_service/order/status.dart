import 'dart:convert';
import 'package:equatable/equatable.dart';

enum RSOrderStatus {
  newOrder,
  accepted,
  onDiagnostic,
  offerSent,
  offerAccepted,
  waitingForParts,
  inProgress,
  closedSuscessfully,
  closedByOfferRejected,
  closedWithoutRepair,
  canceled,
}

class RSOrderStatusesDetails extends Equatable {
  final String? acceptedDetails;
  final String? onDiagnosticDetails;
  final String? offerSentDetails;
  final String? offerAcceptedDetails;
  final String? waitingForPartsDetails;
  final String? inProgressDetails;
  final String? closedSuscessfullyDetails;
  final String? closedByOfferRejectedDetails;
  final String? closedWithoutRepairDetails;
  final String? canceledDetails;
  const RSOrderStatusesDetails({
    this.acceptedDetails,
    this.onDiagnosticDetails,
    this.offerSentDetails,
    this.offerAcceptedDetails,
    this.waitingForPartsDetails,
    this.inProgressDetails,
    this.closedSuscessfullyDetails,
    this.closedByOfferRejectedDetails,
    this.closedWithoutRepairDetails,
    this.canceledDetails,
  });

  RSOrderStatusesDetails copyWith({
    String? acceptedDetails,
    String? onDiagnosticDetails,
    String? offerSentDetails,
    String? offerAcceptedDetails,
    String? waitingForPartsDetails,
    String? inProgressDetails,
    String? closedSuscessfullyDetails,
    String? closedByOfferRejectedDetails,
    String? closedWithoutRepairDetails,
    String? canceledDetails,
  }) {
    return RSOrderStatusesDetails(
      acceptedDetails: acceptedDetails ?? this.acceptedDetails,
      onDiagnosticDetails: onDiagnosticDetails ?? this.onDiagnosticDetails,
      offerSentDetails: offerSentDetails ?? this.offerSentDetails,
      offerAcceptedDetails: offerAcceptedDetails ?? this.offerAcceptedDetails,
      waitingForPartsDetails: waitingForPartsDetails ?? this.waitingForPartsDetails,
      inProgressDetails: inProgressDetails ?? this.inProgressDetails,
      closedSuscessfullyDetails: closedSuscessfullyDetails ?? this.closedSuscessfullyDetails,
      closedByOfferRejectedDetails: closedByOfferRejectedDetails ?? this.closedByOfferRejectedDetails,
      closedWithoutRepairDetails: closedWithoutRepairDetails ?? this.closedWithoutRepairDetails,
      canceledDetails: canceledDetails ?? this.canceledDetails,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'acceptedDetails': acceptedDetails,
      'onDiagnosticDetails': onDiagnosticDetails,
      'offerSentDetails': offerSentDetails,
      'offerAcceptedDetails': offerAcceptedDetails,
      'waitingForPartsDetails': waitingForPartsDetails,
      'inProgressDetails': inProgressDetails,
      'closedSuscessfullyDetails': closedSuscessfullyDetails,
      'closedByOfferRejectedDetails': closedByOfferRejectedDetails,
      'closedWithoutRepairDetails': closedWithoutRepairDetails,
      'canceledDetails': canceledDetails,
    };
  }

  factory RSOrderStatusesDetails.fromMap(Map<String, dynamic> map) {
    return RSOrderStatusesDetails(
      acceptedDetails: map['acceptedDetails'] != null ? map['acceptedDetails'] as String : null,
      onDiagnosticDetails: map['onDiagnosticDetails'] != null ? map['onDiagnosticDetails'] as String : null,
      offerSentDetails: map['offerSentDetails'] != null ? map['offerSentDetails'] as String : null,
      offerAcceptedDetails: map['offerAcceptedDetails'] != null ? map['offerAcceptedDetails'] as String : null,
      waitingForPartsDetails: map['waitingForPartsDetails'] != null ? map['waitingForPartsDetails'] as String : null,
      inProgressDetails: map['inProgressDetails'] != null ? map['inProgressDetails'] as String : null,
      closedSuscessfullyDetails: map['closedSuscessfullyDetails'] != null ? map['closedSuscessfullyDetails'] as String : null,
      closedByOfferRejectedDetails: map['closedByOfferRejectedDetails'] != null ? map['closedByOfferRejectedDetails'] as String : null,
      closedWithoutRepairDetails: map['closedWithoutRepairDetails'] != null ? map['closedWithoutRepairDetails'] as String : null,
      canceledDetails: map['canceledDetails'] != null ? map['canceledDetails'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RSOrderStatusesDetails.fromJson(String source) => RSOrderStatusesDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      acceptedDetails ?? '',
      onDiagnosticDetails ?? '',
      offerSentDetails ?? '',
      offerAcceptedDetails ?? '',
      waitingForPartsDetails ?? '',
      inProgressDetails ?? '',
      closedSuscessfullyDetails ?? '',
      closedByOfferRejectedDetails ?? '',
      closedWithoutRepairDetails ?? '',
      canceledDetails ?? '',
    ];
  }
}
