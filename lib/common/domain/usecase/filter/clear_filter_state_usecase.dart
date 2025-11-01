import 'package:either_dart/either.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:injectable/injectable.dart';

@singleton
class ClearFilterState {
  final FilterRepository _filterRepository;

  ClearFilterState({required FilterRepository filterRepository})
    : _filterRepository = filterRepository;

  Future<Either<FilterError, bool>> call() async {
    var result = await _filterRepository.saveFilterState(
      SaveFilterStateBody(filter: FilterData.empty()),
    );
    return result;
  }
}
