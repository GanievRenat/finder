import 'package:freezed_annotation/freezed_annotation.dart';

part 'dynamics_model.freezed.dart';
part 'dynamics_model.g.dart';

@freezed
abstract class DynamicsModel with _$DynamicsModel {
  @JsonSerializable(explicitToJson: true)
  const factory DynamicsModel({
    @Default('')
    @JsonKey(name: 'escalation_triggers')
    String escalationTriggers,
    @Default('') @JsonKey(name: 'anti_triggers') String antiTriggers,
  }) = _DynamicsModel;

  factory DynamicsModel.fromJson(Map<String, Object?> json) =>
      _$DynamicsModelFromJson(json);
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
