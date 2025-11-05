import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/enums/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'approach/approach_model.dart';
import 'axis/axis_model.dart';
import 'boundaries/boundaries_model.dart';
import 'chat/chat_model.dart';
import 'clothing/clothing_model.dart';
import 'compliments/compliments_model.dart';
import 'dynamics/dynamics_model.dart';
import 'expertise/expertise_model.dart';
import 'identity/identity_model.dart';
import 'intellect/intellect_model.dart';
import 'loyalty/loyalty_model.dart';
import 'memory/memory_model.dart';
import 'phenotype/phenotype_model.dart';
import 'safety/safety_model.dart';
import 'style/style_model.dart';
import 'traits/traits_model.dart';
import 'visual/visual_model.dart';

part 'person_model.freezed.dart';
part 'person_model.g.dart';

@freezed
abstract class PersonModel with _$PersonModel {
  @JsonSerializable(explicitToJson: true)
  const factory PersonModel({
    @Default('') @JsonKey(name: 'model_id') String modelId,
    @Default('') @JsonKey(name: 'bio_app') String bioApp,
    @Default('') @JsonKey(name: 'art_bio') String artBio,
    @Default('') @JsonKey(name: 'name') String name,
    @Default('') @JsonKey(name: 'gender') String gender,
    @JsonKey(name: 'approach') ApproachModel? approach,
    @JsonKey(name: 'axis') AxisModel? axis,
    @JsonKey(name: 'boundaries') BoundariesModel? boundaries,
    @JsonKey(name: 'chat') ChatModel? chat,
    @JsonKey(name: 'clothing') ClothingModel? clothing,
    @JsonKey(name: 'compliments') ComplimentsModel? compliments,
    @JsonKey(name: 'dynamics') DynamicsModel? dynamics,
    @JsonKey(name: 'expertise') ExpertiseModel? expertise,
    @JsonKey(name: 'identity') IdentityModel? identity,
    @JsonKey(name: 'intellect') IntellectModel? intellect,
    @JsonKey(name: 'loyalty') LoyaltyModel? loyalty,
    @JsonKey(name: 'memory') MemoryModel? memory,
    @JsonKey(name: 'phenotype') PhenotypeModel? phenotype,
    @JsonKey(name: 'safety') SafetyModel? safety,
    @JsonKey(name: 'style') StyleModel? style,
    @JsonKey(name: 'traits') TraitsModel? traits,
    @JsonKey(name: 'visual') VisualModel? visual,
  }) = _PersonModel;

  factory PersonModel.fromJson(Map<String, Object?> json) =>
      _$PersonModelFromJson(json);
}
