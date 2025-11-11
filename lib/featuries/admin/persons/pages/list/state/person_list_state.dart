part of 'person_list_cubit.dart';

@freezed
class PersonListState with _$PersonListState {
  factory PersonListState.init() = _PersonListStateInit;
  factory PersonListState.loading() = _PersonListStateLoading;
  factory PersonListState.data(List<PersonModel> data) = _PersonListStateData;
  factory PersonListState.error(PersonRepositoryError error) =
      _PersonListStateError;
}
