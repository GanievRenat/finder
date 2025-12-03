import 'package:injectable/injectable.dart';

import '../domain/app_config.dart';

class DefAppConfig implements AppConfig {
  @override
  String get baseUrl => 'https://api.venice.ai/api/v1';
}

@Singleton(as: AppConfig)
@prod
class ProdAppConfig extends DefAppConfig {}

@Singleton(as: AppConfig)
@dev
class DevAppConfig extends DefAppConfig {}

@Singleton(as: AppConfig)
@test
class TestAppConfig extends DefAppConfig {}
