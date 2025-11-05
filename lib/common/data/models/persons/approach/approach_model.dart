import 'package:freezed_annotation/freezed_annotation.dart';

part 'approach_model.freezed.dart';
part 'approach_model.g.dart';

@freezed
abstract class ApproachModel with _$ApproachModel {
  const factory ApproachModel({@Default(0) @JsonKey(name: 'speed') int speed}) =
      _ApproachModel;

  factory ApproachModel.fromJson(Map<String, Object?> json) =>
      _$ApproachModelFromJson(json);
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
