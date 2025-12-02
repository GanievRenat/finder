import 'package:flirta/common/data/models/models.dart';
import 'package:flirta/common/data/models/persons/person_mapper.dart';
import 'package:flirta/common/data/providers/data_providers.dart';
import 'package:flirta/common/domain/entites/person/person.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:flirta/common/service/storage_services.dart';
import 'package:injectable/injectable.dart';
import 'package:either_dart/either.dart';

@Singleton(as: DatingRepository)
class DatingRepositoryImpl implements DatingRepository {
  final DatingDataProvider _dataProvider;
  final StorageServices _storageServices;

  Map<String, Person> personsCash = {};

  DatingRepositoryImpl({
    required DatingDataProvider dataProvider,
    required StorageServices storageServices,
  }) : _dataProvider = dataProvider,
       _storageServices = storageServices;

  @override
  Future<Either<DatingError, List<Person>>> getPartOfPersonsForDating(
    GetPartOfPersonsForDatingBody body,
  ) async {
    var resultLocalStore = _dataProvider.getPersonsToDayByLocalStore();

    int newLimit = (body.limit - resultLocalStore.length);

    // меняем фильтр для запроса, с условием локальных данных
    body = GetPartOfPersonsForDatingBody(
      filter: body.filterData,
      userUid: body.userUid,
      limit: newLimit,
      excludeIds: [
        ...body.excludeIds,
        ...resultLocalStore.map((e) => e.modelId),
      ],
    );

    if (newLimit <= 0) {
      // Если лимит на сегодня уже закончился, то возвращаем то что есть.
      // Надо удалить тех, кого мы уже успели лайкнуть или заблокировать.
      var newPersonList = await _getActulePersonList(
        body.userUid,
        resultLocalStore,
      );
      return Right(newPersonList);
    }

    var result = await _dataProvider.getPartOfPersonsForDating(body);

    if (result.isRight) {
      var fullModelList = [...result.right, ...resultLocalStore];

      // Надо обновить локальные данные (сохраняем)
      await _dataProvider.setPersonsToDayByLocalStore(fullModelList);

      var newPersonList = await _getActulePersonList(
        body.userUid,
        fullModelList,
      );

      // Комбинируем данные с сервера и локальные
      return Right(newPersonList);
    } else {
      if (resultLocalStore.isNotEmpty) {
        // Если с сервером какая то ошибка но есть локальные данные,
        // то можем попробовать вернуть их.
        var newPersonList = await _getActulePersonList(
          body.userUid,
          resultLocalStore,
        );
        return Right(newPersonList);
      }
      return Left(result.left);
    }
  }

  Future<List<Person>> _getActulePersonList(
    String userUid,
    List<PersonModel> models,
  ) async {
    var newListModel = await _dataProvider.removeBlockAndLikeModels(
      userUid,
      models,
    );
    final entities = await _getPersonEntities(newListModel);
    return entities;
  }

  Future<List<Person>> _getPersonEntities(List<PersonModel> models) async {
    final entities = await Future.wait(
      models.map((e) async {
        var ent = e.toEntites();
        var photos = await _storageServices.getPhotoList(ent.modelId);
        ent = ent.copyWith(photos: photos);
        return ent;
      }),
    );
    return entities;
  }

  @override
  Future<Either<DatingError, bool>> likePerson(LikePersonBody body) async {
    var result = await _dataProvider.likePerson(body);
    return result;
  }

  @override
  Future<Either<DatingError, bool>> skipPerson(SkipPersonBody body) async {
    var result = await _dataProvider.skipPerson(body);
    return result;
  }

  @override
  Future<Either<DatingError, bool>> undoLast(UndoLastBody body) async {
    var result = await _dataProvider.undoLast(body);
    return result;
  }

  @override
  Future<int> getSwipeCount(String userUid) async {
    var result = await _dataProvider.getSwipeCount(userUid);
    return result;
  }

  @override
  Future<int> deleteOlderBlockData(String userUid) async {
    var result = await _dataProvider.deleteOlderData(userUid);
    return result;
  }

  @override
  Future<Either<DatingError, Person>> getDetailOfPerson(
    GetDetailOfPersonBody body,
  ) async {
    if (personsCash[body.modelId] != null) {
      return Right(personsCash[body.modelId]!);
    }
    var result = await _dataProvider.getDetailOfPersons(body);
    if (result.isRight) {
      var ent = result.right.toEntites();
      var photos = await _storageServices.getPhotoList(ent.modelId);
      ent = ent.copyWith(photos: photos);
      personsCash[body.modelId] = ent;
      return Right(ent);
    } else {
      return Left(result.left);
    }
  }
}
