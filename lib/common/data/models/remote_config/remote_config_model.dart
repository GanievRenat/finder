import 'package:freezed_annotation/freezed_annotation.dart';

part 'remote_config_model.freezed.dart';
part 'remote_config_model.g.dart';

@freezed
abstract class RemoteConfigModel with _$RemoteConfigModel {
  const factory RemoteConfigModel({
    @Default('') @JsonKey(name: 'banana_key') String bananaKey,
    @Default('') @JsonKey(name: 'deepseek_key') String deepseekKey,
    @Default('') @JsonKey(name: 'venice_key') String veniceKey,
    @Default('') @JsonKey(name: 'spacyapi_key') String spacyapiKey,
    @Default('') @JsonKey(name: 'spacyapi_client_id') String spacyapiClientId,
    @Default('') @JsonKey(name: 'paywall') String paywall,
    @Default('') @JsonKey(name: 'menu_term_url') String menuTermURL,
    @Default('') @JsonKey(name: 'privacy_policy_url') String privacyPolicyURL,
    @Default('') @JsonKey(name: 'support_email') String supportEmail,
  }) = _RemoteConfigModel;

  factory RemoteConfigModel.fromJson(Map<String, Object?> json) =>
      _$RemoteConfigModelFromJson(json);
}
