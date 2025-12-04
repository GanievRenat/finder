import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:flirta/common/data/models/person_per_day/person_per_day_model.dart';
import 'package:flirta/common/data/models/persons/person_model.dart';
import 'package:flirta/common/domain/app_config.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:flirta/common/enums/gender_enums.dart';
import 'package:flirta/common/extension/extension.dart';
import 'package:flirta/common/source/database/table/match_table.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class DatingDataProvider {
  Future<Either<DatingError, List<PersonModel>>> getPartOfPersonsForDating(
    GetPartOfPersonsForDatingBody body,
  );
  Future<Either<DatingError, PersonModel>> getDetailOfPersons(
    GetDetailOfPersonBody body,
  );
  Future<Either<DatingError, bool>> likePerson(LikePersonBody body);
  Future<Either<DatingError, bool>> skipPerson(SkipPersonBody body);
  Future<Either<DatingError, bool>> undoLast(UndoLastBody body);
  List<PersonModel> getPersonsToDayByLocalStore();
  Future<void> setPersonsToDayByLocalStore(List<PersonModel> models);
  Future<List<PersonModel>> removeBlockAndLikeModels(
    String userUid,
    List<PersonModel> models,
  );
  Future<int> getSwipeCount(String userUid);
  Future<int> deleteOlderData(String userUid);
  Future<bool> clear(String userUid);
}

//**
// Поставщик данных для регистрации пользователя
// */
@Singleton(as: DatingDataProvider)
class DatingDataProviderLocal extends DatingDataProvider {
  final MatchAndBlockTable _matchAndBlockTable;
  final FirebaseFirestore _firestore;
  final SharedPreferences _sharedPreferences;
  final AppConfig _appConfig;

  DatingDataProviderLocal({
    required MatchAndBlockTable matchAndBlockTable,
    required FirebaseFirestore firestore,
    required SharedPreferences sharedPreferences,
    required AppConfig appConfig,
  }) : _matchAndBlockTable = matchAndBlockTable,
       _firestore = firestore,
       _sharedPreferences = sharedPreferences,
       _appConfig = appConfig;

  @override
  Future<Either<DatingError, List<PersonModel>>> getPartOfPersonsForDating(
    GetPartOfPersonsForDatingBody body,
  ) async {
    try {
      final List<PersonModel> result = [];
      DocumentSnapshot<Map<String, dynamic>?>? lastDoc;

      // Получаем modelId пользователей, которые были лайкнуты или заблокированы
      var blockData = await _matchAndBlockTable.allModelIds(
        userUid: body.userUid,
      );

      // Надо дополнить данные заблокированными и лайкнутыми моделями
      body = GetPartOfPersonsForDatingBody(
        filter: body.filterData,
        userUid: body.userUid,
        limit: body.limit,
        excludeIds: [...body.excludeIds, ...blockData],
      );

      // Пока не соберём targetCount
      while (result.length < body.limit) {
        Query<Map<String, dynamic>?> query = _firestore
            .collection('models')
            .limit(body.limit);

        if (lastDoc != null) {
          query = query.startAfterDocument(lastDoc);
        }

        if (body.filterData.interestedGender != Gender.none) {
          query = query.where(
            'gender',
            isEqualTo: body.filterData.interestedGender
                .getGenderForInterestedName(),
          );
        }

        final snapshot = await query.get();

        // Если данных больше нет → выходим
        if (snapshot.docs.isEmpty) {
          break;
        }

        // Фильтруем исключённые ID
        /*final filtered = snapshot.docs
            .where((doc) => !body.excludeIds.contains(doc.id))
            .map((e) => PersonModel.fromJson(e))
            .toList();*/

        final filtered = snapshot.docs
            .where((doc) => !body.excludeIds.contains(doc.id))
            .map(
              (doc) => PersonModel.fromJson(doc.data() as Map<String, dynamic>),
            )
            .toList();

        result.addAll(filtered);

        lastDoc = snapshot.docs.last;
      }

      // Возвращаем только нужное количество
      if (result.length > body.limit) {
        return Right(result.take(body.limit).toList());
      }

      return Right(result);
    } catch (e) {
      return Future.value(Left(MainDatingError()));
    }
  }

