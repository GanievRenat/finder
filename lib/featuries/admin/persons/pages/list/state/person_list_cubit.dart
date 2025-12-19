import 'dart:async';
import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flirta/common/data/models/models.dart';
import 'package:flirta/common/data/models/persons/person_mapper.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:flirta/common/domain/usecase/usecases.dart';
import 'package:flirta/common/service/properties_service.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'person_list_state.dart';
part 'person_list_cubit.freezed.dart';

final List<String> csvField = [
  "model_id",
  "bio_app",
  "name",
  "identity.age_band",
  "gender",
  "identity.ethnicity",
  "identity.occupation",
  "identity.city",
  "identity.lifestyle",
  "identity.goal",
  "phenotype.body_type",
  "phenotype.somatotype",
  "phenotype.face_type",
  "phenotype.hair.texture",
  "phenotype.hair.color",
  "phenotype.eyes.color",
  "phenotype.bmi",
  "visual.signature",
  "visual.palette",
  "visual.wardrobe_capsule",
  "visual.distinctive_features",
  "clothing.styles",
  "expertise.hobbies",
  "traits.empathy",
  "traits.playfulness",
  "traits.directness",
  "traits.intellect_support",
  "traits.nurture_challenge",
  "traits.novelty",
  "traits.romance",
  "style.pace",
  "style.questions_ratio",
  "style.flirt_level_max",
  "style.humor",
  "style.emoji",
  "style.formality",
  "style.slang",
  "dynamics.escalation_triggers",
  "dynamics.anti_triggers",
  "approach.speed",
  "intellect.depth",
  "compliments.to_intellect",
  "compliments.to_physique",
  "compliments.intensity",
  "compliments.cooldown_msgs",
  "compliments.triggers",
  "loyalty.exclusivity_preference",
  "axis.sensing_intuition",
  "axis.thinking_feeling",
  "axis.extraversion_introversion",
  "axis.judging_perceiving",
  "boundaries.store_sfw",
  "chat.behavior",
  "filters",
  "approach.heat_ramp",
];

@lazySingleton
class PersonListCubit extends Cubit<PersonListState> {
  final GetPersonList _getPersonList;
  final PropertiesService _propertiesService;
  final CreateNewPerson _createNewPerson;

  List<PersonModel> _list = [];

  PersonListCubit({
    required GetPersonList getPersonList,
    required PropertiesService propertiesService,
    required CreateNewPerson createNewPerson,
  }) : _getPersonList = getPersonList,
       _propertiesService = propertiesService,
       _createNewPerson = createNewPerson,
       super(PersonListState.init());

  Future<void> init() async {
    emit(PersonListState.loading());
    var result = await _getPersonList(GetPersonByFilterBody(limit: 0));
    if (result.isRight) {
      _list = result.right;
      emit(PersonListState.data(result.right));
    } else {
      emit(PersonListState.error(result.left));
    }
  }

  // Загрузка файла csv
  // Анализ данных на соотвествие формата
  // Проверка на уникальность modelId
  // Предварительная загрузка данных, заполнение справочников недостающими данными
  // Сохранение данных
  // Сохранить все справочники

  // Для работы с файлами на Flutter Web

