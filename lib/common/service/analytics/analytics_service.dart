import 'package:flirta/common/service/analytics/analytics_client.dart';
import 'package:flirta/common/service/analytics/events.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../domain/app_config.dart';
//import 'clients/amplitude_client.dart';
//import 'clients/appmetrics_client.dart';
//import 'clients/appsfly_client.dart';

@singleton
class AnalyticsService {
  AnalyticsService({required this.logger, required this.config});

  final Logger logger;
  final AppConfig config;
  List<AnalyticsClient> _clients = [];

  Future<void> init() async {
    // Initialize all analytics clients
    _clients = [/*AmplitudeClient(), AppsFlyerClient(), AppMetricsClient()*/];

    for (final item in _clients) {
      await item.init(appConfig: config);
    }
  }

  Future<void> logEvent(MyEvent event) async {
    logger.log(
      Level.info,
      'analytics: logEvent => ${event.eventType}, param: ${event.eventProperties?.toString() ?? '{}'}',
    );
    for (final item in _clients) {
      await item.trackEvent(event.eventType, parameters: event.eventProperties);
    }
  }

  Future<void> setUser({
    required String userId,
    String? email,
    Map<String, dynamic>? properties,
  }) async {
    logger.log(
      Level.info,
      'analytics: setUser => $userId | $email, param: ${properties.toString()}',
    );
    for (final item in _clients) {
      await item.setUserId(userId, email: email, properties: properties);
    }
  }
}
