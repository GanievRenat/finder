import 'package:freezed_annotation/freezed_annotation.dart';

part 'eyes_model.freezed.dart';
part 'eyes_model.g.dart';

@freezed
abstract class EyesModel with _$EyesModel {
  const factory EyesModel({@Default('') @JsonKey(name: 'color') String color}) =
      _EyesModel;

  factory EyesModel.fromJson(Map<String, Object?> json) =>
      _$EyesModelFromJson(json);
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
