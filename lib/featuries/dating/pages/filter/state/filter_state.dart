part of 'filter_cubit.dart';

@freezed
class FilterState with _$FilterState {
  factory FilterState.init() = _FilterStateInit;
  factory FilterState.loading() = _FilterStateLoading;
  factory FilterState.data(FilterData data, int timeStaemp) = _FilterStateData;
  factory FilterState.error(FilterError error) = _FilterStateError;
}
