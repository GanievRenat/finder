import 'package:freezed_annotation/freezed_annotation.dart';

part 'loyalty_model.freezed.dart';
part 'loyalty_model.g.dart';

@freezed
abstract class LoyaltyModel with _$LoyaltyModel {
  const factory LoyaltyModel({
    @Default(1)
    @JsonKey(name: 'exclusivity_preference')
    int exclusivityPreference,
  }) = _LoyaltyModel;

  factory LoyaltyModel.fromJson(Map<String, Object?> json) =>
      _$LoyaltyModelFromJson(json);
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
