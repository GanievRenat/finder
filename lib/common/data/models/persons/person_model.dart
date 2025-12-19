import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/enums/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

/*import 'approach/approach_model.dart';
import 'axis/axis.model.dart';
import 'boundaries/boundaries_model.dart';
import 'chat/chat_model.dart';
import 'clothing/clothing_model.dart';
import 'compliments/compliments.model.dart';
import 'dynamics/dynamics.model.dart';
import 'expertise/expertise_model.dart';
import 'identity/identity_model.dart';
import 'intellect/intellect_model.dart';
import 'loyalty/loyalty_model.dart';
import 'memory/memory_model.dart';
import 'phenotype/phenotype_model.dart';
import 'safety/safety.model.dart';
import 'style/style.model.dart';
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
    @Default(1) @JsonKey(name: 'approach_speed') int approachSpeed,
    @Default('') @JsonKey(name: 'approach_heat_ramp') String approachHeatRamp,
    @Default(1)
    @JsonKey(name: 'axis_sensing_intuition')
    int axisSensingIntuition,
    @Default(1) @JsonKey(name: 'axis_thinking_feeling') int axisThinkingFeeling,
    @Default(1)
    @JsonKey(name: 'axis_extraversion_introversion')
    int axisExtraversionIntroversion,
    @Default(1)
    @JsonKey(name: 'axis_judging_perceiving')
    int axisJudgingPerceiving,
    @Default(false) @JsonKey(name: 'model_active') bool modelActive,
    @Default(true)
    @JsonKey(name: 'boundaries_store_sfw')
    bool boundariesStoreSfw,
    @Default('') @JsonKey(name: 'chat_behavior') String chatBehavior,
    @Default('') @JsonKey(name: 'chat_filters') String chatFilter,
    @Default([]) @JsonKey(name: 'clothing_styles') List<String> clothingStyles,
    @Default(1)
    @JsonKey(name: 'compliments_to_intellect')
    int complimentsToIntellect,
    @Default(1)
    @JsonKey(name: 'compliments_to_physique')
    int complimentsToPhysique,
    @Default(1)
    @JsonKey(name: 'compliments_intensity')
    int complimentsIntensity,
    @Default(1)
    @JsonKey(name: 'compliments_cooldown_msgs')
    int complimentsCooldownMsgs,
    @Default('')
    @JsonKey(name: 'compliments_triggers')
    String complimentsTriggers,
    @Default('')
    @JsonKey(name: 'dynamics_escalation_triggers')
    String dynamicsEscalationTriggers,
    @Default('')
    @JsonKey(name: 'dynamics_anti_triggers')
    String dynamicsAntiTriggers,
    @Default(const [])
    @JsonKey(name: 'expertise_hobbies')
    List<String> expertiseHobbies,
    @Default(18) @JsonKey(name: 'identity_age_band') int identityAgeBand,
    @Default('') @JsonKey(name: 'identity_ethnicity') String identityEthnicity,
    @Default('')
    @JsonKey(name: 'identity_occupation')
    String identityOccupation,
    @Default('') @JsonKey(name: 'identity_city') String identityCity,
    @Default('') @JsonKey(name: 'identity_lifestyle') String identityLifestyle,
    @Default('') @JsonKey(name: 'identity_goal') String identityGoal,
    @Default(1) @JsonKey(name: 'intellect_depth') int intellectDepth,
    @Default(1)
    @JsonKey(name: 'loyalty_exclusivity_preference')
    int loyaltyExclusivityPreference,
    @Default('user_name; city; language; interests; taboos; weekly_goals')
    @JsonKey(name: 'memory_slots')
    String memorySlots,
    @Default('') @JsonKey(name: 'phenotype_body_type') String phenotypeBodyType,
    @Default('')
    @JsonKey(name: 'phenotype_somatotype')
    String phenotypeSomatotype,
    @Default('') @JsonKey(name: 'phenotype_face_type') String phenotypeFaceType,
    @Default('') @JsonKey(name: 'phenotype_bmi') String phenotypeBmi,
    @Default('')
    @JsonKey(name: 'phenotype_eyes_color')
    String phenotypeEyesColor,
    @Default('')
    @JsonKey(name: 'phenotype_hair_color')
    String phenotypeHairColor,
    @Default('')
    @JsonKey(name: 'phenotype_hair_texture')
    String phenotypeHairTexture,
    @Default('') @JsonKey(name: 'safety_nsfw_policy') String safetyNsfwPolicy,
    @Default('') @JsonKey(name: 'safety_blocked') String safetyBlocked,
    @Default('')
    @JsonKey(name: 'safety_toxicity_handler')
    String safetyToxicityHandler,
    @Default(
      'slow_date_rhythm; gentle_gestures; goodbye_kiss; walks; coffee_dates; soft_tease',
    )
    @JsonKey(name: 'safety_desires_sfw')
    String safetyDesiresSfw,
    @Default(1) @JsonKey(name: 'style_pace') int stylePace,
    @Default(1) @JsonKey(name: 'style_questions_ratio') int styleQuestionsRatio,
    @Default(1) @JsonKey(name: 'style_flirt_level_max') int styleFlirtLevelMax,
    @Default(1) @JsonKey(name: 'style_humor') int styleHumor,
    @Default(1) @JsonKey(name: 'style_emoji') int styleEmoji,
    @Default(1) @JsonKey(name: 'style_formality') int styleFormality,
    @Default(1) @JsonKey(name: 'style_slang') int styleSlang,
    @Default(1) @JsonKey(name: 'traits_empathy') int traitsEmpathy,
    @Default(1) @JsonKey(name: 'traits_playfulness') int traitsPlayfulness,
    @Default(1) @JsonKey(name: 'traits_directness') int traitsDirectness,
    @Default(1)
    @JsonKey(name: 'traits_intellect_support')
    int traitsIntellectSupport,
    @Default(1)
    @JsonKey(name: 'traits_nurture_challenge')
    int traitsNurtureChallenge,
    @Default(1) @JsonKey(name: 'traits_novelty') int traitsNovelty,
    @Default(1) @JsonKey(name: 'traits_romance') int traitsRomance,
    @Default('') @JsonKey(name: 'visual_signature') String visualSignature,
    @Default('') @JsonKey(name: 'visual_palette') String visualPalette,
    @Default([])
    @JsonKey(name: 'visual_wardrobe_capsule')
    List<String> visualWardrobeCapsule,
    @Default('')
    @JsonKey(name: 'visual_distinctive_features')
    String visualDistinctiveFeatures,
  }) = _PersonModel;

  factory PersonModel.fromJson(Map<String, Object?> json) =>
      _$PersonModelFromJson(json);
}
