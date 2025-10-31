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

  FilterData currentFilterData = FilterData.empty();
  FilterData forUpdateFilterData = FilterData.empty();

  FilterCubit({
    required GetFilterState getFilterState,
    required SaveFilterState saveFilterState,
  }) : _getFilterState = getFilterState,
       _saveFilterState = saveFilterState,
       super(FilterState.init());

  Future<void> init() async {
    emit(FilterState.loading());
    var result = await _getFilterState();
    if (result.isRight) {
      currentFilterData = result.right;
      forUpdateFilterData = result.right;
      emit(FilterState.data(currentFilterData));
    } else {
      emit(FilterState.error(result.left));
    }
  }

  Future<void> saveState() async {
    var result = await _saveFilterState(forUpdateFilterData);
    if (result.isRight) {
      emit(FilterState.data(forUpdateFilterData));
      currentFilterData = forUpdateFilterData;
    } else {
      emit(FilterState.error(result.left));
    }
  }

  void setNewInterestedGender(Gender gender) {
    forUpdateFilterData.copyWith(interestedGender: gender);
  }

  void setNewSelectTags(Set<String> selectTags) {
    forUpdateFilterData.copyWith(selectTags: selectTags.toList());
  }
}
