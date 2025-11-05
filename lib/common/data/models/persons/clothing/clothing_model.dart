import 'package:freezed_annotation/freezed_annotation.dart';

part 'clothing_model.freezed.dart';
part 'clothing_model.g.dart';

@freezed
abstract class ClothingModel with _$ClothingModel {
  const factory ClothingModel({
    @Default('') @JsonKey(name: 'styles') String styles,
  }) = _ClothingModel;

  factory ClothingModel.fromJson(Map<String, Object?> json) =>
      _$ClothingModelFromJson(json);
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
