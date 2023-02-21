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
class ASSDataError extends AuthScreenState {
  const ASSDataError();
}

/// This state is used when user is not authorized and appUser needs to choose how to authorize
class ASSUnauthorized extends AuthScreenState {
  const ASSUnauthorized({
    super.busy,
    super.error,
  });
}

/// This state is used for phone auth when appUser needs to confirm his phone number
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

/// This state is used when user is authorized and appUser needs to fill his details
/// (first name, last name, email, phone) is the fields from auth provider, and user cant modify them if its exist
class ASSAppUserDetails extends AuthScreenState {
  const ASSAppUserDetails({
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

  ASSAppUserDetails copyWith({
    bool? busy,
    String? error,
    String? phone,
    String? firstName,
    String? lastName,
    String? email,
  }) {
    return ASSAppUserDetails(
      busy: busy ?? this.busy,
      error: error ?? this.error,
      phone: phone ?? this.phone,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
    );
  }
}

/// This state is used when user is filled appUser details and asks to add contacts
class ASSAppUserContacts extends AuthScreenState {
  const ASSAppUserContacts({
    super.busy,
    super.error,
  });

  ASSAppUserContacts copyWith({
    bool? busy,
    String? error,
  }) {
    return ASSAppUserContacts(
      busy: busy ?? this.busy,
      error: error ?? this.error,
    );
  }
}

class ASSCompanyCreate extends AuthScreenState {
  const ASSCompanyCreate({
    super.busy,
    super.error,
  });

  ASSCompanyCreate copyWith({
    bool? busy,
    String? error,
  }) {
    return ASSCompanyCreate(
      busy: busy ?? this.busy,
      error: error ?? this.error,
    );
  }
}

class ASSCompanyMembers extends AuthScreenState {
  const ASSCompanyMembers({
    super.busy,
    super.error,
    required this.membersIds,
    required this.companyId,
  });

  final List<String> membersIds;
  final String companyId;

  ASSCompanyMembers copyWith({
    bool? busy,
    String? error,
    List<String>? membersIds,
    String? companyId,
  }) {
    return ASSCompanyMembers(
      busy: busy ?? this.busy,
      error: error ?? this.error,
      membersIds: membersIds ?? this.membersIds,
      companyId: companyId ?? this.companyId,
    );
  }
}

/// This state is used when all authorization is done and appUser can use the app
class ASSAuthorized extends AuthScreenState {
  const ASSAuthorized({
    super.busy,
    super.error,
  });
}
