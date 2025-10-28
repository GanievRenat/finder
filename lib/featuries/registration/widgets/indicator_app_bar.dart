import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class IndicatorAppBar extends StatelessWidget {
  const IndicatorAppBar({
    super.key,
    required this.totalSteps,
    required this.currentStep,
  });

  final int totalSteps;
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    return StepProgressIndicator(
      totalSteps: totalSteps,
      currentStep: currentStep,
      size: 8,
      padding: 1,
      selectedColor: AppTheme.of(context).color.primaryDarkset,
      unselectedColor: AppTheme.of(context).color.neutralLightMedium,
      roundedEdges: Radius.circular(10),
    );
  }
}
