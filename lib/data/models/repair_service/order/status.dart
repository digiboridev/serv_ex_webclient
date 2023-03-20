// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:serv_expert_webclient/data/models/repair_service/order/repair_part.dart';

enum RSOrderStatus {
  newOrder,
  accepted,
  onDiagnostic,
  offerSent,
  confirmedOffer,
  waitingForParts,
  inProgress,
  closed,
  canceled,
}

class RSOrderStatusesDetails extends Equatable {
  final RSOrderAcceptDetails? acceptedDetails;
  final RSOrderDiagnosticDetails? onDiagnosticDetails;
  final RSOrderOfferSentDetails? offerSentDetails;
  final RSOrderConfirmedOfferDetails? confirmedOfferDetails;
  final String? waitingForPartsDetails;
  final String? inProgressDetails;
  final String? closedDetails;
  final RSOCancellDetails? cancellDetails;
  const RSOrderStatusesDetails({
    this.acceptedDetails,
    this.onDiagnosticDetails,
    this.offerSentDetails,
    this.confirmedOfferDetails,
    this.waitingForPartsDetails,
    this.inProgressDetails,
    this.closedDetails,
    this.cancellDetails,
  });

  RSOrderStatusesDetails copyWith({
    RSOrderAcceptDetails? acceptedDetails,
    RSOrderDiagnosticDetails? onDiagnosticDetails,
    RSOrderOfferSentDetails? offerSentDetails,
    RSOrderConfirmedOfferDetails? confirmedOfferDetails,
    String? waitingForPartsDetails,
    String? inProgressDetails,
    String? closedDetails,
    RSOCancellDetails? cancellDetails,
  }) {
    return RSOrderStatusesDetails(
      acceptedDetails: acceptedDetails ?? this.acceptedDetails,
      onDiagnosticDetails: onDiagnosticDetails ?? this.onDiagnosticDetails,
      offerSentDetails: offerSentDetails ?? this.offerSentDetails,
      confirmedOfferDetails: confirmedOfferDetails ?? this.confirmedOfferDetails,
      waitingForPartsDetails: waitingForPartsDetails ?? this.waitingForPartsDetails,
      inProgressDetails: inProgressDetails ?? this.inProgressDetails,
      closedDetails: closedDetails ?? this.closedDetails,
      cancellDetails: cancellDetails ?? this.cancellDetails,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'acceptedDetails': acceptedDetails?.toMap(),
      'onDiagnosticDetails': onDiagnosticDetails?.toMap(),
      'offerSentDetails': offerSentDetails?.toMap(),
      'confirmedOfferDetails': confirmedOfferDetails?.toMap(),
      'waitingForPartsDetails': waitingForPartsDetails,
      'inProgressDetails': inProgressDetails,
      'closedDetails': closedDetails,
      'canceledDetails': cancellDetails?.toMap(),
    };
  }

