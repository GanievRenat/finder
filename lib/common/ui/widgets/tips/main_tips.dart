import 'package:flirta/common/ui/theme/theme.dart';
import 'package:flutter/material.dart';

class MainTips extends StatelessWidget {
  const MainTips({super.key, required this.tips});

  final String tips;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.of(context).color.primaryLightest,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Text(tips, style: AppTheme.of(context).textStyle.header5),
    );
  }
}
