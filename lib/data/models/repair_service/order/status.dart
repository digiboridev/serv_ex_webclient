// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:serv_expert_webclient/data/models/repair_service/order/repair_part.dart';

enum RSOrderStatus {
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

class RSOrderStatusesDetails extends Equatable {
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
  const RSOrderStatusesDetails({
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

  RSOrderStatusesDetails copyWith({
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
    return RSOrderStatusesDetails(
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
      'acceptedDetails': acceptedDetails?.toMap(),
      'onDiagnosticDetails': onDiagnosticDetails?.toMap(),
      'offerCreatedDetails': offerCreatedDetails?.toMap(),
      'confirmedOfferDetails': confirmedOfferDetails?.toMap(),
      'declinedOfferDetails': declinedOfferDetails?.toMap(),
      'waitingForPartsDetails': waitingForPartsDetails?.toMap(),
      'inProgressDetails': inProgressDetails?.toMap(),
      'workFinishedDetails': workFinishedDetails?.toMap(),
      'closedDetails': closedDetails?.toMap(),
      'canceledDetails': cancellDetails?.toMap(),
    };
  }

  factory RSOrderStatusesDetails.fromMap(Map<String, dynamic> map) {
    return RSOrderStatusesDetails(
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
      offerCreatedDetails ?? '',
      confirmedOfferDetails ?? '',
      declinedOfferDetails ?? '',
      waitingForPartsDetails ?? '',
      inProgressDetails ?? '',
      workFinishedDetails ?? '',
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

// Confimed offer details

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

// Declined offer details
class RSOrderDeclinedOfferDetails extends Equatable {
  final bool afterDiagnostic;

  const RSOrderDeclinedOfferDetails({
    required this.afterDiagnostic,
  });

  RSOrderDeclinedOfferDetails copyWith({
    bool? afterDiagnostic,
  }) {
    return RSOrderDeclinedOfferDetails(
      afterDiagnostic: afterDiagnostic ?? this.afterDiagnostic,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'afterDiagnostic': afterDiagnostic,
    };
  }

  factory RSOrderDeclinedOfferDetails.fromMap(Map<String, dynamic> map) {
    return RSOrderDeclinedOfferDetails(
      afterDiagnostic: map['afterDiagnostic'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory RSOrderDeclinedOfferDetails.fromJson(String source) => RSOrderDeclinedOfferDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [afterDiagnostic];
}

// Waiting for parts

class RSOrderWaitingForPartsDetails extends Equatable {
  final String employeeId;
  const RSOrderWaitingForPartsDetails({
    required this.employeeId,
  });

  RSOrderWaitingForPartsDetails copyWith({
    String? employeeId,
  }) {
    return RSOrderWaitingForPartsDetails(
      employeeId: employeeId ?? this.employeeId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'employeeId': employeeId,
    };
  }

  factory RSOrderWaitingForPartsDetails.fromMap(Map<String, dynamic> map) {
    return RSOrderWaitingForPartsDetails(
      employeeId: map['employeeId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RSOrderWaitingForPartsDetails.fromJson(String source) => RSOrderWaitingForPartsDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [employeeId];
}

// In progress

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

// Finished details

enum FinishedAfterType {
  diagnistic,
  offer,
}

class RSOrderSign extends Equatable {
  final String namePath;
  final String signPath;
  const RSOrderSign({
    required this.namePath,
    required this.signPath,
  });

  RSOrderSign copyWith({
    String? namePath,
    String? signPath,
  }) {
    return RSOrderSign(
      namePath: namePath ?? this.namePath,
      signPath: signPath ?? this.signPath,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'namePath': namePath,
      'signPath': signPath,
    };
  }

  factory RSOrderSign.fromMap(Map<String, dynamic> map) {
    return RSOrderSign(
      namePath: map['namePath'] as String,
      signPath: map['signPath'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RSOrderSign.fromJson(String source) => RSOrderSign.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [namePath, signPath];
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

// Closed details

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
