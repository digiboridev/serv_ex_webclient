// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

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
  const RSOCancellDetails({
    required this.reason,
    this.description,
    required this.actor,
    this.employeeId,
  })  : assert(!(reason == RSOCancellationReasons.other && description == null)),
        assert(!(actor == RSOCancelledActor.employee && employeeId == null));

  /// The reason for cancellation
  final RSOCancellationReasons reason;

  /// The description of the cancellation reason, if the reason is [RSOCancellationReasons.other] then this field is required
  final String? description;

  /// The actor who cancelled the order, if its [RSOCancelledActor.employee] then the [employeeId] is required
  final RSOCancelledActor actor;

  /// The id of the employee who cancelled the order
  final String? employeeId;

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
      description: map['description'] != null ? map['description'] as String : null,
      actor: RSOCancelledActor.values.byName(map['actor'] as String),
      employeeId: map['employeeId'] != null ? map['employeeId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RSOCancellDetails.fromJson(String source) => RSOCancellDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object> get props => [reason, description ?? 0, actor, employeeId ?? 0];

  RSOCancellDetails copyWith({
    RSOCancellationReasons? reason,
    String? description,
    RSOCancelledActor? actor,
    String? employeeId,
  }) {
    return RSOCancellDetails(
      reason: reason ?? this.reason,
      description: description ?? this.description,
      actor: actor ?? this.actor,
      employeeId: employeeId ?? this.employeeId,
    );
  }

  @override
  bool get stringify => true;
}