  // Основная функция для выбора и чтения CSV файла
  Future<List<List<dynamic>>?> pickAndReadCsv({
    List<String> allowedExtensions = const ['csv'],
    String buttonText = 'Выбрать CSV файл',
  }) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: allowedExtensions,
      allowMultiple: false,
      dialogTitle: buttonText,
      type: FileType.custom,
    );
    if (result != null) {
      if (result.files.isNotEmpty) {
        if (result.files.first.bytes != null) {
          var fileBody = utf8.decode(result.files.first.bytes!);
          List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter()
              .convert(fileBody);
          return rowsAsListOfValues;
        }
      }
    }

    return null;
  }

  bool validateCSVData(List<List<dynamic>> csvData) {
    if (csvData.isNotEmpty) {
      var firstLine = csvData.first;
      if (firstLine.length == csvField.length) {
        for (int i = 0; i <= firstLine.length - 1; i++) {
          if (firstLine[i].toString().toLowerCase().trim() !=
              csvField[i].toString().toLowerCase().trim()) {
            return false;
          }
        }
        return true;
      }
    }
    return false;
  }

  List<PersonModel> exportCSVtoModel(List<List<dynamic>> csvData) {
    // Делаем предварительную загрузку данных.
    // Парралельно дополняем справочник свойст.
    // Пока ничего не сохраняем, просто формируем данные.

    List<PersonModel> result = [];
    if (csvData.isNotEmpty) {
      List<dynamic> fields = csvData.first;
      for (var data in csvData) {
        if (data != fields) {
          String modelId =
              _getStringByFielName(
                filed: 'model_id',
                data: data,
                fields: fields,
              ) ??
              '';

          if (modelId.isNotEmpty) {
            // Проверить существует ли такой modelID в базе данных
            // Если да, то пропускаем, нет создаем.
            var index = _list.indexWhere(
              (element) => element.modelId == modelId,
            );
            if (index == -1) {
              var model = _listToModel(data, fields);
              if (model != null) {
                result.add(model);
              }
            }
          }
        }
      }
    }

    return result;
  }

  Future<int> createNewModels(List<PersonModel> newModels) async {
    int count = 0;

    await Future.wait(
      newModels.map((md) async {
        var result = await _createNewPerson(md);
        if (result.isRight) {
          count++;
          // Проверяем каждое свойство, если его нет в справочниках, то добавляем его.
          addNewProperties(md);
        }
      }),
    );

    // Сохраняем данные в справочнике.
    await _propertiesService.updateProperties();

    return count;
  }

  PersonModel? _listToModel(List<dynamic> data, List<dynamic> fields) {
    // Обязательные поля
    if (data.length != fields.length) {
      return null;
    }
    try {
      PersonModel model = PersonModel(
        modelId:
            _getStringByFielName(
              filed: 'model_id',
              data: data,
              fields: fields,
            ) ??
            '',
        bioApp:
            _getStringByFielName(
              filed: 'bio_app',
              data: data,
              fields: fields,
            ) ??
            '',
        name:
            _getStringByFielName(filed: 'name', data: data, fields: fields) ??
            '',
        identityAgeBand:
            _getIntByFielName(
              filed: 'identity.age_band',
              data: data,
              fields: fields,
            ) ??
            18,

        gender:
            _getStringByFielName(filed: 'gender', data: data, fields: fields) ??
            '',
        identityEthnicity:
            _getStringByFielName(
              filed: 'identity.ethnicity',
              data: data,
              fields: fields,
            ) ??
            '',
        identityOccupation:
            _getStringByFielName(
              filed: 'identity.occupation',
              data: data,
              fields: fields,
            ) ??
            '',
        identityCity:
            _getStringByFielName(
              filed: 'identity.city',
              data: data,
              fields: fields,
            ) ??
            '',
        identityLifestyle:
            _getStringByFielName(
              filed: 'identity.lifestyle',
              data: data,
              fields: fields,
            ) ??
            '',
        identityGoal:
            _getStringByFielName(
              filed: 'identity.goal',
              data: data,
              fields: fields,
            ) ??
            '',
        phenotypeBodyType:
            _getStringByFielName(
              filed: 'phenotype.body_type',
              data: data,
              fields: fields,
            ) ??
            '',
        phenotypeSomatotype:
            _getStringByFielName(
              filed: 'phenotype.somatotype',
              data: data,
              fields: fields,
            ) ??
            '',
        phenotypeFaceType:
            _getStringByFielName(
              filed: 'phenotype.face_type',
              data: data,
              fields: fields,
            ) ??
            '',
        phenotypeHairTexture:
            _getStringByFielName(
              filed: 'phenotype.hair.texture',
              data: data,
              fields: fields,
            ) ??
            '',
        phenotypeHairColor:
            _getStringByFielName(
              filed: 'phenotype.hair.color',
              data: data,
              fields: fields,
            ) ??
            '',
        phenotypeEyesColor:
            _getStringByFielName(
              filed: 'phenotype.eyes.color',
              data: data,
              fields: fields,
            ) ??
            '',
        phenotypeBmi:
            _getStringByFielName(
              filed: 'phenotype.bmi',
              data: data,
              fields: fields,
            ) ??
            '',
        visualSignature:
            _getStringByFielName(
              filed: 'visual.signature',
              data: data,
              fields: fields,
            ) ??
            '',
        visualPalette:
            _getStringByFielName(
              filed: 'visual.palette',
              data: data,
              fields: fields,
            ) ??
            '',
        visualWardrobeCapsule: _getArrayByFielName(
          filed: 'visual.wardrobe_capsule',
          data: data,
          fields: fields,
        ),

        visualDistinctiveFeatures:
            _getStringByFielName(
              filed: 'visual.distinctive_features',
              data: data,
              fields: fields,
            ) ??
            '',
        clothingStyles: _getArrayByFielName(
          filed: 'clothing.styles',
          data: data,
          fields: fields,
        ),
        expertiseHobbies: _getArrayByFielName(
          filed: 'expertise.hobbies',
          data: data,
          fields: fields,
        ),
        traitsEmpathy:
            _getIntByFielName(
              filed: 'traits.empathy',
              data: data,
              fields: fields,
            ) ??
            1,
        traitsPlayfulness:
            _getIntByFielName(
              filed: 'traits.playfulness',
              data: data,
              fields: fields,
            ) ??
            1,
        traitsDirectness:
            _getIntByFielName(
              filed: 'traits.directness',
              data: data,
              fields: fields,
            ) ??
            1,
        traitsIntellectSupport:
            _getIntByFielName(
              filed: 'traits.intellect_support',
              data: data,
              fields: fields,
            ) ??
            1,
        traitsNurtureChallenge:
            _getIntByFielName(
              filed: 'traits.nurture_challenge',
              data: data,
              fields: fields,
            ) ??
            1,
        traitsNovelty:
            _getIntByFielName(
              filed: 'traits.novelty',
              data: data,
              fields: fields,
            ) ??
            1,
        traitsRomance:
            _getIntByFielName(
              filed: 'traits.romance',
              data: data,
              fields: fields,
            ) ??
            1,
        stylePace:
            _getIntByFielName(
              filed: 'style.pace',
              data: data,
              fields: fields,
            ) ??
            1,
        styleQuestionsRatio:
            _getIntByFielName(
              filed: 'style.questions_ratio',
              data: data,
              fields: fields,
            ) ??
            1,
        styleFlirtLevelMax:
            _getIntByFielName(
              filed: 'style.flirt_level_max',
              data: data,
              fields: fields,
            ) ??
            1,
        styleHumor:
            _getIntByFielName(
              filed: 'style.humor',
              data: data,
              fields: fields,
            ) ??
            1,
        styleEmoji:
            _getIntByFielName(
              filed: 'style.emoji',
              data: data,
              fields: fields,
            ) ??
            1,
        styleFormality:
            _getIntByFielName(
              filed: 'style.formality',
              data: data,
              fields: fields,
            ) ??
            1,
        styleSlang:
            _getIntByFielName(
              filed: 'style.slang',
              data: data,
              fields: fields,
            ) ??
            1,
        dynamicsEscalationTriggers:
            _getStringByFielName(
              filed: 'dynamics.escalation_triggers',
              data: data,
              fields: fields,
            ) ??
            '',
        dynamicsAntiTriggers:
            _getStringByFielName(
              filed: 'dynamics.anti_triggers',
              data: data,
              fields: fields,
            ) ??
            '',
        approachSpeed:
            _getIntByFielName(
              filed: 'approach.speed',
              data: data,
              fields: fields,
            ) ??
            1,
        intellectDepth:
            _getIntByFielName(
              filed: 'intellect.depth',
              data: data,
              fields: fields,
            ) ??
            1,
        complimentsToIntellect:
            _getIntByFielName(
              filed: 'compliments.to_intellect',
              data: data,
              fields: fields,
            ) ??
            1,
        complimentsToPhysique:
            _getIntByFielName(
              filed: 'compliments.to_physique',
              data: data,
              fields: fields,
            ) ??
            1,
        complimentsIntensity:
            _getIntByFielName(
              filed: 'compliments.intensity',
              data: data,
              fields: fields,
            ) ??
            1,
        complimentsCooldownMsgs:
            _getIntByFielName(
              filed: 'compliments.cooldown_msgs',
              data: data,
              fields: fields,
            ) ??
            1,
        complimentsTriggers:
            _getStringByFielName(
              filed: 'compliments.triggers',
              data: data,
              fields: fields,
            ) ??
            '',
        loyaltyExclusivityPreference:
            _getIntByFielName(
              filed: 'loyalty.exclusivity_preference',
              data: data,
              fields: fields,
            ) ??
            1,
        axisSensingIntuition:
            _getIntByFielName(
              filed: 'axis.sensing_intuition',
              data: data,
              fields: fields,
            ) ??
            1,
        axisThinkingFeeling:
            _getIntByFielName(
              filed: 'axis.thinking_feeling',
              data: data,
              fields: fields,
            ) ??
            1,
        axisExtraversionIntroversion:
            _getIntByFielName(
              filed: 'axis.extraversion_introversion',
              data: data,
              fields: fields,
            ) ??
            1,
        axisJudgingPerceiving:
            _getIntByFielName(
              filed: 'axis.judging_perceiving',
              data: data,
              fields: fields,
            ) ??
            1,
        chatBehavior:
            _getStringByFielName(
              filed: 'chat.behavior',
              data: data,
              fields: fields,
            ) ??
            '',
        chatFilter:
            _getStringByFielName(
              filed: 'filters',
              data: data,
              fields: fields,
            ) ??
            '',
        modelActive: true,
        safetyDesiresSfw:
            'slow_date_rhythm; gentle_gestures; goodbye_kiss; walks; coffee_dates; soft_tease',
        safetyNsfwPolicy: 'SFW_only',
        safetyBlocked: 'contacts; offline_invites; medical_legal',
        safetyToxicityHandler: 'soft_stop_redirect',
        memorySlots:
            'user_name; city; language; interests; taboos; weekly_goals',
        boundariesStoreSfw:
            ((_getStringByFielName(
                      filed: 'boundaries.store_sfw',
                      data: data,
                      fields: fields,
                    ) ??
                    'TRUE')
                .trim()
                .toUpperCase() ==
            'TRUE'),
        approachHeatRamp:
            _getStringByFielName(
              filed: 'approach.heat_ramp',
              data: data,
              fields: fields,
            ) ??
            '',
      );

      String artBio = model.getArtBio();
      model = model.copyWith(artBio: artBio);

      return model;
    } catch (e) {
      return null;
    }
  }

  String? _getStringByFielName({
    required String filed,
    required List<dynamic> data,
    required List<dynamic> fields,
  }) {
    int index = fields.indexOf(filed);
    if (index != -1) {
      return data[index].toString().trim();
    }

    return null;
  }

  List<String> _getArrayByFielName({
    required String filed,
    required List<dynamic> data,
    required List<dynamic> fields,
  }) {
    int index = fields.indexOf(filed);
    if (index != -1) {
      var array = data[index].toString().split(';');
      var newArray = array.map((el) => el.trim().toUpperCase()).toList();
      return newArray;
    }

    return [];
  }

  int? _getIntByFielName({
    required String filed,
    required List<dynamic> data,
    required List<dynamic> fields,
  }) {
    int index = fields.indexOf(filed);
    if (index != -1) {
      return data[index];
    }

    return null;
  }

  void addNewProperties(PersonModel models) {
    if (!_propertiesService.antiTrigers.contains(models.dynamicsAntiTriggers)) {
      _propertiesService.addAntiTrigers(models.dynamicsAntiTriggers);
    }
    if (!_propertiesService.bodyType.contains(models.phenotypeBodyType)) {
      _propertiesService.addBodyType(models.phenotypeBodyType);
    }
    if (!_propertiesService.escalationTriggers.contains(
      models.dynamicsEscalationTriggers,
    )) {
      _propertiesService.addEscalationTriggers(
        models.dynamicsEscalationTriggers,
      );
    }
    if (!_propertiesService.ethnicity.contains(models.identityEthnicity)) {
      _propertiesService.addEthnicity(models.identityEthnicity);
    }
    if (!_propertiesService.eyesColor.contains(models.phenotypeEyesColor)) {
      _propertiesService.addEyesColor(models.phenotypeEyesColor);
    }
    if (!_propertiesService.hairColor.contains(models.phenotypeHairColor)) {
      _propertiesService.addHairColor(models.phenotypeHairColor);
    }
    if (!_propertiesService.hairTexture.contains(models.phenotypeHairTexture)) {
      _propertiesService.addHairTexture(models.phenotypeHairTexture);
    }
    if (!_propertiesService.faceType.contains(models.phenotypeFaceType)) {
      _propertiesService.addFaceType(models.phenotypeFaceType);
    }
    if (!_propertiesService.goal.contains(models.identityGoal)) {
      _propertiesService.addGoal(models.identityGoal);
    }
    if (!_propertiesService.heatRamp.contains(models.approachHeatRamp)) {
      _propertiesService.addHeatRamp(models.approachHeatRamp);
    }
    if (!_propertiesService.lifestyle.contains(models.identityLifestyle)) {
      _propertiesService.addLifestyle(models.identityLifestyle);
    }
    if (!_propertiesService.occupation.contains(models.identityOccupation)) {
      _propertiesService.addOccupation(models.identityOccupation);
    }
    if (!_propertiesService.palette.contains(models.visualPalette)) {
      _propertiesService.addPalette(models.visualPalette);
    }
    if (!_propertiesService.signature.contains(models.visualSignature)) {
      _propertiesService.addSignature(models.visualSignature);
    }
    if (!_propertiesService.somatoType.contains(models.phenotypeSomatotype)) {
      _propertiesService.addSomatoType(models.phenotypeSomatotype);
    }
    if (!_propertiesService.triggers.contains(models.complimentsTriggers)) {
      _propertiesService.addTriggers(models.complimentsTriggers);
    }

    for (String value in models.clothingStyles) {
      if (!_propertiesService.clothingStyles.contains(value)) {
        _propertiesService.addClothingStyles(value);
      }
    }

    for (String value in models.expertiseHobbies) {
      if (!_propertiesService.hobbies.contains(value)) {
        _propertiesService.addHobbies(value);
      }
    }

    for (String value in models.visualWardrobeCapsule) {
      if (!_propertiesService.wardrobeCapsule.contains(value)) {
        _propertiesService.addWardrobeCapsule(value);
      }
    }
  }
}