  @override
  Future<Either<DatingError, bool>> likePerson(LikePersonBody body) async {
    try {
      await _matchAndBlockTable.insertModel(
        modelId: body.person.modelId,
        isBlock: false,
        userUid: body.userUid,
      );
      return Future.value(Right(true));
    } catch (e) {
      return Future.value(Left(MainDatingError()));
    }
  }

  @override
  Future<Either<DatingError, bool>> skipPerson(SkipPersonBody body) async {
    try {
      await _matchAndBlockTable.insertModel(
        modelId: body.person.modelId,
        isBlock: true,
        userUid: body.userUid,
      );
      return Future.value(Right(true));
    } catch (e) {
      return Future.value(Left(MainDatingError()));
    }
  }

  @override
  Future<Either<DatingError, bool>> undoLast(UndoLastBody body) async {
    try {
      await _matchAndBlockTable.deleteFromBlock(userUid: body.userUid);
      return Future.value(Right(true));
    } catch (e) {
      return Future.value(Left(MainDatingError()));
    }
  }

  @override
  List<PersonModel> getPersonsToDayByLocalStore() {
    try {
      var personPerDayString =
          _sharedPreferences.getString(
            _appConfig.localKeies[LocalKeies.localPersonsPerDay] ?? '',
          ) ??
          '';
      if (personPerDayString.isNotEmpty) {
        Map<String, dynamic> personPerDayJson = json.decode(personPerDayString);
        if (personPerDayJson.isNotEmpty) {
          var pesonPerDayModel = PersonPerDayModel.fromJson(personPerDayJson);
          DateTime toDate = DateTime.fromMillisecondsSinceEpoch(
            pesonPerDayModel.toDay,
          );
          if (toDate.toDay()) {
            // Если данные за текущие сутки, то просто возвращаем их.
            return pesonPerDayModel.models;
          }
        }
      }
    } catch (e) {
      return [];
    }

    return [];
  }

  @override
  Future<void> setPersonsToDayByLocalStore(List<PersonModel> models) async {
    PersonPerDayModel perDayModel = PersonPerDayModel(
      toDay: DateTime.now().millisecondsSinceEpoch,
      models: models,
    );
    String perDayString = json.encode(perDayModel.toJson());

    await _sharedPreferences.setString(
      _appConfig.localKeies[LocalKeies.localPersonsPerDay] ?? '',
      perDayString,
    );
    return;
  }

  @override
  Future<List<PersonModel>> removeBlockAndLikeModels(
    String userUid,
    List<PersonModel> models,
  ) async {
    var blockData = await _matchAndBlockTable.allModelIds(userUid: userUid);
    List<PersonModel> newListModels = [];
    for (PersonModel personModel in models) {
      if (!blockData.contains(personModel.modelId)) {
        newListModels.add(personModel);
      }
    }
    return newListModels;
  }

  @override
  Future<int> getSwipeCount(String userUid) async {
    int count = await _matchAndBlockTable.getSwipeToDay(userUid: userUid);
    return count;
  }

  @override
  Future<int> deleteOlderData(String userUid) async {
    int count = await _matchAndBlockTable.deleteFromBlockAfterWeek(
      userUid: userUid,
    );
    return count;
  }

  @override
  Future<Either<DatingError, PersonModel>> getDetailOfPersons(
    GetDetailOfPersonBody body,
  ) async {
    try {
      var doc = await _firestore.collection('models').doc(body.modelId).get();
      if (doc.exists) {
        var personModel = PersonModel.fromJson(
          doc.data() as Map<String, dynamic>,
        );
        return Future.value(Right(personModel));
      } else {
        return Future.value(Left(MainDatingError()));
      }
    } catch (e) {
      return Future.value(Left(MainDatingError()));
    }
  }

  @override
  Future<bool> clear(String userUid) async {
    try {
      await _matchAndBlockTable.clear(userUid: userUid);
      return true;
    } catch (e) {
      return false;
    }
  }
}
