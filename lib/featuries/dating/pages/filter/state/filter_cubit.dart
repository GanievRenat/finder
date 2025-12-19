import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:flirta/common/domain/usecase/usecases.dart';
import 'package:flirta/common/enums/enums.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'filter_state.dart';
part 'filter_cubit.freezed.dart';

@lazySingleton
class FilterCubit extends Cubit<FilterState> {
  final GetFilterState _getFilterState;
  final SaveFilterState _saveFilterState;
  final ClearFilterState _clearFilterState;

  FilterData currentFilterData = FilterData.empty();
  FilterData forUpdateFilterData = FilterData.empty();

  FilterCubit({
    required GetFilterState getFilterState,
    required SaveFilterState saveFilterState,
    required ClearFilterState clearFilterState,
  }) : _getFilterState = getFilterState,
       _saveFilterState = saveFilterState,
       _clearFilterState = clearFilterState,
       super(FilterState.init());

  Future<void> init() async {
    emit(FilterState.loading());
    var result = await _getFilterState();
    if (result.isRight) {
      currentFilterData = result.right;
      forUpdateFilterData = result.right;
      emit(
        FilterState.data(
          currentFilterData,
          DateTime.now().millisecondsSinceEpoch,
        ),
      );
    } else {
      emit(FilterState.error(result.left));
    }
  }

  Future<void> saveState() async {
    var result = await _saveFilterState(forUpdateFilterData);
    if (result.isRight) {
      emit(
        FilterState.data(
          forUpdateFilterData,
          DateTime.now().millisecondsSinceEpoch,
        ),
      );
      currentFilterData = forUpdateFilterData;
    } else {
      emit(FilterState.error(result.left));
    }
  }

  Future<void> clearState() async {
    var result = await _clearFilterState();
    if (result.isRight) {
      currentFilterData = currentFilterData.copyWith(
        interestedGender: Gender.none,
        selectTags: [],
      );
      forUpdateFilterData = currentFilterData;
      emit(
        FilterState.data(
          currentFilterData,
          DateTime.now().millisecondsSinceEpoch,
        ),
      );
    }
  }

  void setNewInterestedGender(Gender gender) {
    forUpdateFilterData = forUpdateFilterData.copyWith(
      interestedGender: gender,
    );
  }

  void setNewSelectTags(Set<String> selectTags) {
    forUpdateFilterData = forUpdateFilterData.copyWith(
      selectTags: selectTags.toList(),
    );
  }

  void setNewAgeRang(int start, int finish) {
    forUpdateFilterData = forUpdateFilterData.copyWith(
      ageStart: start,
      ageFinish: finish,
    );
  }
}
