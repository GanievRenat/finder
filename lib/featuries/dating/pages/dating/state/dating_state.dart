part of 'dating_cubit.dart';

@freezed
class DatingState with _$DatingState {
  factory DatingState.init() = _DatingStateInit;
  factory DatingState.loading() = _DatingStateLoading;
  factory DatingState.data(List<Person> pesrons) = _DatingStateData;
  factory DatingState.empty() = _DatingStateEmpty;
  factory DatingState.error(String errorText) = _DatingStateError;
}
