import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:flirta/common/data/models/models.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:injectable/injectable.dart';

abstract class PromptsDataProvider {
  Future<Either<PromptRepositoryError, PromptsModel>> getPrompts(
    String document,
  );
  Future<Either<PromptRepositoryError, bool>> updatePrompts({
    required String property,
    required List<String> values,
  });
}

//**
// Поставщик данных для регистрации пользователя
// */
@Singleton(as: PromptsDataProvider)
class PropertiesDataProviderFireBase extends PromptsDataProvider {
  final FirebaseFirestore _firestore;

  PropertiesDataProviderFireBase({required FirebaseFirestore fireStore})
    : _firestore = fireStore;

  /// ✅ Коллекция, в которой хранятся модели
  CollectionReference<Map<String, dynamic>> get _propertiesCollection =>
      _firestore.collection('prompts');

  @override
  Future<Either<PropertiesRepositoryError, List<String>>> getValuesOfProperty(
    String property,
  ) async {
    try {
      final doc = await _propertiesCollection.doc(property).get();
      if (!doc.exists) {
        return Right([]);
      }
      if (doc.data() != null) {
        return Right(
          doc.data()!['value'] != null
              ? (doc.data()!['value'] as List).map((e) => e.toString()).toList()
              : [],
        );
      } else {
        return Right([]);
      }
    } catch (e) {
      return Left(MainPropertiesRepositoryError());
    }
  }

  @override
  Future<Either<PropertiesRepositoryError, bool>> saveValuesOfProperty({
    required String property,
    required List<String> values,
  }) async {
    try {
      final doc = await _propertiesCollection.doc(property).get();

      if (!doc.exists) {
        return Right(false);
      }

      await _propertiesCollection.doc(property).update({"value": values});

      return Right(true);
    } catch (e) {
      return Left(MainPropertiesRepositoryError());
    }
  }
}
