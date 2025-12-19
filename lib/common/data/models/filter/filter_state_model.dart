import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/enums/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'filter_state_model.freezed.dart';
part 'filter_state_model.g.dart';

@freezed
abstract class FilterStateModel with _$FilterStateModel {
  const factory FilterStateModel({
    @Default([]) List<String> tags,
    @Default([]) List<String> selectTags,
    @Default(0) @JsonKey(name: 'interestedGender') int genderIndex,
    @Default(0) @JsonKey(name: 'ageStart') int ageStart,
    @Default(0) @JsonKey(name: 'ageFinish') int ageFinish,
  }) = _FilterStateModel;

  factory FilterStateModel.fromJson(Map<String, Object?> json) =>
      _$FilterStateModelFromJson(json);
}

extension FilterStateModelToEntites on FilterStateModel {
  FilterData toEntites() {
    return FilterData(
      tags: tags,
      selectTags: selectTags,
      interestedGender: Gender.values[genderIndex],
      ageStart: ageStart,
      ageFinish: ageFinish,
    );
  }
}
