import 'package:equatable/equatable.dart';

abstract class LoginScreenState extends Equatable {
  final bool busy;
  final String error;
  const LoginScreenState({
    this.busy = false,
    this.error = '',
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [busy, error];

  LoginScreenState copyWith({bool? busy, String? error});
}

class LSSInitial extends LoginScreenState {
  const LSSInitial({
    super.busy,
    super.error,
  });

  @override
  LSSInitial copyWith({bool? busy, String? error}) {
    return LSSInitial(
      busy: busy ?? this.busy,
      error: error ?? this.error,
    );
  }
}

class LSSUnauthorized extends LoginScreenState {
  const LSSUnauthorized({
    super.busy,
    super.error,
  });

  @override
  LSSUnauthorized copyWith({bool? busy, String? error}) {
    return LSSUnauthorized(
      busy: busy ?? this.busy,
      error: error ?? this.error,
    );
  }
}

class LSSsmsSent extends LoginScreenState {
  const LSSsmsSent({
    super.busy,
    super.error,
    required this.phone,
  });

  final String phone;

  @override
  List<Object> get props => [busy, error, phone];

  @override
  LSSsmsSent copyWith({bool? busy, String? error, String? phone}) {
    return LSSsmsSent(
      busy: busy ?? this.busy,
      error: error ?? this.error,
      phone: phone ?? this.phone,
    );
  }
}

class LSSAuthorized extends LoginScreenState {
  const LSSAuthorized({
    super.busy,
    super.error,
  });

  @override
  LSSAuthorized copyWith({bool? busy, String? error}) {
    return LSSAuthorized(
      busy: busy ?? this.busy,
      error: error ?? this.error,
    );
  }
}
