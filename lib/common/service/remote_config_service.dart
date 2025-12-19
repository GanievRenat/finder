import 'package:flirta/common/data/models/models.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flirta/common/enums/paywall_version.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@singleton
class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig;
  final Logger _logger;

  RemoteConfigService({
    required FirebaseRemoteConfig remoteConfig,
    required Logger logger,
  }) : _remoteConfig = remoteConfig,
       _logger = logger,
       _configModel = RemoteConfigModel(),
       _isInit = false;

  RemoteConfigModel _configModel;
  bool _isInit;

  Future<void> init() async {
    if (!_isInit) {
      try {
        await _remoteConfig.setConfigSettings(
          RemoteConfigSettings(
            fetchTimeout: const Duration(seconds: 10),
            minimumFetchInterval: const Duration(minutes: 10),
          ),
        );

        await _remoteConfig.fetchAndActivate();

        _configModel = _configModel.copyWith(
          deepseekKey: _remoteConfig.getString('deepseek_key'),
          veniceKey: _remoteConfig.getString('venice_key'),
          bananaKey: _remoteConfig.getString('banana_key'),
          spacyapiKey: _remoteConfig.getString('spacyapi_key'),
          spacyapiClientId: _remoteConfig.getString('spacyapi_client_id'),
          paywall: _remoteConfig.getString('paywall'),
          menuTermURL: _remoteConfig.getString('menu_term_url'),
          privacyPolicyURL: _remoteConfig.getString('privacy_policy_url'),
          supportEmail: _remoteConfig.getString('support_email'),
        );

        _isInit = true;

        return;
      } catch (e) {
        _logger.e(e.toString());
      }
    }
  }

  bool get isInit => _isInit;
  String get deepseekKey => _configModel.deepseekKey;
  String get veniceKey => _configModel.veniceKey;
  String get bananaKey => _configModel.bananaKey;
  String get spacyapiKey => _configModel.spacyapiKey;
  String get spacyapiClientId => _configModel.spacyapiClientId;
  String get menuTermURL => _configModel.menuTermURL;
  String get privacyPolicyURL => _configModel.privacyPolicyURL;
  String get supportEmail => _configModel.supportEmail;
  PayWallVersion get pawwallVersion =>
      _configModel.paywall == 'b' ? PayWallVersion.b : PayWallVersion.a;
}
