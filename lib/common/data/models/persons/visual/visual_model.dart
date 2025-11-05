import 'package:freezed_annotation/freezed_annotation.dart';

part 'visual_model.freezed.dart';
part 'visual_model.g.dart';

@freezed
abstract class VisualModel with _$VisualModel {
  const factory VisualModel({
    @Default('') @JsonKey(name: 'signature') String signature,
    @Default('') @JsonKey(name: 'palette') String palette,
    @Default('') @JsonKey(name: 'wardrobe_capsule') String wardrobeCapsule,
    @Default('')
    @JsonKey(name: 'distinctive_features')
    String distinctiveFeatures,
  }) = _VisualModel;

  factory VisualModel.fromJson(Map<String, Object?> json) =>
      _$VisualModelFromJson(json);
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
