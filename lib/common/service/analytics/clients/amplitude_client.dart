import 'package:flinder/common/domain/app_config.dart';

import '../analytics_client.dart';

class AmplitudeClient implements AnalyticsClient {
  @override
  Future init({required AppConfig appConfig}) {
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  Future<void> setUserId(
    String userId, {
    String? email,
    Map<String, dynamic>? properties,
  }) {
    // TODO: implement setUserId
    throw UnimplementedError();
  }

  @override
  Future<void> trackEvent(
    String eventName, {
    Map<String, dynamic>? parameters,
  }) {
    // TODO: implement trackEvent
    throw UnimplementedError();
  }
}
