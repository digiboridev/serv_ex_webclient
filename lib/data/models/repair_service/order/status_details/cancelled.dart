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
