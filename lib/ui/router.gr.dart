// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:flutter/material.dart' as _i12;

import 'app_wrapper.dart' as _i2;
import 'router.dart' as _i10;
import 'screens/auth/auth_screen.dart' as _i1;
import 'screens/auth/subpages/client_contacts.dart' as _i6;
import 'screens/auth/subpages/client_details.dart' as _i5;
import 'screens/auth/subpages/company_registration.dart' as _i7;
import 'screens/auth/subpages/confirm_phone.dart' as _i4;
import 'screens/auth/subpages/data_error.dart' as _i8;
import 'screens/auth/subpages/sign_in.dart' as _i3;
import 'screens/auth/subpages/success.dart' as _i9;

class AppRouter extends _i11.RootStackRouter {
  AppRouter({
    _i12.GlobalKey<_i12.NavigatorState>? navigatorKey,
    required this.authGuard,
    required this.appGuard,
  }) : super(navigatorKey);

  final _i10.AuthGuard authGuard;

  final _i10.AppGuard appGuard;

  @override
  final Map<String, _i11.PageFactory> pagesMap = {
    Auth.name: (routeData) {
      final args = routeData.argsAs<AuthArgs>(orElse: () => const AuthArgs());
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i1.AuthScreen(
          returnUrl: args.returnUrl,
          onAuthComplete: args.onAuthComplete,
          key: args.key,
        ),
      );
    },
    App.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.AppWrapper(),
      );
    },
    SignIn.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.AuthSignIn(),
      );
    },
    AsConfirmPhone.name: (routeData) {
      final args = routeData.argsAs<AsConfirmPhoneArgs>();
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.AuthConfirmPhone(
          key: args.key,
          phone: args.phone,
        ),
      );
    },
    AsClientDetails.name: (routeData) {
      final args = routeData.argsAs<AsClientDetailsArgs>(
          orElse: () => const AsClientDetailsArgs());
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.AuthClientDetails(
          key: args.key,
          phone: args.phone,
          firstName: args.firstName,
          lastName: args.lastName,
          email: args.email,
        ),
      );
    },
    AsClientContacts.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.ClientContactsSubpage(),
      );
    },
    AsCompanyCreate.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.AuthCompanyCreate(),
      );
    },
    AsDataError.name: (routeData) {
      final args = routeData.argsAs<AsDataErrorArgs>();
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.AuthDataError(
          key: args.key,
          error: args.error,
        ),
      );
    },
    AsSuccess.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i9.AuthSucces(),
      );
    },
    SA.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i10.SA(),
      );
    },
    SB.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i10.SB(),
      );
    },
  };

  @override
  List<_i11.RouteConfig> get routes => [
        _i11.RouteConfig(
          Auth.name,
          path: '/auth',
          guards: [authGuard],
          children: [
            _i11.RouteConfig(
              SignIn.name,
              path: 'signin',
              parent: Auth.name,
              usesPathAsKey: true,
            ),
            _i11.RouteConfig(
              AsConfirmPhone.name,
              path: 'confirm_phone',
              parent: Auth.name,
              usesPathAsKey: true,
            ),
            _i11.RouteConfig(
              AsClientDetails.name,
              path: 'client_details',
              parent: Auth.name,
              usesPathAsKey: true,
            ),
            _i11.RouteConfig(
              AsClientContacts.name,
              path: 'client_contacts',
              parent: Auth.name,
              usesPathAsKey: true,
            ),
            _i11.RouteConfig(
              AsCompanyCreate.name,
              path: 'company_create',
              parent: Auth.name,
              usesPathAsKey: true,
            ),
            _i11.RouteConfig(
              AsDataError.name,
              path: 'data_error',
              parent: Auth.name,
              usesPathAsKey: true,
            ),
            _i11.RouteConfig(
              AsSuccess.name,
              path: 'succes',
              parent: Auth.name,
              usesPathAsKey: true,
            ),
          ],
        ),
        _i11.RouteConfig(
          App.name,
          path: '/',
          guards: [appGuard],
          children: [
            _i11.RouteConfig(
              '#redirect',
              path: '',
              parent: App.name,
              redirectTo: 'a',
              fullMatch: true,
            ),
            _i11.RouteConfig(
              SA.name,
              path: 'a',
              parent: App.name,
            ),
            _i11.RouteConfig(
              SB.name,
              path: 'b',
              parent: App.name,
            ),
          ],
        ),
      ];
}

