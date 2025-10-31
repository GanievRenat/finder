import 'package:flirta/common/data/models/models.dart';
import 'package:flirta/common/data/providers/data_providers.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:injectable/injectable.dart';
import 'package:either_dart/either.dart';

@Singleton(as: FilterRepository)
class FilterRepositoryImpl implements FilterRepository {
  final FilterDataProvider _dataProvider;

  FilterRepositoryImpl({required FilterDataProvider dataProvider})
    : _dataProvider = dataProvider;

  @override
  Future<Either<FilterError, FilterData>> getFilterState() async {
    var result = await _dataProvider.getFilterState();
    if (result.isRight) {
      var filterData = result.right.toEntites();
      return Right(filterData);
    } else {
      return Left(result.left);
    }
  }

  @override
  Future<Either<FilterError, bool>> saveFilterState(
    SaveFilterStateBody newState,
  ) async {
    var result = await _dataProvider.saveFilterState(newState);
    return result;
  }
}
