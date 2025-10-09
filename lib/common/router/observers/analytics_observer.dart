import 'package:flinder/common/service/analytics/analytics_service.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

// отслеживаем все переходы

@injectable
class AnalyticsObserver extends NavigatorObserver {
  AnalyticsObserver({required this.analyticsService, required this.logger});

  final AnalyticsService analyticsService;
  final Logger logger;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    logger.log(Level.info, "push: ${route.settings.name}");
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    logger.log(Level.info, "push: ${route.settings.name}");
    super.didPop(route, previousRoute);
  }
}
