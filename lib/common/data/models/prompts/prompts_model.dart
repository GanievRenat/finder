import 'package:freezed_annotation/freezed_annotation.dart';

part 'prompts_model.freezed.dart';
part 'prompts_model.g.dart';

@freezed
abstract class PromptsModel with _$PromptsModel {
  const factory PromptsModel({
    @Default('') @JsonKey(name: 'nsfw_base_prompt') String nsfwBasePrompt,
    @Default('')
    @JsonKey(name: 'nsfw_json_description')
    String nsfwJsonDescription,
    @Default('') @JsonKey(name: 'nsfw_photo_filter') String nsfwPhotoFilter,
    @Default('') @JsonKey(name: 'nsfw_photo_quality') String nsfwPhotoQuality,
    @Default('') @JsonKey(name: 'sfw_base_prompt') String sfwBasePrompt,
    @Default('')
    @JsonKey(name: 'sfw_json_description')
    String sfwJsonDescription,
    @Default('') @JsonKey(name: 'sfw_photo_filter') String sfwPhotoFilter,
    @Default('') @JsonKey(name: 'sfw_photo_quality') String sfwPhotoQuality,
  }) = _PromptsModel;

  factory PromptsModel.fromJson(Map<String, Object?> json) =>
      _$PromptsModelFromJson(json);
}
