import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_model.freezed.dart';
part 'request_model.g.dart';

@freezed
abstract class RequestModel with _$RequestModel {
  const factory RequestModel({
    @JsonKey(name: 'prompt') @Default('') String prompt,
    @JsonKey(name: 'negative_prompt') @Default('') String negativePrompt,
    @JsonKey(name: 'base64Image') @Default('') String base64Image,
    @JsonKey(name: 'client_id') @Default('') String clientId,
    @JsonKey(name: 'api_key') @Default('') String apiKey,
    @JsonKey(name: 'has_anime') @Default(false) bool hasAnime,
  }) = _RequestModel;

  factory RequestModel.fromJson(Map<String, Object?> json) =>
      _$RequestModelFromJson(json);
}
