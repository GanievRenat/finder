import 'package:flirta/common/service/analytics/analytics_service.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

// отслеживаем все переходы

@injectable
class MainAnalyticsObserver extends NavigatorObserver {
  MainAnalyticsObserver({required this.analyticsService, required this.logger});

  final AnalyticsService analyticsService;
  final Logger logger;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    logger.log(Level.info, "push: ${route.settings.name}");
    super.didPush(route, previousRoute);
  }

  /*@override
  void didPop(Route route, Route? previousRoute) {
    // 1. Получаем результат из маршрута.
    // Если результат еще не был установлен, get currentResult вернет null.
    final popResult = route.currentResult;

    // 2. Получаем информацию о странице (для аналитики)
    final Page? page = route.settings is Page ? route.settings as Page : null;
    final String? routeName = page?.name ?? route.settings.name;

    if (popResult != null) {
      logger.log(
        Level.info,
        "pop: $routeName, result: $popResult (Type: ${popResult.runtimeType})",
      );
    } else {
      logger.log(Level.info, "pop: ${route.settings.name}, result: NoResult");
    }

    super.didPop(route, previousRoute);
  }*/

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final Page? page = route.settings is Page ? route.settings as Page : null;
    final String? routeName = page?.name ?? route.settings.name;

    // 1. Используем Future.then() на свойстве route.popped
    //    Этот Future завершится, когда Navigator.pop() установит результат.
    route.popped.then((popResult) {
      // 2. Код выполняется асинхронно, когда результат доступен.
      if (popResult != null) {
        // ⚠️ Важно: Этот код выполняется позже, в другом цикле Event Loop!
        logger.log(
          Level.info,
          "Async pop: $routeName, result: $popResult (Type: ${popResult.runtimeType})",
        );
      } else {
        logger.log(Level.info, "Async pop: $routeName, result: NoResult");
      }
    });

    // Логирование самого didPop (синхронное)
    logger.log(Level.info, "didPop called for: $routeName");

    super.didPop(route, previousRoute);
  }
}
