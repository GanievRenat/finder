import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:either_dart/either.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:flirta/generated/locale_keys.g.dart';

abstract class FilterRepository {
  Future<Either<FilterError, FilterData>> getFilterState();
  Future<Either<FilterError, bool>> saveFilterState(
    SaveFilterStateBody newState,
  );
}

sealed class FilterError {
  final String errorText;
  FilterError(this.errorText);
}

class MainFilterError extends FilterError {
  MainFilterError() : super(LocaleKeys.filter_errors_main.tr());
}
