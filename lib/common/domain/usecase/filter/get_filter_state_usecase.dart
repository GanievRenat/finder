import 'package:either_dart/either.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetFilterState {
  final FilterRepository _filterRepository;

  GetFilterState({required FilterRepository filterRepository})
    : _filterRepository = filterRepository;

  Future<Either<FilterError, FilterData>> call() async {
    var result = await _filterRepository.getFilterState();
    return result;
  }
}
