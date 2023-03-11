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
  final RSOrderAcceptDetails? acceptedDetails;
  final String? onDiagnosticDetails;
  final String? offerSentDetails;
  final String? offerAcceptedDetails;
  final String? waitingForPartsDetails;
  final String? inProgressDetails;
  final String? closedSuscessfullyDetails;
  final String? closedByOfferRejectedDetails;
  final String? closedWithoutRepairDetails;
  final RSOCancellDetails? cancellDetails;
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
    this.cancellDetails,
  });

  RSOrderStatusesDetails copyWith({
    RSOrderAcceptDetails? acceptedDetails,
    String? onDiagnosticDetails,
    String? offerSentDetails,
    String? offerAcceptedDetails,
    String? waitingForPartsDetails,
    String? inProgressDetails,
    String? closedSuscessfullyDetails,
    String? closedByOfferRejectedDetails,
    String? closedWithoutRepairDetails,
    RSOCancellDetails? cancellDetails,
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
      cancellDetails: cancellDetails ?? this.cancellDetails,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'acceptedDetails': acceptedDetails?.toMap(),
      'onDiagnosticDetails': onDiagnosticDetails,
      'offerSentDetails': offerSentDetails,
      'offerAcceptedDetails': offerAcceptedDetails,
      'waitingForPartsDetails': waitingForPartsDetails,
      'inProgressDetails': inProgressDetails,
      'closedSuscessfullyDetails': closedSuscessfullyDetails,
      'closedByOfferRejectedDetails': closedByOfferRejectedDetails,
      'closedWithoutRepairDetails': closedWithoutRepairDetails,
      'canceledDetails': cancellDetails?.toMap(),
    };
  }

  factory RSOrderStatusesDetails.fromMap(Map<String, dynamic> map) {
    return RSOrderStatusesDetails(
      acceptedDetails: map['acceptedDetails'] != null ? RSOrderAcceptDetails.fromMap(map['acceptedDetails'] as Map<String, dynamic>) : null,
      onDiagnosticDetails: map['onDiagnosticDetails'] != null ? map['onDiagnosticDetails'] as String : null,
      offerSentDetails: map['offerSentDetails'] != null ? map['offerSentDetails'] as String : null,
      offerAcceptedDetails: map['offerAcceptedDetails'] != null ? map['offerAcceptedDetails'] as String : null,
      waitingForPartsDetails: map['waitingForPartsDetails'] != null ? map['waitingForPartsDetails'] as String : null,
      inProgressDetails: map['inProgressDetails'] != null ? map['inProgressDetails'] as String : null,
      closedSuscessfullyDetails: map['closedSuscessfullyDetails'] != null ? map['closedSuscessfullyDetails'] as String : null,
      closedByOfferRejectedDetails: map['closedByOfferRejectedDetails'] != null ? map['closedByOfferRejectedDetails'] as String : null,
      closedWithoutRepairDetails: map['closedWithoutRepairDetails'] != null ? map['closedWithoutRepairDetails'] as String : null,
      cancellDetails: map['canceledDetails'] != null ? RSOCancellDetails.fromMap(map['canceledDetails'] as Map<String, dynamic>) : null,
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
      cancellDetails ?? '',
    ];
  }
}

// Order Accept Details

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

// Order Cancellation Details

enum RSOCancellationReasons {
  notAvailable,
  notInterested,
  notWorking,
  notWorthRepair,
  other,
}

enum RSOCancelledActor {
  customer,
  employee,
}

class RSOCancellDetails extends Equatable {
  RSOCancellDetails({
    required this.reason,
    this.description = '',
    required this.actor,
    this.employeeId = '',
  })  : assert(!(reason == RSOCancellationReasons.other && description.isEmpty)),
        assert(!(actor == RSOCancelledActor.employee && employeeId.isEmpty));

  /// The reason for cancellation
  final RSOCancellationReasons reason;

  /// The description of the cancellation reason, if the reason is [RSOCancellationReasons.other] then this field is required
  final String description;

  /// The actor who cancelled the order, if its [RSOCancelledActor.employee] then the [employeeId] is required
  final RSOCancelledActor actor;

  /// The id of the employee who cancelled the order
  final String employeeId;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'reason': reason.name,
      'description': description,
      'actor': actor.name,
      'employeeId': employeeId,
    };
  }

  factory RSOCancellDetails.fromMap(Map<String, dynamic> map) {
    return RSOCancellDetails(
      reason: RSOCancellationReasons.values.byName(map['reason'] as String),
      description: map['description'] as String,
      actor: RSOCancelledActor.values.byName(map['actor'] as String),
      employeeId: map['employeeId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RSOCancellDetails.fromJson(String source) => RSOCancellDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object> get props => [reason, description, actor, employeeId];
}
