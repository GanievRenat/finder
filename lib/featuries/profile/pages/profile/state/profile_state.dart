part of 'profile_cubit.dart';

@freezed
class ProfileState with _$ProfileState {
  factory ProfileState.init() = _ProfileStateInit;
  factory ProfileState.loading() = _ProfileStateLoading;
  factory ProfileState.data(User user) = _ProfileStateData;
  factory ProfileState.error(String errorText) = _ProfileStateError;
}
