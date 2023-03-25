import 'dart:convert';
import 'package:equatable/equatable.dart';

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
