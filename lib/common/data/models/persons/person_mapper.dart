import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/enums/enums.dart';

import 'person_model.dart';

extension PersonModelToEntites on PersonModel {
  Person toEntites() {
    return Person(
      modelId: modelId,
      name: name,
      age: identityAgeBand,
      gender: gender == 'woman'
          ? Gender.female
          : gender == 'man'
          ? Gender.male
          : gender == 'nonBinary'
          ? Gender.nonBinary
          : Gender.none,
      bio: bioApp,
      job: identityOccupation,
      requestToChat: _getRequestToChat(),
      lifeStyle: identityLifestyle,
      interests: expertiseHobbies,
    );
  }

  String _getRequestToChat() {
    StringBuffer strBuff = StringBuffer();

    strBuff.writeln(
      '$modelId $bioApp $artBio name - $name identity.age_band - $identityAgeBand gender - $gender',
    );
    strBuff.writeln(_getProperty(identityEthnicity, 'identity.ethnicity'));
    strBuff.writeln(_getProperty(identityOccupation, 'identity.occupation'));
    strBuff.writeln(_getProperty(identityCity, 'identity.city'));
    strBuff.writeln(_getProperty(identityLifestyle, 'identity.lifestyle'));
    strBuff.writeln(_getProperty(identityGoal, 'identity.goal'));
    strBuff.writeln(_getProperty(phenotypeBodyType, 'phenotype.body_type'));
    strBuff.writeln(_getProperty(phenotypeSomatotype, 'phenotype.somatotype'));
    strBuff.writeln(_getProperty(phenotypeFaceType, 'phenotype.face_type'));
    strBuff.writeln(
      _getProperty(phenotypeHairTexture, 'phenotype.hair.texture'),
    );
    strBuff.writeln(_getProperty(phenotypeHairColor, 'phenotype.hair.color'));
    strBuff.writeln(_getProperty(phenotypeEyesColor, 'phenotype.eyes.color'));
    strBuff.writeln(_getProperty(phenotypeBmi, 'phenotype.bmi'));
    strBuff.writeln(_getProperty(visualSignature, 'visual.signature'));
    strBuff.writeln(_getProperty(visualPalette, 'visual.palette'));
    strBuff.writeln(
      _getProperty(visualWardrobeCapsule, 'visual.wardrobe_capsule'),
    );
    strBuff.writeln(
      _getProperty(visualDistinctiveFeatures, 'visual.distinctive_features'),
    );
    strBuff.writeln(_getProperty(clothingStyles, 'clothing.styles'));
    strBuff.writeln(_getProperty(expertiseHobbies, 'expertise.hobbies'));
    strBuff.writeln(_getProperty(traitsEmpathy, 'traits.empathy'));
    strBuff.writeln(_getProperty(traitsPlayfulness, 'traits.playfulness'));
    strBuff.writeln(_getProperty(traitsDirectness, 'traits.directness'));
    strBuff.writeln(
      _getProperty(traitsIntellectSupport, 'traits.intellect_support'),
    );
    strBuff.writeln(
      _getProperty(traitsNurtureChallenge, 'traits.nurture_challenge'),
    );
    strBuff.writeln(_getProperty(traitsNovelty, 'traits.novelty'));
    strBuff.writeln(_getProperty(traitsRomance, 'traits.romance'));
    strBuff.writeln(_getProperty(stylePace, 'style.pace'));
    strBuff.writeln(_getProperty(styleQuestionsRatio, 'style.questions_ratio'));
    strBuff.writeln(_getProperty(styleFlirtLevelMax, 'style.flirt_level_max'));
    strBuff.writeln(_getProperty(styleHumor, 'style.humor'));
    strBuff.writeln(_getProperty(styleEmoji, 'style.emoji'));
    strBuff.writeln(_getProperty(styleFormality, 'style.formality'));
    strBuff.writeln(_getProperty(styleSlang, 'style.slang'));
    strBuff.writeln(
      _getProperty(dynamicsEscalationTriggers, 'dynamics.escalation_triggers'),
    );
    strBuff.writeln(
      _getProperty(dynamicsAntiTriggers, 'dynamics.anti_triggers'),
    );
    strBuff.writeln(_getProperty(approachSpeed, 'approach.speed'));
    strBuff.writeln(_getProperty(memorySlots, 'memory.slots'));
    strBuff.writeln(_getProperty(intellectDepth, 'intellect.depth'));
    strBuff.writeln(
      _getProperty(complimentsToIntellect, 'compliments.to_intellect'),
    );
    strBuff.writeln(
      _getProperty(complimentsToPhysique, 'compliments.to_physique'),
    );
    strBuff.writeln(
      _getProperty(complimentsIntensity, 'compliments.intensity'),
    );
    strBuff.writeln(
      _getProperty(complimentsCooldownMsgs, 'compliments.cooldown_msgs'),
    );
    strBuff.writeln(_getProperty(complimentsTriggers, 'compliments.triggers'));
    strBuff.writeln(
      _getProperty(
        loyaltyExclusivityPreference,
        'loyalty.exclusivity_preference',
      ),
    );
    strBuff.writeln(
      _getProperty(axisSensingIntuition, 'axis.sensing_intuition'),
    );
    strBuff.writeln(_getProperty(axisThinkingFeeling, 'axis.thinking_feeling'));
    strBuff.writeln(
      _getProperty(
        axisExtraversionIntroversion,
        'axis.extraversion_introversion',
      ),
    );

    strBuff.writeln(_getProperty(safetyNsfwPolicy, 'safety.nsfw_policy'));
    strBuff.writeln(_getProperty(safetyBlocked, 'safety.blocked'));

    if (boundariesStoreSfw) {
      // SFW
      strBuff.writeln(
        _getProperty(safetyToxicityHandler, 'safety.toxicity_handler'),
      );
      strBuff.writeln(_getProperty(safetyDesiresSfw, 'safety.desires_sfw'));
      strBuff.writeln(_getProperty(boundariesStoreSfw, 'boundaries.store_sfw'));
    } else {
      // NO SFW
      strBuff.writeln(_getProperty(approachHeatRamp, 'approach.heat_ramp'));
    }

    strBuff.writeln(_getProperty(chatBehavior, 'chat.behavior'));

    return strBuff.toString();
  }

