import 'package:freezed_annotation/freezed_annotation.dart';

part 'compliments_model.freezed.dart';
part 'compliments_model.g.dart';

@freezed
abstract class ComplimentsModel with _$ComplimentsModel {
  const factory ComplimentsModel({
    @Default(1) @JsonKey(name: 'to_intellect') int toIntellect,
    @Default(1) @JsonKey(name: 'to_physique') int toPhysique,
    @Default(1) @JsonKey(name: 'intensity') int intensity,
    @Default(0) @JsonKey(name: 'cooldown_msgs') int cooldownMsgs,
    @Default(const []) @JsonKey(name: 'triggers') List<String> triggers,
  }) = _ComplimentsModel;

  factory ComplimentsModel.fromJson(Map<String, Object?> json) =>
      _$ComplimentsModelFromJson(json);
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
