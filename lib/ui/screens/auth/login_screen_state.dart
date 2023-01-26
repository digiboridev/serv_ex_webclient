import 'package:equatable/equatable.dart';

abstract class LoginScreenState extends Equatable {
  const LoginScreenState({
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

class LSSLoading extends LoginScreenState {
  const LSSLoading();
}

/// This state is used when fatal exception is thrown during update state, and app asks to retry operation
class LSSUpdateError extends LoginScreenState {
  const LSSUpdateError();
}

/// This state is used when user is not authorized and client needs to choose how to authorize
class LSSUnauthorized extends LoginScreenState {
  const LSSUnauthorized({
    super.busy,
    super.error,
  });
}

/// This state is used for phone auth when client needs to confirm his phone number
class LSSsmsSent extends LoginScreenState {
  const LSSsmsSent({
    super.busy,
    super.error,
    required this.phone,
  });

  final String phone;

  @override
  List<Object> get props => [busy, error, phone];
}

/// This state is used when user is authorized and client needs to fill his details
/// (first name, last name, email, phone) is the fields from auth provider, and user cant modify them if its exist
class LSSClientDetails extends LoginScreenState {
  const LSSClientDetails({
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
}

/// This state is used when all authorization is done and client can use the app
class LSSAuthorized extends LoginScreenState {
  const LSSAuthorized({
    super.busy,
    super.error,
  });
}
