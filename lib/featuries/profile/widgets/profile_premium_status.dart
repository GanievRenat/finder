import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/service/app_state_service.dart';
import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ProfilePremiumStatus extends StatelessWidget {
  const ProfilePremiumStatus({super.key, required this.onTap});

  final Function(bool isPremiumStatus) onTap;

  @override
  Widget build(BuildContext context) {
    bool isPremium = getIt<AppStateService>().isPremium;

    if (isPremium) {
      return PremiumStatus(onTap: () => onTap(true));
    } else {
      return NoPremiumStatus(onTap: () => onTap(false));
    }
  }
}
