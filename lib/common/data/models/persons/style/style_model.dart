import 'package:freezed_annotation/freezed_annotation.dart';

part 'style_model.freezed.dart';
part 'style_model.g.dart';

@freezed
abstract class StyleModel with _$StyleModel {
  @JsonSerializable(explicitToJson: true)
  const factory StyleModel({
    @Default(1) @JsonKey(name: 'pace') int pace,
    @Default(1) @JsonKey(name: 'questions_ratio') int questionsRatio,
    @Default(1) @JsonKey(name: 'flirt_level_max') int flirtLevelMax,
    @Default(1) @JsonKey(name: 'humor') int humor,
    @Default(1) @JsonKey(name: 'emoji') int emoji,
    @Default(1) @JsonKey(name: 'formality') int formality,
    @Default(1) @JsonKey(name: 'slang') int slang,
  }) = _StyleModel;

  factory StyleModel.fromJson(Map<String, Object?> json) =>
      _$StyleModelFromJson(json);
}

/*extension PersonModelToEntites on FilterStateModel {
  FilterData toEntites() {
    return FilterData(
      tags: tags,
      selectTags: selectTags,
      interestedGender: Gender.values[genderIndex],
    );
  }
}*/
