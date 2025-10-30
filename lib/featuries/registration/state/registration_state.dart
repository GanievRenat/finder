part of 'registration_cubit.dart';

@freezed
class RegistrationState with _$RegistrationState {
  factory RegistrationState.init() = _RegistrationStateInit;
  factory RegistrationState.loading() = _RegistrationStateLoading;
  factory RegistrationState.data(RegistrationData data) =
      _RegistrationStateData;
}
