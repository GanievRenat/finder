import 'package:freezed_annotation/freezed_annotation.dart';

part 'identity_model.freezed.dart';
part 'identity_model.g.dart';

@freezed
abstract class IdentityModel with _$IdentityModel {
  const factory IdentityModel({
    @Default(18) @JsonKey(name: 'age_band') int ageBand,
    @Default('') @JsonKey(name: 'ethnicity') String ethnicity,
    @Default('') @JsonKey(name: 'occupation') String occupation,
    @Default('') @JsonKey(name: 'city') String city,
    @Default('') @JsonKey(name: 'lifestyle') String lifestyle,
    @Default('') @JsonKey(name: 'goal') String goal,
  }) = _IdentityModel;

  factory IdentityModel.fromJson(Map<String, Object?> json) =>
      _$IdentityModelFromJson(json);
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
