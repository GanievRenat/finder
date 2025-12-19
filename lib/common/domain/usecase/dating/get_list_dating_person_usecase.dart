// Получить список персонажей
//  - учитывает список block, match, filter
//  - так же снимает блок с моделей, которые были помещены более 7 дней назад.

import 'package:either_dart/either.dart';
import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/domain/repository/bodies/get_part_of_persons_for_dating_body.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:flirta/common/service/app_state_service.dart';
import 'package:flirta/featuries/dating/pages/filter/state/filter_cubit.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetListDatingPerson {
  final DatingRepository _datingRepository;
  final AppStateService _appStateService;

  GetListDatingPerson({
    required DatingRepository datingRepository,
    required AppStateService appStateService,
  }) : _datingRepository = datingRepository,
       _appStateService = appStateService;

  Future<Either<DatingError, List<Person>>> call() async {
    // Получить текущие настройки фильтров
    var filters = getIt<FilterCubit>().currentFilterData;

    var result = await _datingRepository.getPartOfPersonsForDating(
      GetPartOfPersonsForDatingBody(
        filter: filters,
        userUid: _appStateService.getUid,
        limit: _appStateService.isPremium ? 14 : 4,
      ),
    );

    return result;
  }
}
