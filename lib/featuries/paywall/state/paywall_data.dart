part of 'paywall_cubit.dart';

class PayWallData {
  final PayWallVersion version;
  final String title;
  final String buttonTitle;
  final String trialText;
  final List<String> benefits;
  final List<SubscriptionPackage> subscriptions;

  PayWallData({
    required this.version,
    required this.title,
    required this.trialText,
    required this.buttonTitle,
    required this.benefits,
    required this.subscriptions,
  });
}
