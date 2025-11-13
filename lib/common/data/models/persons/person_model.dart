import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/enums/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

/*import 'approach/approach_model.dart';
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
import 'visual/visual_model.dart';*/

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
    @Default(1) @JsonKey(name: 'approach.speed') int approachSpeed,
    @Default('') @JsonKey(name: 'approach.heat_ramp') String approachHeatRamp,
    @Default(1)
    @JsonKey(name: 'axis.sensing_intuition')
    int axisSensingIntuition,
    @Default(1) @JsonKey(name: 'axis.thinking_feeling') int axisThinkingFeeling,
    @Default(1)
    @JsonKey(name: 'axis.extraversion_introversion')
    int axisExtraversionIntroversion,
    @Default(1)
    @JsonKey(name: 'axis.judging_perceiving')
    int axisJudgingPerceiving,
    @Default(true)
    @JsonKey(name: 'boundaries.store_sfw')
    bool boundariesStoreSfw,
    @Default('') @JsonKey(name: 'chat.behavior') String chatBehavior,
    @Default('') @JsonKey(name: 'chat.filters') String chatFilter,
    @Default([]) @JsonKey(name: 'clothing.styles') List<String> clothingStyles,
    @Default(1)
    @JsonKey(name: 'compliments.to_intellect')
    int complimentsToIntellect,
    @Default(1)
    @JsonKey(name: 'compliments.to_physique')
    int complimentsToPhysique,
    @Default(1)
    @JsonKey(name: 'compliments.intensity')
    int complimentsIntensity,
    @Default(1)
    @JsonKey(name: 'compliments.cooldown_msgs')
    int complimentsCooldownMsgs,
    @Default('')
    @JsonKey(name: 'compliments.triggers')
    String complimentsTriggers,
    @Default('')
    @JsonKey(name: 'dynamics.escalation_triggers')
    String dynamicsEscalationTriggers,
    @Default('')
    @JsonKey(name: 'dynamics.anti_triggers')
    String dynamicsAntiTriggers,
    @Default(const [])
    @JsonKey(name: 'expertise.hobbies')
    List<String> expertiseHobbies,
    @Default(const [])
    @JsonKey(name: 'expertise.music_styles')
    List<String> expertiseMusicStyles,
    @Default(18) @JsonKey(name: 'identity.age_band') int identityAgeBand,
    @Default('') @JsonKey(name: 'identity.ethnicity') String identityEthnicity,
    @Default('')
    @JsonKey(name: 'identity.occupation')
    String identityOccupation,
    @Default('') @JsonKey(name: 'identity.city') String identityCity,
    @Default('') @JsonKey(name: 'identity.lifestyle') String identityLifestyle,
    @Default('') @JsonKey(name: 'identity.goal') String identityGoal,
    @Default(1) @JsonKey(name: 'intellect.depth') int intellectDepth,
    @Default(1)
    @JsonKey(name: 'loyalty.exclusivity_preference')
    int loyaltyExclusivityPreference,
    @Default('user_name; city; language; interests; taboos; weekly_goals')
    @JsonKey(name: 'memory.slots')
    String memorySlots,
    @Default('') @JsonKey(name: 'phenotype.body_type') String phenotypeBodyType,
    @Default('')
    @JsonKey(name: 'phenotype.somatotype')
    String phenotypeSomatotype,
    @Default('') @JsonKey(name: 'phenotype.face_type') String phenotypeFaceType,
    @Default('') @JsonKey(name: 'phenotype.bmi') String phenotypeBmi,
    @Default('')
    @JsonKey(name: 'phenotype.eyes.color')
    String phenotypeEyesColor,
    @Default('')
    @JsonKey(name: 'phenotype.hair.color')
    String phenotypeHairColor,
    @Default('')
    @JsonKey(name: 'phenotype.hair.texture')
    String phenotypeHairTexture,
    @Default('') @JsonKey(name: 'safety.nsfw_policy') String safetyNsfwPolicy,
    @Default('') @JsonKey(name: 'safety.blocked') String safetyBlocked,
    @Default('')
    @JsonKey(name: 'safety.toxicity_handler')
    String safetyToxicityHandler,
    @Default('') @JsonKey(name: 'safety.desires_sfw') String safetyDesiresSfw,
    @Default(1) @JsonKey(name: 'style.pace') int stylePace,
    @Default(1) @JsonKey(name: 'style.questions_ratio') int styleQuestionsRatio,
    @Default(1) @JsonKey(name: 'style.flirt_level_max') int styleFlirtLevelMax,
    @Default(1) @JsonKey(name: 'style.humor') int styleHumor,
    @Default(1) @JsonKey(name: 'style.emoji') int styleEmoji,
    @Default(1) @JsonKey(name: 'style.formality') int styleFormality,
    @Default(1) @JsonKey(name: 'style.slang') int styleSlang,
    @Default(1) @JsonKey(name: 'traits.empathy') int traitsEmpathy,
    @Default(1) @JsonKey(name: 'traits.playfulness') int traitsPlayfulness,
    @Default(1) @JsonKey(name: 'traits.directness') int traitsDirectness,
    @Default(1)
    @JsonKey(name: 'traits.intellect_support')
    int traitsIntellectSupport,
    @Default(1)
    @JsonKey(name: 'traits.nurture_challenge')
    int traitsNurtureChallenge,
    @Default(1) @JsonKey(name: 'traits.novelty') int traitsNovelty,
    @Default(1) @JsonKey(name: 'traits.romance') int traitsRomance,
    @Default('') @JsonKey(name: 'visual.signature') String visualSignature,
    @Default('') @JsonKey(name: 'visual.palette') String visualPalette,
    @Default([])
    @JsonKey(name: 'visual.wardrobe_capsule')
    List<String> visualWardrobeCapsule,
    @Default('')
    @JsonKey(name: 'visual.distinctive_features')
    String visualDistinctiveFeatures,
  }) = _PersonModel;

  factory PersonModel.fromJson(Map<String, Object?> json) =>
      _$PersonModelFromJson(json);
}
