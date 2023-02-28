import 'package:flutter/material.dart';
import 'package:serv_expert_webclient/main.dart';

bool disableScale = true;

/// Design screen constants
const double _mobileDesignWidth = 375;
const double _tabletDesignWidth = 1194;

/// Get multiplier based on difference between design screen width and actual device width
/// Use it to scale any size to design reference by multiply on that value like SizedBox(width: 100 * mobileDesignScale)
double get mobileDesignScale {
  double deviceWidth = MediaQuery.of(navigatorKey.currentContext!).size.width;
  return deviceWidth / _mobileDesignWidth;
}

double get tabletDesignScale {
  double deviceWidth = MediaQuery.of(navigatorKey.currentContext!).size.width;
  return deviceWidth / _tabletDesignWidth;
}

/// Extension to access multiplied size from any number
extension DesignScaleExt on num {
  double get ms => this * (disableScale ? 1 : mobileDesignScale);
  double get ts => this * (disableScale ? 1 : tabletDesignScale);
}

/// Breakpoints shortcuts
bool get isMobile => MediaQuery.of(navigatorKey.currentContext!).size.width < 600;
bool get isTablet => MediaQuery.of(navigatorKey.currentContext!).size.width >= 600;

/// Shortcut for set any argument based on device size type
T whenLayout<T>({required T mobile, required T tablet}) {
  if (isMobile) {
    return mobile;
  } else {
    return tablet;
  }
}


// Dont forget to add MediaQuery.of(context) to widgets that use this shortcuts
// for rebuild on device rotation or window resize
