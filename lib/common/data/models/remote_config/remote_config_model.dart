import 'package:freezed_annotation/freezed_annotation.dart';

part 'remote_config_model.freezed.dart';
part 'remote_config_model.g.dart';

@freezed
abstract class RemoteConfigModel with _$RemoteConfigModel {
  const factory RemoteConfigModel({
    @Default('') @JsonKey(name: 'deepseek_key') String deepseekKey,
    @Default('') @JsonKey(name: 'venice_key') String veniceKey,
    @Default('') @JsonKey(name: 'paywall') String paywall,
  }) = _RemoteConfigModel;

  factory RemoteConfigModel.fromJson(Map<String, Object?> json) =>
      _$RemoteConfigModelFromJson(json);
}
