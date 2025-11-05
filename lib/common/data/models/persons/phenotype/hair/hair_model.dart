import 'package:freezed_annotation/freezed_annotation.dart';

part 'hair_model.freezed.dart';
part 'hair_model.g.dart';

@freezed
abstract class HairModel with _$HairModel {
  const factory HairModel({
    @Default('') @JsonKey(name: 'texture') String texture,
    @Default('') @JsonKey(name: 'color') String color,
  }) = _HairModel;

  factory HairModel.fromJson(Map<String, Object?> json) =>
      _$HairModelFromJson(json);
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
