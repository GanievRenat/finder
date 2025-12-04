import 'dart:ui';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@singleton
class CrashlyticsService {
  void init() {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  void setUserId(String userId, {Map<String, dynamic>? properties}) {
    FirebaseCrashlytics.instance.setUserIdentifier(userId);

    if (properties != null) {
      properties.forEach((key, value) {
        FirebaseCrashlytics.instance.setCustomKey(key, value);
      });
    }
  }
}
