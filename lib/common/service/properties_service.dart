import 'package:flirta/common/domain/usecase/usecases.dart';
import 'package:injectable/injectable.dart';

@singleton
class PropertiesService {
  final GetPropertyList _getPropertyList;
  final UpdateProperty _updateProperty;

  List<String> _antiTriggers = [];
  List<String> _bodyType = [];
  List<String> _clothingStyles = [];
  List<String> _escalationTriggers = [];
  List<String> _ethnicity = [];
  List<String> _eyesColor = [];
  List<String> _faceType = [];
  List<String> _goal = [];
  List<String> _hairColor = [];
  List<String> _hairTexture = [];
  List<String> _heatRamp = [];
  List<String> _hobbies = [];
  List<String> _lifestyle = [];
  List<String> _occupation = [];
  List<String> _palette = [];
  List<String> _signature = [];
  List<String> _somatoType = [];
  List<String> _triggers = [];
  List<String> _wardrobeCapsule = [];

  bool _isUpdateAntiTriggers = false;
  bool _isUpdateBodyType = false;
  bool _isUpdateClothingStyles = false;
  bool _isUpdateEscalationTriggers = false;
  bool _isUpdateEthnicity = false;
  bool _isUpdateEyesColor = false;
  bool _isUpdateFaceType = false;
  bool _isUpdateGoal = false;
  bool _isUpdateHairColor = false;
  bool _isUpdateHairTexture = false;
  bool _isUpdateHeatRamp = false;
  bool _isUpdateHobbies = false;
  bool _isUpdateLifestyle = false;
  bool _isUpdateOccupation = false;
  bool _isUpdatePalette = false;
  bool _isUpdateSignature = false;
  bool _isUpdateSomatoType = false;
  bool _isUpdateTriggers = false;
  bool _isUpdateWardrobeCapsule = false;

  PropertiesService({
    required GetPropertyList getPropertyList,
    required UpdateProperty updateProperty,
  }) : _getPropertyList = getPropertyList,
       _updateProperty = updateProperty;

  Future<void> loadAllProperties() async {
    _antiTriggers = await _getPropertyList('anti_triggers');
    _bodyType = await _getPropertyList('body_type');
    _clothingStyles = await _getPropertyList('clothing_styles');
    _escalationTriggers = await _getPropertyList('escalation_triggers');
    _ethnicity = await _getPropertyList('ethnicity');
    _eyesColor = await _getPropertyList('eyes_color');
    _faceType = await _getPropertyList('face_type');
    _goal = await _getPropertyList('goal');
    _hairColor = await _getPropertyList('hair_color');
    _hairTexture = await _getPropertyList('hair_texture');
    _heatRamp = await _getPropertyList('heat_ramp');
    _hobbies = await _getPropertyList('hobbies');
    _lifestyle = await _getPropertyList('lifestyle');
    _occupation = await _getPropertyList('occupation');
    _palette = await _getPropertyList('palette');
    _signature = await _getPropertyList('signature');
    _somatoType = await _getPropertyList('somato_type');
    _triggers = await _getPropertyList('triggers');
    _wardrobeCapsule = await _getPropertyList('wardrobe_capsule');
  }

