// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class AuthScreenState extends Equatable {
  const AuthScreenState({
    this.busy = false,
    this.error = '',
  });

  /// Marks if screen is busy, and should show progress indicator
  final bool busy;

  /// Marks if non fatal error is thrown, and should show error message
  final String error;

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [busy, error];
}

class ASSLoading extends AuthScreenState {
  const ASSLoading();
}

/// This state is used when fatal exception is thrown during update state, and app asks to retry operation
class ASSUpdateError extends AuthScreenState {
  const ASSUpdateError();
}

/// This state is used when user is not authorized and client needs to choose how to authorize
class ASSUnauthorized extends AuthScreenState {
  const ASSUnauthorized({
    super.busy,
    super.error,
  });
}

/// This state is used for phone auth when client needs to confirm his phone number
class ASSsmsSent extends AuthScreenState {
  const ASSsmsSent({
    super.busy,
    super.error,
    required this.phone,
  });

  final String phone;

  @override
  List<Object> get props => [busy, error, phone];

  ASSsmsSent copyWith({
    bool? busy,
    String? error,
    String? phone,
  }) {
    return ASSsmsSent(
      busy: busy ?? this.busy,
      error: error ?? this.error,
      phone: phone ?? this.phone,
    );
  }
}

/// This state is used when user is authorized and client needs to fill his details
/// (first name, last name, email, phone) is the fields from auth provider, and user cant modify them if its exist
class ASSClientDetails extends AuthScreenState {
  const ASSClientDetails({
    super.busy,
    super.error,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  final String? phone;
  final String? firstName;
  final String? lastName;
  final String? email;

  @override
  List<Object> get props => [busy, error, phone ?? 0, firstName ?? 0, lastName ?? 0, email ?? 0];

  ASSClientDetails copyWith({
    bool? busy,
    String? error,
    String? phone,
    String? firstName,
    String? lastName,
    String? email,
  }) {
    return ASSClientDetails(
      busy: busy ?? this.busy,
      error: error ?? this.error,
      phone: phone ?? this.phone,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
    );
  }
}

/// This state is used when user is filled client details and asks to add contacts
class ASSClientContacts extends AuthScreenState {
  const ASSClientContacts({
    super.busy,
    super.error,
  });

  ASSClientContacts copyWith({
    bool? busy,
    String? error,
  }) {
    return ASSClientContacts(
      busy: busy ?? this.busy,
      error: error ?? this.error,
    );
  }
}

/// This state is used when all authorization is done and client can use the app
class ASSAuthorized extends AuthScreenState {
  const ASSAuthorized({
    super.busy,
    super.error,
  });
}
