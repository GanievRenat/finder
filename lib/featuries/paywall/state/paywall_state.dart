part of 'paywall_cubit.dart';

@freezed
class PaywallState with _$PaywallState {
  factory PaywallState.init() = _PaywallStateInit;
  factory PaywallState.loading() = _PaywallStateLoading;
  factory PaywallState.data(PayWallData data) = _PaywallStateData;
  factory PaywallState.error(String errorText) = _PaywallStateError;
}
