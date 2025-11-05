import 'package:freezed_annotation/freezed_annotation.dart';

part 'safety_model.freezed.dart';
part 'safety_model.g.dart';

@freezed
abstract class SafetyModel with _$SafetyModel {
  const factory SafetyModel({
    @Default('') @JsonKey(name: 'nsfw_policy') String nsfwPolicy,
    @Default('') @JsonKey(name: 'blocked') String blocked,
    @Default('') @JsonKey(name: 'toxicity_handler') String toxicityHandler,
    @Default('') @JsonKey(name: 'desires_sfw') String desiresSfw,
  }) = _SafetyModel;

  factory SafetyModel.fromJson(Map<String, Object?> json) =>
      _$SafetyModelFromJson(json);
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