  String getArtBio() {
    String artBio =
        'identity.age_band - $identityAgeBand / gender - $gender / identity.ethnicity - $identityEthnicity / identity.occupation - $identityEthnicity / identity.city - $identityCity / identity.lifestyle - $identityLifestyle / identity.goal - $identityGoal / phenotype.body_type - $phenotypeBodyType / phenotype.somatotype - $phenotypeSomatotype / phenotype.face_type - $phenotypeFaceType / phenotype.hair.texture - $phenotypeHairTexture / phenotype.hair.color - $phenotypeHairColor / phenotype.eyes.color - $phenotypeEyesColor / phenotype.bmi - $phenotypeBmi / visual.signature - $visualSignature / visual.palette - $visualPalette / visual.wardrobe_capsule - $visualWardrobeCapsule / visual.distinctive_features - $visualDistinctiveFeatures / clothing.styles - $clothingStyles / expertise.hobbies - $expertiseHobbies';
    return artBio;
  }

  String _getProperty(Object? obj, String name) {
    return obj != null ? '$name - $obj' : '';
  }

  bool validate() {
    bool mainField =
        identityEthnicity.isNotEmpty &&
        identityOccupation.isNotEmpty &&
        identityLifestyle.isNotEmpty &&
        identityGoal.isNotEmpty &&
        phenotypeBodyType.isNotEmpty &&
        phenotypeSomatotype.isNotEmpty &&
        phenotypeFaceType.isNotEmpty &&
        phenotypeHairColor.isNotEmpty &&
        phenotypeHairTexture.isNotEmpty &&
        phenotypeEyesColor.isNotEmpty &&
        visualSignature.isNotEmpty &&
        visualPalette.isNotEmpty &&
        visualWardrobeCapsule.isNotEmpty &&
        visualDistinctiveFeatures.isNotEmpty &&
        clothingStyles.isNotEmpty &&
        expertiseHobbies.isNotEmpty &&
        dynamicsEscalationTriggers.isNotEmpty &&
        dynamicsAntiTriggers.isNotEmpty &&
        dynamicsEscalationTriggers.isNotEmpty &&
        complimentsTriggers.isNotEmpty &&
        chatBehavior.isNotEmpty &&
        modelId.isNotEmpty &&
        name.isNotEmpty &&
        bioApp.isNotEmpty &&
        identityCity.isNotEmpty &&
        phenotypeBmi.isNotEmpty &&
        visualDistinctiveFeatures.isNotEmpty &&
        ((boundariesStoreSfw)
            ? safetyDesiresSfw.isNotEmpty
            : approachHeatRamp.isNotEmpty);

    return mainField;
  }
}
