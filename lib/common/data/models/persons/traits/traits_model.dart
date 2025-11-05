import 'package:freezed_annotation/freezed_annotation.dart';

part 'traits_model.freezed.dart';
part 'traits_model.g.dart';

@freezed
abstract class TraitsModel with _$TraitsModel {
  const factory TraitsModel({
    @Default(1) @JsonKey(name: 'empathy') int empathy,
    @Default(1) @JsonKey(name: 'playfulness') int playfulness,
    @Default(1) @JsonKey(name: 'directness') int directness,
    @Default(1) @JsonKey(name: 'intellect_support') int intellectSupport,
    @Default(1) @JsonKey(name: 'nurture_challenge') int nurtureChallenge,
    @Default(1) @JsonKey(name: 'novelty') int novelty,
    @Default(1) @JsonKey(name: 'romance') int romance,
  }) = _TraitsModel;

  factory TraitsModel.fromJson(Map<String, Object?> json) =>
      _$TraitsModelFromJson(json);
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
