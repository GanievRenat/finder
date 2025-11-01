import 'dart:convert';

//import 'package:easy_localization/easy_localization.dart';
import 'package:either_dart/either.dart';

import 'package:flirta/common/data/models/models.dart';
import 'package:flirta/common/domain/app_config.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class FilterDataProvider {
  Future<Either<FilterError, FilterStateModel>> getFilterState();
  Future<Either<FilterError, bool>> saveFilterState(SaveFilterStateBody body);
}

//**
// Поставщик данных для работы с фильтрами
// */
@Singleton(as: FilterDataProvider)
class FilterDataProviderLocal extends FilterDataProvider {
  final SharedPreferences _sharedPreferences;
  final AppConfig _appConfig;

  FilterDataProviderLocal({
    required SharedPreferences sharedPreferences,
    required AppConfig appConfig,
  }) : _sharedPreferences = sharedPreferences,
       _appConfig = appConfig;

  @override
  Future<Either<FilterError, FilterStateModel>> getFilterState() {
    try {
      List<String> tags = [
        "Fitness",
        "Running",
        "Yoga",
        "Cycling",
        "Swimming",
        "Hiking",
        "Skiing",
        "Climbing",
        "Martial Arts",
        "Dancing",
        "Photography",
        "Painting",
        "Music",
        "Guitar",
        "Singing",
        "Cooking",
        "Literature",
        "Theater",
        "Cinema",
        "Handmade",
        "Gaming",
        "Board Games",
        "Clubs",
        "Bars",
        "Travel",
        "Cars",
        "Motorcycles",
        "Festivals",
        "Walking",
        "Picnics",
        "Science",
        "Technology",
        "History",
        "Psychology",
        "Self-development",
        "Languages",
        "Gardening",
        "Pets",
        "Design",
        "Wine",
        "Tattoos",
        "Piercing",
        "Fashion",
        "Bodybuilding",
        "Cosplay",
        "Sensual",
        "Intimacy",
        "Affection",
        "Romance",
        "Chemistry",
      ]; /*List.generate(
        50,
        (index) => 'filter.interests_tags.$index'.tr(),
      );*/

      var localState =
          _sharedPreferences.getString(
            _appConfig.localKeies[LocalKeies.localFilterStateKey]!,
          ) ??
          '';

      if (localState.isNotEmpty) {
        Map<String, dynamic> decoded = json.decode(localState);
        FilterStateModel filterStateModel = FilterStateModel.fromJson(decoded);
        filterStateModel = filterStateModel.copyWith(tags: tags);
        return Future.value(Right(filterStateModel));
      } else {
        return Future.value(
          Right(FilterStateModel(genderIndex: 0, selectTags: [], tags: tags)),
        );
      }
    } catch (e) {
      return Future.value(Left(MainFilterError()));
    }
  }

  @override
  Future<Either<FilterError, bool>> saveFilterState(SaveFilterStateBody body) {
    try {
      var bodyStr = json.encode(body.toMap());
      _sharedPreferences.setString(
        _appConfig.localKeies[LocalKeies.localFilterStateKey]!,
        bodyStr,
      );
      return Future.value(Right(true));
    } catch (e) {
      return Future.value(Left(MainFilterError()));
    }
  }
}
