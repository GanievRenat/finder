import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/enums/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'filter_state_model.freezed.dart';
part 'filter_state_model.g.dart';

@freezed
abstract class FilterStateModel with _$FilterStateModel {
  const factory FilterStateModel({
    required List<String> tags,
    required List<String> selectTags,
    required int genderIndex,
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
    );
  }
}
