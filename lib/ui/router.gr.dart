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
import 'package:auto_route/auto_route.dart' as _i14;
import 'package:flutter/material.dart' as _i15;

import 'app_wrapper.dart' as _i2;
import 'router.dart' as _i13;
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
import 'screens/home_screen.dart' as _i12;

class AppRouter extends _i14.RootStackRouter {
  AppRouter({
    _i15.GlobalKey<_i15.NavigatorState>? navigatorKey,
    required this.appGuard,
    required this.contributorGuard,
  }) : super(navigatorKey);

  final _i13.AppGuard appGuard;

  final _i13.ContributorGuard contributorGuard;

  @override
  final Map<String, _i14.PageFactory> pagesMap = {
    AuthScreenRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.AuthScreen(),
      );
    },
    App.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.AppWrapper(),
      );
    },
    AsSignIn.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.AuthSignIn(),
      );
    },
    AsConfirmPhone.name: (routeData) {
      final args = routeData.argsAs<AsConfirmPhoneArgs>();
      return _i14.MaterialPageX<dynamic>(
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
      return _i14.MaterialPageX<dynamic>(
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
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.AuthClientContacts(),
      );
    },
    AsCompanyCreate.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.AuthCompanyCreate(),
      );
    },
    AsCompanyMembers.name: (routeData) {
      final args = routeData.argsAs<AsCompanyMembersArgs>();
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.AuthCompanyMembers(
          key: args.key,
          membersIds: args.membersIds,
        ),
      );
    },
    AsDataError.name: (routeData) {
      final args = routeData.argsAs<AsDataErrorArgs>();
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i9.AuthDataError(
          key: args.key,
          error: args.error,
        ),
      );
    },
    AsSuccess.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i10.AuthSucces(),
      );
    },
    ContributorSelectScreenRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i11.ContributorSelectScreen(),
      );
    },
    HomeScreenRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i12.HomeScreen(),
      );
    },
    SBRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i13.SB(),
      );
    },
  };

  @override
  List<_i14.RouteConfig> get routes => [
        _i14.RouteConfig(
          AuthScreenRoute.name,
          path: '/auth',
          children: [
            _i14.RouteConfig(
              AsSignIn.name,
              path: 'signin',
              parent: AuthScreenRoute.name,
              usesPathAsKey: true,
            ),
            _i14.RouteConfig(
              AsConfirmPhone.name,
              path: 'confirm_phone',
              parent: AuthScreenRoute.name,
              usesPathAsKey: true,
            ),
            _i14.RouteConfig(
              AsClientDetails.name,
              path: 'client_details',
              parent: AuthScreenRoute.name,
              usesPathAsKey: true,
            ),
            _i14.RouteConfig(
              AsClientContacts.name,
              path: 'client_contacts',
              parent: AuthScreenRoute.name,
              usesPathAsKey: true,
            ),
            _i14.RouteConfig(
              AsCompanyCreate.name,
              path: 'company_create',
              parent: AuthScreenRoute.name,
              usesPathAsKey: true,
            ),
            _i14.RouteConfig(
              AsCompanyMembers.name,
              path: 'company_members',
              parent: AuthScreenRoute.name,
              usesPathAsKey: true,
            ),
            _i14.RouteConfig(
              AsDataError.name,
              path: 'data_error',
              parent: AuthScreenRoute.name,
              usesPathAsKey: true,
            ),
            _i14.RouteConfig(
              AsSuccess.name,
              path: 'succes',
              parent: AuthScreenRoute.name,
              usesPathAsKey: true,
            ),
          ],
        ),
        _i14.RouteConfig(
          App.name,
          path: '/',
          guards: [appGuard],
          children: [
            _i14.RouteConfig(
              '#redirect',
              path: '',
              parent: App.name,
              redirectTo: 'home',
              fullMatch: true,
            ),
            _i14.RouteConfig(
              ContributorSelectScreenRoute.name,
              path: 'contributor_select',
              parent: App.name,
            ),
            _i14.RouteConfig(
              HomeScreenRoute.name,
              path: 'home',
              parent: App.name,
              guards: [contributorGuard],
            ),
            _i14.RouteConfig(
              SBRoute.name,
              path: 'b',
              parent: App.name,
            ),
          ],
        ),
      ];
}

