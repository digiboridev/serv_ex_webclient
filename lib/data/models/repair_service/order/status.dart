// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/status_details/accepted.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/status_details/cancelled.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/status_details/closed.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/status_details/confirmed_offer.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/status_details/declined_offer.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/status_details/in_progress.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/status_details/offer_created.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/status_details/on_diagnostic.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/status_details/waiting_for_parts.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/status_details/work_finished.dart';

enum RSOStatusType {
  newOrder,
  accepted,
  onDiagnostic,
  offerCreated,
  confirmedOffer,
  declinedOffer,
  waitingForParts,
  inProgress,
  workFinished,
  closed,
  canceled,
}

class RSOStatus extends Equatable {
  final RSOStatusType currentStatus;
  final RSOrderAcceptDetails? acceptedDetails;
  final RSOrderDiagnosticDetails? onDiagnosticDetails;
  final RSOrderOfferCreatedDetails? offerCreatedDetails;
  final RSOrderConfirmedOfferDetails? confirmedOfferDetails;
  final RSOrderDeclinedOfferDetails? declinedOfferDetails;
  final RSOrderWaitingForPartsDetails? waitingForPartsDetails;
  final RSOrderInProgressDetails? inProgressDetails;
  final RSOrderWorkFinishedDetails? workFinishedDetails;
  final RSOrderClosedDetails? closedDetails;
  final RSOCancellDetails? cancellDetails;
  const RSOStatus({
    required this.currentStatus,
    this.acceptedDetails,
    this.onDiagnosticDetails,
    this.offerCreatedDetails,
    this.confirmedOfferDetails,
    this.declinedOfferDetails,
    this.waitingForPartsDetails,
    this.inProgressDetails,
    this.workFinishedDetails,
    this.closedDetails,
    this.cancellDetails,
  });

  RSOStatus copyWith({
    RSOStatusType? currentStatus,
    RSOrderAcceptDetails? acceptedDetails,
    RSOrderDiagnosticDetails? onDiagnosticDetails,
    RSOrderOfferCreatedDetails? offerCreatedDetails,
    RSOrderConfirmedOfferDetails? confirmedOfferDetails,
    RSOrderDeclinedOfferDetails? declinedOfferDetails,
    RSOrderWaitingForPartsDetails? waitingForPartsDetails,
    RSOrderInProgressDetails? inProgressDetails,
    RSOrderWorkFinishedDetails? workFinishedDetails,
    RSOrderClosedDetails? closedDetails,
    RSOCancellDetails? cancellDetails,
  }) {
    return RSOStatus(
      currentStatus: currentStatus ?? this.currentStatus,
      acceptedDetails: acceptedDetails ?? this.acceptedDetails,
      onDiagnosticDetails: onDiagnosticDetails ?? this.onDiagnosticDetails,
      offerCreatedDetails: offerCreatedDetails ?? this.offerCreatedDetails,
      confirmedOfferDetails: confirmedOfferDetails ?? this.confirmedOfferDetails,
      declinedOfferDetails: declinedOfferDetails ?? this.declinedOfferDetails,
      waitingForPartsDetails: waitingForPartsDetails ?? this.waitingForPartsDetails,
      inProgressDetails: inProgressDetails ?? this.inProgressDetails,
      workFinishedDetails: workFinishedDetails ?? this.workFinishedDetails,
      closedDetails: closedDetails ?? this.closedDetails,
      cancellDetails: cancellDetails ?? this.cancellDetails,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentStatus': currentStatus.name,
      'acceptedDetails': acceptedDetails?.toMap(),
      'onDiagnosticDetails': onDiagnosticDetails?.toMap(),
      'offerCreatedDetails': offerCreatedDetails?.toMap(),
      'confirmedOfferDetails': confirmedOfferDetails?.toMap(),
      'declinedOfferDetails': declinedOfferDetails?.toMap(),
      'waitingForPartsDetails': waitingForPartsDetails?.toMap(),
      'inProgressDetails': inProgressDetails?.toMap(),
      'workFinishedDetails': workFinishedDetails?.toMap(),
      'closedDetails': closedDetails?.toMap(),
      'cancellDetails': cancellDetails?.toMap(),
    };
  }

  factory RSOStatus.fromMap(Map<String, dynamic> map) {
    return RSOStatus(
      currentStatus: RSOStatusType.values.byName(map['currentStatus'] as String),
      acceptedDetails: map['acceptedDetails'] != null ? RSOrderAcceptDetails.fromMap(map['acceptedDetails'] as Map<String, dynamic>) : null,
      onDiagnosticDetails: map['onDiagnosticDetails'] != null ? RSOrderDiagnosticDetails.fromMap(map['onDiagnosticDetails'] as Map<String, dynamic>) : null,
      offerCreatedDetails: map['offerCreatedDetails'] != null ? RSOrderOfferCreatedDetails.fromMap(map['offerCreatedDetails'] as Map<String, dynamic>) : null,
      confirmedOfferDetails:
          map['confirmedOfferDetails'] != null ? RSOrderConfirmedOfferDetails.fromMap(map['confirmedOfferDetails'] as Map<String, dynamic>) : null,
      declinedOfferDetails:
          map['declinedOfferDetails'] != null ? RSOrderDeclinedOfferDetails.fromMap(map['declinedOfferDetails'] as Map<String, dynamic>) : null,
      waitingForPartsDetails:
          map['waitingForPartsDetails'] != null ? RSOrderWaitingForPartsDetails.fromMap(map['waitingForPartsDetails'] as Map<String, dynamic>) : null,
      inProgressDetails: map['inProgressDetails'] != null ? RSOrderInProgressDetails.fromMap(map['inProgressDetails'] as Map<String, dynamic>) : null,
      workFinishedDetails: map['workFinishedDetails'] != null ? RSOrderWorkFinishedDetails.fromMap(map['workFinishedDetails'] as Map<String, dynamic>) : null,
      closedDetails: map['closedDetails'] != null ? RSOrderClosedDetails.fromMap(map['closedDetails'] as Map<String, dynamic>) : null,
      cancellDetails: map['cancellDetails'] != null ? RSOCancellDetails.fromMap(map['cancellDetails'] as Map<String, dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RSOStatus.fromJson(String source) => RSOStatus.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      currentStatus,
      acceptedDetails ?? 0,
      onDiagnosticDetails ?? 0,
      offerCreatedDetails ?? 0,
      confirmedOfferDetails ?? 0,
      declinedOfferDetails ?? 0,
      waitingForPartsDetails ?? 0,
      inProgressDetails ?? 0,
      workFinishedDetails ?? 0,
      closedDetails ?? 0,
      cancellDetails ?? 0,
    ];
  }
}
