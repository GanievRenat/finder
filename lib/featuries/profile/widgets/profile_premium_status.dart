import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/service/app_state_service.dart';
import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ProfilePremiumStatus extends StatelessWidget {
  const ProfilePremiumStatus({super.key});

  @override
  Widget build(BuildContext context) {
    bool isPremium = getIt<AppStateService>().isPremium;

    if (isPremium) {
      return PremiumStatus();
    } else {
      return NoPremiumStatus();
    }
  }
}
