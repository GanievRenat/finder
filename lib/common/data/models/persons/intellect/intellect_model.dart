import 'package:freezed_annotation/freezed_annotation.dart';

part 'intellect_model.freezed.dart';
part 'intellect_model.g.dart';

@freezed
abstract class IntellectModel with _$IntellectModel {
  const factory IntellectModel({
    @Default(1) @JsonKey(name: 'depth') int depth,
  }) = _IntellectModel;

  factory IntellectModel.fromJson(Map<String, Object?> json) =>
      _$IntellectModelFromJson(json);
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
