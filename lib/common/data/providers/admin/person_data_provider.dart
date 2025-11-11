import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:flirta/common/data/models/models.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:injectable/injectable.dart';

abstract class PersonDataProvider {
  Future<Either<PersonRepositoryError, List<PersonModel>>> getPersonsByFilter(
    GetPersonByFilterBody body,
  );
  Future<Either<PersonRepositoryError, PersonModel?>> getById(String modelId);
  Future<Either<PersonRepositoryError, bool>> create(PersonModel newPerson);
  Future<Either<PersonRepositoryError, bool>> update(PersonModel newPerson);
  Future<Either<PersonRepositoryError, bool>> delete(String modelId);

  Future<int> getCount(GetPersonByFilterBody body);
}

//**
// Поставщик данных для регистрации пользователя
// */
@Singleton(as: PersonDataProvider)
class PersonDataProviderFireBase extends PersonDataProvider {
  final FirebaseFirestore _firestore;

  PersonDataProviderFireBase({required FirebaseFirestore fireStore})
    : _firestore = fireStore;

  /// ✅ Коллекция, в которой хранятся модели
  CollectionReference<Map<String, dynamic>> get _modelsCollection =>
      _firestore.collection('models');

  @override
  Future<Either<PersonRepositoryError, List<PersonModel>>> getPersonsByFilter(
    GetPersonByFilterBody body,
  ) async {
    Query<Map<String, dynamic>> query = _modelsCollection;

    // фильтрация по gender, если указана
    if (body.gender.isNotEmpty) {
      query = query.where('gender', isEqualTo: body.gender);
    }

    // лимит, если указан
    if (body.limit > 0) {
      query = query.limit(body.limit);
    }

    try {
      final snapshot = await query.get();

      var result = snapshot.docs
          .map((doc) => PersonModel.fromJson(doc.data()))
          .toList();

      return Right(result);
    } catch (e) {
      return Left(MainPersonRepositoryError());
    }
  }

  @override
  Future<Either<PersonRepositoryError, bool>> create(
    PersonModel newPerson,
  ) async {
    final modelId = newPerson.modelId;

    try {
      await _modelsCollection
          .doc(modelId)
          .set(newPerson.toJson(), SetOptions(merge: true));

      return Right(true);
    } catch (e) {
      return Left(MainPersonRepositoryError());
    }
  }

  @override
  Future<Either<PersonRepositoryError, bool>> update(
    PersonModel newPerson,
  ) async {
    try {
      final docRef = _modelsCollection.doc(newPerson.modelId);

      final doc = await docRef.get();
      if (!doc.exists) {
        return Left(MainPersonRepositoryError());
      }

      await docRef.update(newPerson.toJson());

      return Right(true);
    } catch (e) {
      return Left(MainPersonRepositoryError());
    }
  }

  @override
  Future<Either<PersonRepositoryError, PersonModel?>> getById(
    String modelId,
  ) async {
    try {
      final doc = await _modelsCollection.doc(modelId).get();
      if (!doc.exists) {
        return Right(null);
      }

      if (doc.data() != null) {
        return Right(PersonModel.fromJson(doc.data() as Map<String, dynamic>));
      } else {
        return Right(null);
      }
    } catch (e) {
      return Left(MainPersonRepositoryError());
    }
  }

  @override
  Future<int> getCount(GetPersonByFilterBody body) async {
    Query<Map<String, dynamic>> query = _modelsCollection;

    if (body.gender.isNotEmpty) {
      query = query.where('gender', isEqualTo: body.gender);
    }

    final aggregateQuery = await query.count().get();
    return aggregateQuery.count ?? 0;
  }

  @override
  Future<Either<PersonRepositoryError, bool>> delete(String modelId) async {
    try {
      await _modelsCollection.doc(modelId).delete();
      return Right(true);
    } catch (e) {
      return Left(MainPersonRepositoryError());
    }
  }
}
