import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/enums/enums.dart';

import 'person_model.dart';

extension PersonModelToEntites on PersonModel {
  Person toEntites() {
    return Person(
      modelId: modelId,
      name: name,
      age: identity?.ageBand ?? 18,
      gender: gender == 'woman'
          ? Gender.female
          : gender == 'man'
          ? Gender.male
          : gender == 'nonBinary'
          ? Gender.nonBinary
          : Gender.none,
      bio: bioApp,
      job: identity?.occupation ?? '',
      requestToChat: _getRequestToChat(),
      lifeStyle: identity?.lifestyle ?? '',
      interests: [...(expertise?.hobbies ?? []), ...(expertise?.domains ?? [])],
    );
  }

  String _getRequestToChat() {
    StringBuffer strBuff = StringBuffer();

    strBuff.writeln(
      '$modelId $bioApp $artBio name - $name identity.age_band - ${identity?.ageBand ?? 18} gender - $gender',
    );
    strBuff.writeln(_getProperty(identity?.ethnicity, 'identity.ethnicity'));
    strBuff.writeln(_getProperty(identity?.occupation, 'identity.occupation'));
    strBuff.writeln(_getProperty(identity?.city, 'identity.city'));
    strBuff.writeln(_getProperty(identity?.lifestyle, 'identity.lifestyle'));
    strBuff.writeln(_getProperty(identity?.goal, 'identity.goal'));
    strBuff.writeln(_getProperty(phenotype?.bodyType, 'phenotype.body_type'));
    strBuff.writeln(
      _getProperty(phenotype?.somatotype, 'phenotype.somatotype'),
    );
    strBuff.writeln(_getProperty(phenotype?.faceType, 'phenotype.face_type'));
    strBuff.writeln(
      _getProperty(phenotype?.hair?.texture, 'phenotype.hair.texture'),
    );
    strBuff.writeln(
      _getProperty(phenotype?.hair?.color, 'phenotype.hair.color'),
    );
    strBuff.writeln(
      _getProperty(phenotype?.eyes?.color, 'phenotype.eyes.color'),
    );
    strBuff.writeln(_getProperty(phenotype?.bmi, 'phenotype.bmi'));
    strBuff.writeln(_getProperty(visual?.signature, 'visual.signature'));
    strBuff.writeln(_getProperty(visual?.palette, 'visual.palette'));
    strBuff.writeln(
      _getProperty(visual?.wardrobeCapsule, 'visual.wardrobe_capsule'),
    );
    strBuff.writeln(
      _getProperty(visual?.distinctiveFeatures, 'visual.distinctive_features'),
    );
    strBuff.writeln(_getProperty(clothing?.styles, 'clothing.styles'));
    strBuff.writeln(
      _getProperty(expertise?.musicStyles, 'expertise.music_styles'),
    );
    strBuff.writeln(_getProperty(expertise?.domains, 'expertise.domains'));
    strBuff.writeln(_getProperty(expertise?.hobbies, 'expertise.hobbies'));
    strBuff.writeln(_getProperty(traits?.empathy, 'traits.empathy'));
    strBuff.writeln(_getProperty(traits?.playfulness, 'traits.playfulness'));
    strBuff.writeln(_getProperty(traits?.directness, 'traits.directness'));
    strBuff.writeln(
      _getProperty(traits?.intellectSupport, 'traits.intellect_support'),
    );
    strBuff.writeln(
      _getProperty(traits?.nurtureChallenge, 'traits.nurture_challenge'),
    );
    strBuff.writeln(_getProperty(traits?.novelty, 'traits.novelty'));
    strBuff.writeln(_getProperty(traits?.romance, 'traits.romance'));
    strBuff.writeln(_getProperty(style?.pace, 'style.pace'));
    strBuff.writeln(
      _getProperty(style?.questionsRatio, 'style.questions_ratio'),
    );
    strBuff.writeln(
      _getProperty(style?.flirtLevelMax, 'style.flirt_level_max'),
    );
    strBuff.writeln(_getProperty(style?.humor, 'style.humor'));
    strBuff.writeln(_getProperty(style?.emoji, 'style.emoji'));
    strBuff.writeln(_getProperty(style?.formality, 'style.formality'));
    strBuff.writeln(_getProperty(style?.slang, 'style.slang'));
    strBuff.writeln(
      _getProperty(
        dynamics?.escalationTriggers,
        'dynamics.escalation_triggers',
      ),
    );
    strBuff.writeln(
      _getProperty(dynamics?.antiTriggers, 'dynamics.anti_triggers'),
    );
    strBuff.writeln(_getProperty(approach?.speed, 'approach.speed'));
    strBuff.writeln(_getProperty(memory?.slots, 'memory.slots'));
    strBuff.writeln(_getProperty(intellect?.depth, 'intellect.depth'));
    strBuff.writeln(
      _getProperty(compliments?.toIntellect, 'compliments.to_intellect'),
    );
    strBuff.writeln(
      _getProperty(compliments?.toPhysique, 'compliments.to_physique'),
    );
    strBuff.writeln(
      _getProperty(compliments?.intensity, 'compliments.intensity'),
    );
    strBuff.writeln(
      _getProperty(compliments?.cooldownMsgs, 'compliments.cooldown_msgs'),
    );
    strBuff.writeln(
      _getProperty(compliments?.triggers, 'compliments.triggers'),
    );
    strBuff.writeln(
      _getProperty(
        loyalty?.exclusivityPreference,
        'loyalty.exclusivity_preference',
      ),
    );
    strBuff.writeln(
      _getProperty(axis?.sensingIntuition, 'axis.sensing_intuition'),
    );
    strBuff.writeln(
      _getProperty(axis?.thinkingFeeling, 'axis.thinking_feeling'),
    );
    strBuff.writeln(
      _getProperty(
        axis?.extraversionIntroversion,
        'axis.extraversion_introversion',
      ),
    );
    strBuff.writeln(_getProperty(safety?.nsfwPolicy, 'safety.nsfw_policy'));
    strBuff.writeln(_getProperty(safety?.blocked, 'safety.blocked'));
    strBuff.writeln(
      _getProperty(safety?.toxicityHandler, 'safety.toxicity_handler'),
    );
    strBuff.writeln(_getProperty(safety?.desiresSfw, 'safety.desires_sfw'));
    strBuff.writeln(_getProperty(boundaries?.storeSfw, 'boundaries.store_sfw'));
    strBuff.writeln(_getProperty(chat?.behavior, 'chat.behavior'));

    return strBuff.toString();
  }

  String _getProperty(Object? obj, String name) {
    return obj != null ? '$name - $obj' : '';
  }
}
