import 'package:flutter/material.dart';
import 'app_theme_color_scheme.dart';

class AppShadow {
  AppShadow({required this.buttonShadow});

  factory AppShadow.byColorScheme({required AppThemeColorScheme colorScheme}) =>
      AppShadow(
        buttonShadow: BoxShadow(
          color: colorScheme.shadow,
          offset: const Offset(0, 4),
          blurRadius: 8,
          spreadRadius: 0,
        ),
      );

  final BoxShadow buttonShadow;
}
