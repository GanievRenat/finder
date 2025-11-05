import 'package:freezed_annotation/freezed_annotation.dart';

part 'axis_model.freezed.dart';
part 'axis_model.g.dart';

@freezed
abstract class AxisModel with _$AxisModel {
  const factory AxisModel({
    @Default(1) @JsonKey(name: 'sensing_intuition') int sensingIntuition,
    @Default(1) @JsonKey(name: 'thinking_feeling') int thinkingFeeling,
    @Default(1)
    @JsonKey(name: 'extraversion_introversion')
    int extraversionIntroversion,
    @Default(1) @JsonKey(name: 'judging_perceiving') int judgingPerceiving,
  }) = _AxisModel;

  factory AxisModel.fromJson(Map<String, Object?> json) =>
      _$AxisModelFromJson(json);
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
