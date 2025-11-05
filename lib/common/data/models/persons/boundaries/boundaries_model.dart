import 'package:freezed_annotation/freezed_annotation.dart';

part 'boundaries_model.freezed.dart';
part 'boundaries_model.g.dart';

@freezed
abstract class BoundariesModel with _$BoundariesModel {
  const factory BoundariesModel({
    @Default(false) @JsonKey(name: 'store_sfw') bool storeSfw,
  }) = _BoundariesModel;

  factory BoundariesModel.fromJson(Map<String, Object?> json) =>
      _$BoundariesModelFromJson(json);
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
