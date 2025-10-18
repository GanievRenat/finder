import 'package:flirta/common/domain/app_config.dart';

abstract class AnalyticsClient<T> {
  Future<T> init({required AppConfig appConfig});
  Future<void> trackEvent(String eventName, {Map<String, dynamic>? parameters});
  Future<void> setUserId(
    String userId, {
    String? email,
    Map<String, dynamic>? properties,
  });
}
