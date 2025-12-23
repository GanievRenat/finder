import 'package:freezed_annotation/freezed_annotation.dart';

part 'prompts_model.freezed.dart';
part 'prompts_model.g.dart';

@freezed
abstract class PromptsModel with _$PromptsModel {
  const factory PromptsModel({
    @Default('') @JsonKey(name: 'base_prompt') String basePrompt,
    @Default('') @JsonKey(name: 'json_description') String jsonDescription,
    @Default('') @JsonKey(name: 'photo_filter') String photoFilter,
    @Default('') @JsonKey(name: 'photo_quality') String photoQuality,
  }) = _PromptsModel;

  factory PromptsModel.fromJson(Map<String, Object?> json) =>
      _$PromptsModelFromJson(json);
}
