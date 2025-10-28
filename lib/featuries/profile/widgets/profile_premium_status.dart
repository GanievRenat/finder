import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ProfilePremiumStatus extends StatelessWidget {
  const ProfilePremiumStatus({super.key});

  @override
  Widget build(BuildContext context) {
    bool isPremium = false;

    if (isPremium) {
      return PremiumStatus();
    } else {
      return NoPremiumStatus();
    }
  }
}
