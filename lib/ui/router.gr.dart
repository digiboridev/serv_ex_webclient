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
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import 'router.dart' as _i2;
import 'screens/auth/auth_screen.dart' as _i1;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    Login.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.AuthScreen(),
      );
    },
    Home.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.Home(),
      );
    },
    Home2.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.Home(),
      );
    },
    SA.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.SA(),
      );
    },
    SB.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.SB(),
      );
    },
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/login',
          fullMatch: true,
        ),
        _i3.RouteConfig(
          Login.name,
          path: '/login',
        ),
        _i3.RouteConfig(
          Home.name,
          path: '/home',
          children: [
            _i3.RouteConfig(
              SA.name,
              path: 'a',
              parent: Home.name,
            ),
            _i3.RouteConfig(
              SB.name,
              path: 'b',
              parent: Home.name,
            ),
          ],
        ),
        _i3.RouteConfig(
          Home2.name,
          path: '/home2',
          children: [
            _i3.RouteConfig(
              SA.name,
              path: 'a',
              parent: Home2.name,
            ),
            _i3.RouteConfig(
              SB.name,
              path: 'b',
              parent: Home2.name,
            ),
          ],
        ),
      ];
}

/// generated route for
/// [_i1.AuthScreen]
class Login extends _i3.PageRouteInfo<void> {
  const Login()
      : super(
          Login.name,
          path: '/login',
        );

  static const String name = 'Login';
}

/// generated route for
/// [_i2.Home]
class Home extends _i3.PageRouteInfo<void> {
  const Home({List<_i3.PageRouteInfo>? children})
      : super(
          Home.name,
          path: '/home',
          initialChildren: children,
        );

  static const String name = 'Home';
}

/// generated route for
/// [_i2.Home]
class Home2 extends _i3.PageRouteInfo<void> {
  const Home2({List<_i3.PageRouteInfo>? children})
      : super(
          Home2.name,
          path: '/home2',
          initialChildren: children,
        );

  static const String name = 'Home2';
}

/// generated route for
/// [_i2.SA]
class SA extends _i3.PageRouteInfo<void> {
  const SA()
      : super(
          SA.name,
          path: 'a',
        );

  static const String name = 'SA';
}

/// generated route for
/// [_i2.SB]
class SB extends _i3.PageRouteInfo<void> {
  const SB()
      : super(
          SB.name,
          path: 'b',
        );

  static const String name = 'SB';
}
