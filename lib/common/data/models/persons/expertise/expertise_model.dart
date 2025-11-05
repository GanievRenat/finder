import 'package:freezed_annotation/freezed_annotation.dart';

part 'expertise_model.freezed.dart';
part 'expertise_model.g.dart';

@freezed
abstract class ExpertiseModel with _$ExpertiseModel {
  const factory ExpertiseModel({
    @Default(const []) @JsonKey(name: 'music_styles') List<String> musicStyles,
    @Default(const []) @JsonKey(name: 'domains') List<String> domains,
    @Default(const []) @JsonKey(name: 'hobbies') List<String> hobbies,
  }) = _ExpertiseModel;

  factory ExpertiseModel.fromJson(Map<String, Object?> json) =>
      _$ExpertiseModelFromJson(json);
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