  factory RSOrderStatusesDetails.fromMap(Map<String, dynamic> map) {
    return RSOrderStatusesDetails(
      acceptedDetails: map['acceptedDetails'] != null ? RSOrderAcceptDetails.fromMap(map['acceptedDetails'] as Map<String, dynamic>) : null,
      onDiagnosticDetails: map['onDiagnosticDetails'] != null ? RSOrderDiagnosticDetails.fromMap(map['onDiagnosticDetails'] as Map<String, dynamic>) : null,
      offerSentDetails: map['offerSentDetails'] != null ? RSOrderOfferSentDetails.fromMap(map['offerSentDetails'] as Map<String, dynamic>) : null,
      confirmedOfferDetails:
          map['confirmedOfferDetails'] != null ? RSOrderConfirmedOfferDetails.fromMap(map['confirmedOfferDetails'] as Map<String, dynamic>) : null,
      waitingForPartsDetails: map['waitingForPartsDetails'] != null ? map['waitingForPartsDetails'] as String : null,
      inProgressDetails: map['inProgressDetails'] != null ? map['inProgressDetails'] as String : null,
      closedDetails: map['closedDetails'] != null ? map['closedDetails'] as String : null,
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
      confirmedOfferDetails ?? '',
      waitingForPartsDetails ?? '',
      inProgressDetails ?? '',
      closedDetails ?? '',
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

// On diagnostic details

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

// Offer sent Details

class RSOrderOfferSentDetails extends Equatable {
  final String employeeId;
  final List<RepairPart> parts;
  final bool paymentRequired;
  final String fantomasName;
  final String noteForClient;
  final String noteForEmployee;
  final bool afterDiagnostic;

  const RSOrderOfferSentDetails({
    required this.employeeId,
    required this.parts,
    required this.paymentRequired,
    required this.fantomasName,
    required this.noteForClient,
    required this.noteForEmployee,
    required this.afterDiagnostic,
  });

  RSOrderOfferSentDetails copyWith({
    String? employeeId,
    List<RepairPart>? parts,
    bool? paymentRequired,
    String? fantomasName,
    String? noteForClient,
    String? noteForEmployee,
    bool? afterDiagnostic,
  }) {
    return RSOrderOfferSentDetails(
      employeeId: employeeId ?? this.employeeId,
      parts: parts ?? this.parts,
      paymentRequired: paymentRequired ?? this.paymentRequired,
      fantomasName: fantomasName ?? this.fantomasName,
      noteForClient: noteForClient ?? this.noteForClient,
      noteForEmployee: noteForEmployee ?? this.noteForEmployee,
      afterDiagnostic: afterDiagnostic ?? this.afterDiagnostic,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'employeeId': employeeId,
      'parts': parts.map((x) => x.toMap()).toList(),
      'paymentRequired': paymentRequired,
      'fantomasName': fantomasName,
      'noteForClient': noteForClient,
      'noteForEmployee': noteForEmployee,
      'afterDiagnostic': afterDiagnostic,
    };
  }

  factory RSOrderOfferSentDetails.fromMap(Map<String, dynamic> map) {
    return RSOrderOfferSentDetails(
      employeeId: map['employeeId'] as String,
      parts: List<RepairPart>.from(
        (map['parts'] as List).map<RepairPart>(
          (x) => RepairPart.fromMap(x as Map<String, dynamic>),
        ),
      ),
      paymentRequired: map['paymentRequired'] as bool,
      fantomasName: map['fantomasName'] as String,
      noteForClient: map['noteForClient'] as String,
      noteForEmployee: map['noteForEmployee'] as String,
      afterDiagnostic: map['afterDiagnostic'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory RSOrderOfferSentDetails.fromJson(String source) => RSOrderOfferSentDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      employeeId,
      parts,
      paymentRequired,
      fantomasName,
      noteForClient,
      noteForEmployee,
      afterDiagnostic,
    ];
  }
}

// Confimed offer details

class RSOrderConfirmedOfferDetails extends Equatable {
  final bool confirmationSkipped;
  final String? employeeId;
  final List<RepairPart> parts;
  final String noteForClient;
  final String noteForEmployee;
  final bool afterDiagnostic;
  final bool paymentRequired;

  const RSOrderConfirmedOfferDetails({
    required this.confirmationSkipped,
    required this.employeeId,
    required this.parts,
    required this.noteForClient,
    required this.noteForEmployee,
    required this.afterDiagnostic,
    required this.paymentRequired,
  });

  RSOrderConfirmedOfferDetails copyWith({
    bool? confirmationSkipped,
    String? employeeId,
    List<RepairPart>? parts,
    String? noteForClient,
    String? noteForEmployee,
    bool? afterDiagnostic,
    bool? paymentRequired,
  }) {
    return RSOrderConfirmedOfferDetails(
      confirmationSkipped: confirmationSkipped ?? this.confirmationSkipped,
      employeeId: employeeId ?? this.employeeId,
      parts: parts ?? this.parts,
      noteForClient: noteForClient ?? this.noteForClient,
      noteForEmployee: noteForEmployee ?? this.noteForEmployee,
      afterDiagnostic: afterDiagnostic ?? this.afterDiagnostic,
      paymentRequired: paymentRequired ?? this.paymentRequired,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'confirmationSkipped': confirmationSkipped,
      'employeeId': employeeId,
      'parts': parts.map((x) => x.toMap()).toList(),
      'noteForClient': noteForClient,
      'noteForEmployee': noteForEmployee,
      'afterDiagnostic': afterDiagnostic,
      'paymentRequired': paymentRequired,
    };
  }

  factory RSOrderConfirmedOfferDetails.fromMap(Map<String, dynamic> map) {
    return RSOrderConfirmedOfferDetails(
      confirmationSkipped: map['confirmationSkipped'] as bool,
      employeeId: map['employeeId'] != null ? map['employeeId'] as String : null,
      parts: List<RepairPart>.from(
        (map['parts'] as List).map<RepairPart>(
          (x) => RepairPart.fromMap(x as Map<String, dynamic>),
        ),
      ),
      noteForClient: map['noteForClient'] as String,
      noteForEmployee: map['noteForEmployee'] as String,
      afterDiagnostic: map['afterDiagnostic'] as bool,
      paymentRequired: map['paymentRequired'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory RSOrderConfirmedOfferDetails.fromJson(String source) => RSOrderConfirmedOfferDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      confirmationSkipped,
      employeeId ?? 0,
      parts,
      noteForClient,
      noteForEmployee,
      afterDiagnostic,
      paymentRequired,
    ];
  }
}
