import 'package:flutter/material.dart';
import 'package:serv_expert_webclient/main.dart';

bool _disableScale = true;

double _mobileDesignWidth = 375;
double _tabletDesignWidth = 1194;
// Dont forget to add MediaQuery.of(context) to widgets that use this shortcuts
// for rebuild on device rotation or window resize on web
double get _actualWidth => MediaQuery.of(navigatorKey.currentContext!).size.width;

/// Get multiplier based on difference between design screen width and actual device width
/// Uses to scale any size to design reference by multiply on that value
double get _mobileDesignScale => _actualWidth / _mobileDesignWidth;
double get _tabletDesignScale => _actualWidth / _tabletDesignWidth;

/// Extension to access multiplied size from any number
extension DesignScaleExt on num {
  double get ms => this * (_disableScale ? 1 : _mobileDesignScale);
  double get ts => this * (_disableScale ? 1 : _tabletDesignScale);
}

/// Breakpoints shortcuts
bool get isMobile => _actualWidth < 600;
bool get isTablet => _actualWidth >= 600;

/// Shortcut for set any argument based on device size type
T whenLayout<T>({required T mobile, required T tablet}) {
  if (isMobile) {
    return mobile;
  } else {
    return tablet;
  }
}
