import 'package:flirta/common/ui/theme/theme.dart';
import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  AppTextTheme get textStyle => AppTheme.of(this).textStyle;

  AppThemeColorScheme get color => AppTheme.of(this).color;

  ThemeData get themeData => AppTheme.of(this).themeData;

  AppShadow get shadow => AppTheme.of(this).shadow;
}
