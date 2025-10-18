import 'package:flirta/common/domain/app_config.dart';
import 'package:injectable/injectable.dart';

class DefAppConfig implements AppConfig {
  @override
  String get baseUrl => 'dev';

  @override
  String get defaultLocale => 'en';

  @override
  String get host => Environment.dev;

  @override
  List<String> get localies => ['en', 'ru'];

  @override
  bool get showOnboarding => true;

  @override
  String get aboutURL => '';

  @override
  String get privatURL => '';

  @override
  String get termsURL => '';
}

@Singleton(as: AppConfig)
@prod
class ProdAppConfig extends DefAppConfig {
  @override
  String get baseUrl => "prod";

  @override
  String get host => Environment.prod;
}

@Singleton(as: AppConfig)
@dev
class DevAppConfig extends DefAppConfig {}

@Singleton(as: AppConfig)
@test
class TestAppConfig extends DefAppConfig {
  @override
  String get baseUrl => 'test';
  @override
  String get host => Environment.test;
}
