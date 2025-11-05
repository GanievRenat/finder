import 'package:freezed_annotation/freezed_annotation.dart';
import 'eyes/eyes_model.dart';
import 'hair/hair_model.dart';

part 'phenotype_model.freezed.dart';
part 'phenotype_model.g.dart';

@freezed
abstract class PhenotypeModel with _$PhenotypeModel {
  const factory PhenotypeModel({
    @Default('') @JsonKey(name: 'body_type') String bodyType,
    @Default('') @JsonKey(name: 'somatotype') String somatotype,
    @Default('') @JsonKey(name: 'face_type') String faceType,
    @Default('') @JsonKey(name: 'bmi') String bmi,
    @JsonKey(name: 'eyes') EyesModel? eyes,
    @JsonKey(name: 'hair') HairModel? hair,
  }) = _PhenotypeModel;

  factory PhenotypeModel.fromJson(Map<String, Object?> json) =>
      _$PhenotypeModelFromJson(json);
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
