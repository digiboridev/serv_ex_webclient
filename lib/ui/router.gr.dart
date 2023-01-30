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
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

import 'app_wrapper.dart' as _i2;
import 'router.dart' as _i3;
import 'screens/auth/auth_screen.dart' as _i1;

class AppRouter extends _i4.RootStackRouter {
  AppRouter({
    _i5.GlobalKey<_i5.NavigatorState>? navigatorKey,
    required this.authGuard,
    required this.appGuard,
  }) : super(navigatorKey);

  final _i3.AuthGuard authGuard;

  final _i3.AppGuard appGuard;

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    Auth.name: (routeData) {
      final args = routeData.argsAs<AuthArgs>(orElse: () => const AuthArgs());
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i1.AuthScreen(
          returnUrl: args.returnUrl,
          key: args.key,
        ),
      );
    },
    App.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.AppWrapper(),
      );
    },
    SA.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.SA(),
      );
    },
    SB.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.SB(),
      );
    },
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(
          Auth.name,
          path: '/auth',
          guards: [authGuard],
        ),
        _i4.RouteConfig(
          App.name,
          path: '/',
          guards: [appGuard],
          children: [
            _i4.RouteConfig(
              '#redirect',
              path: '',
              parent: App.name,
              redirectTo: 'a',
              fullMatch: true,
            ),
            _i4.RouteConfig(
              SA.name,
              path: 'a',
              parent: App.name,
            ),
            _i4.RouteConfig(
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
class Auth extends _i4.PageRouteInfo<AuthArgs> {
  Auth({
    String? returnUrl,
    _i5.Key? key,
  }) : super(
          Auth.name,
          path: '/auth',
          args: AuthArgs(
            returnUrl: returnUrl,
            key: key,
          ),
        );

  static const String name = 'Auth';
}

class AuthArgs {
  const AuthArgs({
    this.returnUrl,
    this.key,
  });

  final String? returnUrl;

  final _i5.Key? key;

  @override
  String toString() {
    return 'AuthArgs{returnUrl: $returnUrl, key: $key}';
  }
}

/// generated route for
/// [_i2.AppWrapper]
class App extends _i4.PageRouteInfo<void> {
  const App({List<_i4.PageRouteInfo>? children})
      : super(
          App.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'App';
}

/// generated route for
/// [_i3.SA]
class SA extends _i4.PageRouteInfo<void> {
  const SA()
      : super(
          SA.name,
          path: 'a',
        );

  static const String name = 'SA';
}

/// generated route for
/// [_i3.SB]
class SB extends _i4.PageRouteInfo<void> {
  const SB()
      : super(
          SB.name,
          path: 'b',
        );

  static const String name = 'SB';
}
