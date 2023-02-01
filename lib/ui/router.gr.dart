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
import 'package:auto_route/auto_route.dart' as _i13;
import 'package:flutter/material.dart' as _i14;

import 'app_wrapper.dart' as _i2;
import 'router.dart' as _i12;
import 'screens/auth/auth_screen.dart' as _i1;
import 'screens/auth/subpages/client_contacts.dart' as _i6;
import 'screens/auth/subpages/client_details.dart' as _i5;
import 'screens/auth/subpages/company_members.dart' as _i8;
import 'screens/auth/subpages/company_registration.dart' as _i7;
import 'screens/auth/subpages/confirm_phone.dart' as _i4;
import 'screens/auth/subpages/data_error.dart' as _i9;
import 'screens/auth/subpages/sign_in.dart' as _i3;
import 'screens/auth/subpages/success.dart' as _i10;
import 'screens/contributor_select_screen.dart' as _i11;

class AppRouter extends _i13.RootStackRouter {
  AppRouter({
    _i14.GlobalKey<_i14.NavigatorState>? navigatorKey,
    required this.appGuard,
    required this.contributorGuard,
  }) : super(navigatorKey);

  final _i12.AppGuard appGuard;

  final _i12.ContributorGuard contributorGuard;

  @override
  final Map<String, _i13.PageFactory> pagesMap = {
    Auth.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.AuthScreen(),
      );
    },
    App.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.AppWrapper(),
      );
    },
    AsSignIn.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.AuthSignIn(),
      );
    },
    AsConfirmPhone.name: (routeData) {
      final args = routeData.argsAs<AsConfirmPhoneArgs>();
      return _i13.MaterialPageX<dynamic>(
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
      return _i13.MaterialPageX<dynamic>(
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
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.AuthClientContacts(),
      );
    },
    AsCompanyCreate.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.AuthCompanyCreate(),
      );
    },
    AsCompanyMembers.name: (routeData) {
      final args = routeData.argsAs<AsCompanyMembersArgs>();
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.AuthCompanyMembers(
          key: args.key,
          membersIds: args.membersIds,
        ),
      );
    },
    AsDataError.name: (routeData) {
      final args = routeData.argsAs<AsDataErrorArgs>();
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i9.AuthDataError(
          key: args.key,
          error: args.error,
        ),
      );
    },
    AsSuccess.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i10.AuthSucces(),
      );
    },
    ContributorSelect.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i11.ContributorSelectScreen(),
      );
    },
    SA.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i12.SA(),
      );
    },
    SB.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i12.SB(),
      );
    },
  };

  @override
  List<_i13.RouteConfig> get routes => [
        _i13.RouteConfig(
          Auth.name,
          path: '/auth',
          children: [
            _i13.RouteConfig(
              AsSignIn.name,
              path: 'signin',
              parent: Auth.name,
              usesPathAsKey: true,
            ),
            _i13.RouteConfig(
              AsConfirmPhone.name,
              path: 'confirm_phone',
              parent: Auth.name,
              usesPathAsKey: true,
            ),
            _i13.RouteConfig(
              AsClientDetails.name,
              path: 'client_details',
              parent: Auth.name,
              usesPathAsKey: true,
            ),
            _i13.RouteConfig(
              AsClientContacts.name,
              path: 'client_contacts',
              parent: Auth.name,
              usesPathAsKey: true,
            ),
            _i13.RouteConfig(
              AsCompanyCreate.name,
              path: 'company_create',
              parent: Auth.name,
              usesPathAsKey: true,
            ),
            _i13.RouteConfig(
              AsCompanyMembers.name,
              path: 'company_members',
              parent: Auth.name,
              usesPathAsKey: true,
            ),
            _i13.RouteConfig(
              AsDataError.name,
              path: 'data_error',
              parent: Auth.name,
              usesPathAsKey: true,
            ),
            _i13.RouteConfig(
              AsSuccess.name,
              path: 'succes',
              parent: Auth.name,
              usesPathAsKey: true,
            ),
          ],
        ),
        _i13.RouteConfig(
          App.name,
          path: '/',
          guards: [appGuard],
          children: [
            _i13.RouteConfig(
              '#redirect',
              path: '',
              parent: App.name,
              redirectTo: 'a',
              fullMatch: true,
            ),
            _i13.RouteConfig(
              ContributorSelect.name,
              path: 'contributor_select',
              parent: App.name,
            ),
            _i13.RouteConfig(
              SA.name,
              path: 'a',
              parent: App.name,
              guards: [contributorGuard],
            ),
            _i13.RouteConfig(
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
class Auth extends _i13.PageRouteInfo<void> {
  const Auth({List<_i13.PageRouteInfo>? children})
      : super(
          Auth.name,
          path: '/auth',
          initialChildren: children,
        );

  static const String name = 'Auth';
}

/// generated route for
/// [_i2.AppWrapper]
class App extends _i13.PageRouteInfo<void> {
  const App({List<_i13.PageRouteInfo>? children})
      : super(
          App.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'App';
}

/// generated route for
/// [_i3.AuthSignIn]
class AsSignIn extends _i13.PageRouteInfo<void> {
  const AsSignIn()
      : super(
          AsSignIn.name,
          path: 'signin',
        );

  static const String name = 'AsSignIn';
}

/// generated route for
/// [_i4.AuthConfirmPhone]
class AsConfirmPhone extends _i13.PageRouteInfo<AsConfirmPhoneArgs> {
  AsConfirmPhone({
    _i14.Key? key,
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

  final _i14.Key? key;

  final String phone;

  @override
  String toString() {
    return 'AsConfirmPhoneArgs{key: $key, phone: $phone}';
  }
}

/// generated route for
/// [_i5.AuthClientDetails]
class AsClientDetails extends _i13.PageRouteInfo<AsClientDetailsArgs> {
  AsClientDetails({
    _i14.Key? key,
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

  final _i14.Key? key;

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
/// [_i6.AuthClientContacts]
class AsClientContacts extends _i13.PageRouteInfo<void> {
  const AsClientContacts()
      : super(
          AsClientContacts.name,
          path: 'client_contacts',
        );

  static const String name = 'AsClientContacts';
}

/// generated route for
/// [_i7.AuthCompanyCreate]
class AsCompanyCreate extends _i13.PageRouteInfo<void> {
  const AsCompanyCreate()
      : super(
          AsCompanyCreate.name,
          path: 'company_create',
        );

  static const String name = 'AsCompanyCreate';
}

/// generated route for
/// [_i8.AuthCompanyMembers]
class AsCompanyMembers extends _i13.PageRouteInfo<AsCompanyMembersArgs> {
  AsCompanyMembers({
    _i14.Key? key,
    required List<String> membersIds,
  }) : super(
          AsCompanyMembers.name,
          path: 'company_members',
          args: AsCompanyMembersArgs(
            key: key,
            membersIds: membersIds,
          ),
        );

  static const String name = 'AsCompanyMembers';
}

class AsCompanyMembersArgs {
  const AsCompanyMembersArgs({
    this.key,
    required this.membersIds,
  });

  final _i14.Key? key;

  final List<String> membersIds;

  @override
  String toString() {
    return 'AsCompanyMembersArgs{key: $key, membersIds: $membersIds}';
  }
}

/// generated route for
/// [_i9.AuthDataError]
class AsDataError extends _i13.PageRouteInfo<AsDataErrorArgs> {
  AsDataError({
    _i14.Key? key,
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

  final _i14.Key? key;

  final String error;

  @override
  String toString() {
    return 'AsDataErrorArgs{key: $key, error: $error}';
  }
}

/// generated route for
/// [_i10.AuthSucces]
class AsSuccess extends _i13.PageRouteInfo<void> {
  const AsSuccess()
      : super(
          AsSuccess.name,
          path: 'succes',
        );

  static const String name = 'AsSuccess';
}

/// generated route for
/// [_i11.ContributorSelectScreen]
class ContributorSelect extends _i13.PageRouteInfo<void> {
  const ContributorSelect()
      : super(
          ContributorSelect.name,
          path: 'contributor_select',
        );

  static const String name = 'ContributorSelect';
}

/// generated route for
/// [_i12.SA]
class SA extends _i13.PageRouteInfo<void> {
  const SA()
      : super(
          SA.name,
          path: 'a',
        );

  static const String name = 'SA';
}

/// generated route for
/// [_i12.SB]
class SB extends _i13.PageRouteInfo<void> {
  const SB()
      : super(
          SB.name,
          path: 'b',
        );

  static const String name = 'SB';
}
