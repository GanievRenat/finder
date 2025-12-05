import 'package:flirta/common/data/models/models.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flirta/common/enums/paywall_version.dart';
import 'package:injectable/injectable.dart';

@singleton
class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig;

  RemoteConfigService({required FirebaseRemoteConfig remoteConfig})
    : _remoteConfig = remoteConfig,
      _configModel = RemoteConfigModel(),
      _isInit = false;

  RemoteConfigModel _configModel;
  bool _isInit;

  Future<void> init() async {
    if (!_isInit) {
      _remoteConfig.fetchAndActivate();
      var result = _remoteConfig.getAll();

      _configModel = _configModel.copyWith(
        deepseekKey: result['deepseek_key']?.asString() ?? '',
        veniceKey: result['venice_key']?.asString() ?? '',
        paywall: result['paywall']?.asString() ?? 'a',
      );

      _isInit = true;
    }
  }

  bool get isInit => _isInit;
  String get deepseekKey => _configModel.deepseekKey;
  String get veniceKey => _configModel.veniceKey;
  PayWallVersion get pawwallVersion =>
      _configModel.paywall == 'b' ? PayWallVersion.b : PayWallVersion.a;
}