/// generated route for
/// [_i1.AuthScreen]
class Auth extends _i11.PageRouteInfo<AuthArgs> {
  Auth({
    String? returnUrl,
    void Function()? onAuthComplete,
    _i12.Key? key,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          Auth.name,
          path: '/auth',
          args: AuthArgs(
            returnUrl: returnUrl,
            onAuthComplete: onAuthComplete,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'Auth';
}

class AuthArgs {
  const AuthArgs({
    this.returnUrl,
    this.onAuthComplete,
    this.key,
  });

  final String? returnUrl;

  final void Function()? onAuthComplete;

  final _i12.Key? key;

  @override
  String toString() {
    return 'AuthArgs{returnUrl: $returnUrl, onAuthComplete: $onAuthComplete, key: $key}';
  }
}

/// generated route for
/// [_i2.AppWrapper]
class App extends _i11.PageRouteInfo<void> {
  const App({List<_i11.PageRouteInfo>? children})
      : super(
          App.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'App';
}

/// generated route for
/// [_i3.AuthSignIn]
class SignIn extends _i11.PageRouteInfo<void> {
  const SignIn()
      : super(
          SignIn.name,
          path: 'signin',
        );

  static const String name = 'SignIn';
}

/// generated route for
/// [_i4.AuthConfirmPhone]
class AsConfirmPhone extends _i11.PageRouteInfo<AsConfirmPhoneArgs> {
  AsConfirmPhone({
    _i12.Key? key,
    required String phone,
  }) : super(
          AsConfirmPhone.name,
          path: 'confirm_phone',
          args: AsConfirmPhoneArgs(
            key: key,
            phone: phone,
          ),
        );

  static const String name = 'AsConfirmPhone';
}

class AsConfirmPhoneArgs {
  const AsConfirmPhoneArgs({
    this.key,
    required this.phone,
  });

  final _i12.Key? key;

  final String phone;

  @override
  String toString() {
    return 'AsConfirmPhoneArgs{key: $key, phone: $phone}';
  }
}

/// generated route for
/// [_i5.AuthClientDetails]
class AsClientDetails extends _i11.PageRouteInfo<AsClientDetailsArgs> {
  AsClientDetails({
    _i12.Key? key,
    String? phone,
    String? firstName,
    String? lastName,
    String? email,
  }) : super(
          AsClientDetails.name,
          path: 'client_details',
          args: AsClientDetailsArgs(
            key: key,
            phone: phone,
            firstName: firstName,
            lastName: lastName,
            email: email,
          ),
        );

  static const String name = 'AsClientDetails';
}

class AsClientDetailsArgs {
  const AsClientDetailsArgs({
    this.key,
    this.phone,
    this.firstName,
    this.lastName,
    this.email,
  });

  final _i12.Key? key;

  final String? phone;

  final String? firstName;

  final String? lastName;

  final String? email;

  @override
  String toString() {
    return 'AsClientDetailsArgs{key: $key, phone: $phone, firstName: $firstName, lastName: $lastName, email: $email}';
  }
}

/// generated route for
/// [_i6.ClientContactsSubpage]
class AsClientContacts extends _i11.PageRouteInfo<void> {
  const AsClientContacts()
      : super(
          AsClientContacts.name,
          path: 'client_contacts',
        );

  static const String name = 'AsClientContacts';
}

/// generated route for
/// [_i7.AuthCompanyCreate]
class AsCompanyCreate extends _i11.PageRouteInfo<void> {
  const AsCompanyCreate()
      : super(
          AsCompanyCreate.name,
          path: 'company_create',
        );

  static const String name = 'AsCompanyCreate';
}

/// generated route for
/// [_i8.AuthDataError]
class AsDataError extends _i11.PageRouteInfo<AsDataErrorArgs> {
  AsDataError({
    _i12.Key? key,
    required String error,
  }) : super(
          AsDataError.name,
          path: 'data_error',
          args: AsDataErrorArgs(
            key: key,
            error: error,
          ),
        );

  static const String name = 'AsDataError';
}

class AsDataErrorArgs {
  const AsDataErrorArgs({
    this.key,
    required this.error,
  });

  final _i12.Key? key;

  final String error;

  @override
  String toString() {
    return 'AsDataErrorArgs{key: $key, error: $error}';
  }
}

/// generated route for
/// [_i9.AuthSucces]
class AsSuccess extends _i11.PageRouteInfo<void> {
  const AsSuccess()
      : super(
          AsSuccess.name,
          path: 'succes',
        );

  static const String name = 'AsSuccess';
}

/// generated route for
/// [_i10.SA]
class SA extends _i11.PageRouteInfo<void> {
  const SA()
      : super(
          SA.name,
          path: 'a',
        );

  static const String name = 'SA';
}

/// generated route for
/// [_i10.SB]
class SB extends _i11.PageRouteInfo<void> {
  const SB()
      : super(
          SB.name,
          path: 'b',
        );

  static const String name = 'SB';
}
