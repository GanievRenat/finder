import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_status_model.freezed.dart';
part 'check_status_model.g.dart';

@freezed
abstract class CheckStatusModel with _$CheckStatusModel {
  const factory CheckStatusModel({
    @JsonKey(name: 'request_id') @Default('') String requestId,
    @JsonKey(name: 'client_id') @Default('') String clientId,
    @JsonKey(name: 'api_key') @Default('') String apiKey,
  }) = _CheckStatusModel;

  factory CheckStatusModel.fromJson(Map<String, Object?> json) =>
      _$CheckStatusModelFromJson(json);
}
