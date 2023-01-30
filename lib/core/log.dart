import 'package:flutter/foundation.dart';

log(Object? object, {StackTrace? stackTrace}) {
  if (kDebugMode) {
    print(object.toString());
  }

  // todo analytics
}