/// generated route for
/// [_i1.AuthScreen]
class AuthScreenRoute extends _i14.PageRouteInfo<void> {
  const AuthScreenRoute({List<_i14.PageRouteInfo>? children})
      : super(
          AuthScreenRoute.name,
          path: '/auth',
          initialChildren: children,
        );

  static const String name = 'AuthScreenRoute';
}

/// generated route for
/// [_i2.AppWrapper]
class App extends _i14.PageRouteInfo<void> {
  const App({List<_i14.PageRouteInfo>? children})
      : super(
          App.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'App';
}

/// generated route for
/// [_i3.AuthSignIn]
class AsSignIn extends _i14.PageRouteInfo<void> {
  const AsSignIn()
      : super(
          AsSignIn.name,
          path: 'signin',
        );

  static const String name = 'AsSignIn';
}

/// generated route for
/// [_i4.AuthConfirmPhone]
class AsConfirmPhone extends _i14.PageRouteInfo<AsConfirmPhoneArgs> {
  AsConfirmPhone({
    _i15.Key? key,
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

  final _i15.Key? key;

  final String phone;

  @override
  String toString() {
    return 'AsConfirmPhoneArgs{key: $key, phone: $phone}';
  }
}

/// generated route for
/// [_i5.AuthClientDetails]
class AsClientDetails extends _i14.PageRouteInfo<AsClientDetailsArgs> {
  AsClientDetails({
    _i15.Key? key,
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

  final _i15.Key? key;

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
class AsClientContacts extends _i14.PageRouteInfo<void> {
  const AsClientContacts()
      : super(
          AsClientContacts.name,
          path: 'client_contacts',
        );

  static const String name = 'AsClientContacts';
}

/// generated route for
/// [_i7.AuthCompanyCreate]
class AsCompanyCreate extends _i14.PageRouteInfo<void> {
  const AsCompanyCreate()
      : super(
          AsCompanyCreate.name,
          path: 'company_create',
        );

  static const String name = 'AsCompanyCreate';
}

/// generated route for
/// [_i8.AuthCompanyMembers]
class AsCompanyMembers extends _i14.PageRouteInfo<AsCompanyMembersArgs> {
  AsCompanyMembers({
    _i15.Key? key,
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

  final _i15.Key? key;

  final List<String> membersIds;

  @override
  String toString() {
    return 'AsCompanyMembersArgs{key: $key, membersIds: $membersIds}';
  }
}

/// generated route for
/// [_i9.AuthDataError]
class AsDataError extends _i14.PageRouteInfo<AsDataErrorArgs> {
  AsDataError({
    _i15.Key? key,
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

  final _i15.Key? key;

  final String error;

  @override
  String toString() {
    return 'AsDataErrorArgs{key: $key, error: $error}';
  }
}

/// generated route for
/// [_i10.AuthSucces]
class AsSuccess extends _i14.PageRouteInfo<void> {
  const AsSuccess()
      : super(
          AsSuccess.name,
          path: 'succes',
        );

  static const String name = 'AsSuccess';
}

/// generated route for
/// [_i11.ContributorSelectScreen]
class ContributorSelectScreenRoute extends _i14.PageRouteInfo<void> {
  const ContributorSelectScreenRoute()
      : super(
          ContributorSelectScreenRoute.name,
          path: 'contributor_select',
        );

  static const String name = 'ContributorSelectScreenRoute';
}

/// generated route for
/// [_i12.HomeScreen]
class HomeScreenRoute extends _i14.PageRouteInfo<void> {
  const HomeScreenRoute()
      : super(
          HomeScreenRoute.name,
          path: 'home',
        );

  static const String name = 'HomeScreenRoute';
}

/// generated route for
/// [_i13.SB]
class SBRoute extends _i14.PageRouteInfo<void> {
  const SBRoute()
      : super(
          SBRoute.name,
          path: 'b',
        );

  static const String name = 'SBRoute';
}
