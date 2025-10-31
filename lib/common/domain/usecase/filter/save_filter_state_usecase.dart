import 'package:either_dart/either.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:injectable/injectable.dart';

@singleton
class SaveFilterState {
  final FilterRepository _filterRepository;

  SaveFilterState({required FilterRepository filterRepository})
    : _filterRepository = filterRepository;

  Future<Either<FilterError, bool>> call(FilterData filterData) async {
    var result = await _filterRepository.saveFilterState(
      SaveFilterStateBody(filter: filterData),
    );
    return result;
  }
}