  Future<void> updateProperties() async {
    if (_isUpdateAntiTriggers) {
      await _updateProperty('anti_triggers', _antiTriggers);
      _isUpdateAntiTriggers = false;
    }
    if (_isUpdateBodyType) {
      await _updateProperty('body_type', _bodyType);
      _isUpdateBodyType = false;
    }
    if (_isUpdateClothingStyles) {
      await _updateProperty('clothing_styles', _clothingStyles);
      _isUpdateClothingStyles = false;
    }
    if (_isUpdateEscalationTriggers) {
      await _updateProperty('escalation_triggers', _escalationTriggers);
      _isUpdateEscalationTriggers = false;
    }
    if (_isUpdateEthnicity) {
      await _updateProperty('ethnicity', _ethnicity);
      _isUpdateEthnicity = false;
    }
    if (_isUpdateEyesColor) {
      await _updateProperty('eyes_color', _eyesColor);
      _isUpdateEyesColor = false;
    }
    if (_isUpdateFaceType) {
      await _updateProperty('face_type', _faceType);
      _isUpdateFaceType = false;
    }
    if (_isUpdateGoal) {
      await _updateProperty('goal', _goal);
      _isUpdateGoal = false;
    }
    if (_isUpdateHairColor) {
      await _updateProperty('hair_color', _hairColor);
      _isUpdateHairColor = false;
    }
    if (_isUpdateHairTexture) {
      await _updateProperty('hair_texture', _hairTexture);
      _isUpdateHairTexture = false;
    }
    if (_isUpdateHeatRamp) {
      await _updateProperty('heat_ramp', _heatRamp);
      _isUpdateHeatRamp = false;
    }
    if (_isUpdateHobbies) {
      await _updateProperty('hobbies', _hobbies);
      _isUpdateHobbies = false;
    }
    if (_isUpdateLifestyle) {
      await _updateProperty('lifestyle', _lifestyle);
      _isUpdateLifestyle = false;
    }
    if (_isUpdateOccupation) {
      await _updateProperty('occupation', _occupation);
      _isUpdateOccupation = false;
    }
    if (_isUpdatePalette) {
      await _updateProperty('palette', _palette);
      _isUpdatePalette = false;
    }
    if (_isUpdateSignature) {
      await _updateProperty('signature', _signature);
      _isUpdateSignature = false;
    }
    if (_isUpdateSomatoType) {
      await _updateProperty('somato_type', _somatoType);
      _isUpdateSomatoType = false;
    }
    if (_isUpdateTriggers) {
      await _updateProperty('triggers', _triggers);
      _isUpdateTriggers = false;
    }
    if (_isUpdateWardrobeCapsule) {
      await _updateProperty('wardrobe_capsule', _wardrobeCapsule);
      _isUpdateWardrobeCapsule = false;
    }
  }

  List<String> get antiTrigers => _antiTriggers;
  List<String> get bodyType => _bodyType;
  List<String> get clothingStyles => _clothingStyles;
  List<String> get escalationTriggers => _escalationTriggers;
  List<String> get ethnicity => _ethnicity;
  List<String> get eyesColor => _eyesColor;
  List<String> get faceType => _faceType;
  List<String> get goal => _goal;
  List<String> get hairColor => _hairColor;
  List<String> get hairTexture => _hairTexture;
  List<String> get heatRamp => _heatRamp;
  List<String> get hobbies => _hobbies;
  List<String> get lifestyle => _lifestyle;
  List<String> get occupation => _occupation;
  List<String> get palette => _palette;
  List<String> get signature => _signature;
  List<String> get somatoType => _somatoType;
  List<String> get triggers => _triggers;
  List<String> get wardrobeCapsule => _wardrobeCapsule;

  void addAntiTrigers(String value) {
    _isUpdateAntiTriggers = true;
    _antiTriggers.add(value);
  }

  void addBodyType(String value) {
    _isUpdateBodyType = true;
    _bodyType.add(value);
  }

  void addClothingStyles(String value) {
    _isUpdateClothingStyles = true;
    _clothingStyles.add(value);
  }

  void addEscalationTriggers(String value) {
    _isUpdateEscalationTriggers = true;
    _escalationTriggers.add(value);
  }

  void addEthnicity(String value) {
    _isUpdateEthnicity = true;
    _ethnicity.add(value);
  }

  void addEyesColor(String value) {
    _isUpdateEyesColor = true;
    _eyesColor.add(value);
  }

  void addFaceType(String value) {
    _isUpdateFaceType = true;
    _faceType.add(value);
  }

  void addGoal(String value) {
    _isUpdateGoal = true;
    _goal.add(value);
  }

  void addHairColor(String value) {
    _isUpdateHairColor = true;
    _hairColor.add(value);
  }

  void addHairTexture(String value) {
    _isUpdateHairTexture = true;
    _hairTexture.add(value);
  }

  void addHeatRamp(String value) {
    _isUpdateHeatRamp = true;
    _heatRamp.add(value);
  }

  void addHobbies(String value) {
    _isUpdateHobbies = true;
    _hobbies.add(value);
  }

  void addLifestyle(String value) {
    _isUpdateLifestyle = true;
    _lifestyle.add(value);
  }

  void addOccupation(String value) {
    _isUpdateOccupation = true;
    _occupation.add(value);
  }

  void addPalette(String value) {
    _isUpdatePalette = true;
    _palette.add(value);
  }

  void addSignature(String value) {
    _isUpdateSignature = true;
    _signature.add(value);
  }

  void addSomatoType(String value) {
    _isUpdateSomatoType = true;
    _somatoType.add(value);
  }

  void addTriggers(String value) {
    _isUpdateTriggers = true;
    _triggers.add(value);
  }

  void addWardrobeCapsule(String value) {
    _isUpdateWardrobeCapsule = true;
    _wardrobeCapsule.add(value);
  }
}
