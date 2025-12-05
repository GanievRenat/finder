import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class PaywallErrorFragment extends StatelessWidget {
  const PaywallErrorFragment({super.key, required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        error,
        style: AppTheme.of(
          context,
        ).textStyle.bodyM.copyWith(color: AppTheme.of(context).color.error),
      ),
    );
  }
}
