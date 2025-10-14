import 'package:flutter/material.dart';

abstract class AppThemeColorScheme extends ColorScheme {
  const AppThemeColorScheme({
    required super.brightness,
    required this.background,
    required this.onBackground,
    required this.primaryDarkset,
    required this.primaryDark,
    required this.primaryMedium,
    required this.primaryLight,
    required this.primaryLightest,
    required this.neutralLightDarkset,
    required this.neutralLightDark,
    required this.neutralLightMedium,
    required this.neutralLightLight,
    required this.neutralLightLightest,
    required this.neutralDarkDarkset,
    required this.neutralDarkDark,
    required this.neutralDarkMedium,
    required this.neutralDarkLight,
    required this.neutralDarkLightest,
    required this.supportErrorDark,
    required this.supportErrorMedium,
    required this.supportErrorLight,
    required this.supportSuccessDark,
    required this.supportSuccessMedium,
    required this.supportSuccessLight,
    required this.supportWarningDark,
    required this.supportWarningMedium,
    required this.supportWarningLight,
    required this.red,

    required this.pushIndicator,

    required this.pushGreen,

    required this.gradientWarmBegin,
    required this.gradientWarmEnd,
    required this.gradientColdBegin,
    required this.gradientColdEnd,

    required this.shadow,
  }) : super(
         primary: primaryDarkset,
         onPrimary: neutralLightLightest,
         secondary: primaryMedium,
         onSecondary: neutralLightLightest,
         error: supportErrorDark,
         onError: neutralLightLightest,
         surface: background,
         onSurface: onBackground,
       );

  @override
  final Color background;
  @override
  final Color onBackground;

  final Color primaryDarkset;
  final Color primaryDark;
  final Color primaryMedium;
  final Color primaryLight;
  final Color primaryLightest;

  final Color neutralLightDarkset;
  final Color neutralLightDark;
  final Color neutralLightMedium;
  final Color neutralLightLight;
  final Color neutralLightLightest;

  final Color neutralDarkDarkset;
  final Color neutralDarkDark;
  final Color neutralDarkMedium;
  final Color neutralDarkLight;
  final Color neutralDarkLightest;

  final Color supportErrorDark;
  final Color supportErrorMedium;
  final Color supportErrorLight;

  final Color supportSuccessDark;
  final Color supportSuccessMedium;
  final Color supportSuccessLight;

  final Color supportWarningDark;
  final Color supportWarningMedium;
  final Color supportWarningLight;

  final Color red;

  final Color pushIndicator;

  final Color pushGreen;

  final Color gradientWarmBegin;
  final Color gradientWarmEnd;
  final Color gradientColdBegin;
  final Color gradientColdEnd;

  final Color shadow;

  static LightColorScheme light = LightColorScheme();
  static DarkColorScheme dark = DarkColorScheme();
}

class LightColorScheme extends AppThemeColorScheme {
  LightColorScheme()
    : super(
        brightness: Brightness.light,
        background: Color(0xFFFFFFFF),
        onBackground: Color(0xFF000000),

        primaryDarkset: Color(0xFF7065E4),
        primaryDark: Color(0xFF487FFF),
        primaryMedium: Color(0xFF9AA4FF),
        primaryLight: Color(0xFFDBD2FF),
        primaryLightest: Color(0xFFF2EEFF),

        neutralLightDarkset: Color(0xFFC5C6CC),
        neutralLightDark: Color(0xFFD4D6DD),
        neutralLightMedium: Color(0xFFE8E9F1),
        neutralLightLight: Color(0xFFF8F9FE),
        neutralLightLightest: Color(0xFFFFFFFF),

        neutralDarkDarkset: Color(0xFF1F2024),
        neutralDarkDark: Color(0xFF2F3036),
        neutralDarkMedium: Color(0xFF494A50),
        neutralDarkLight: Color(0xFF71727A),
        neutralDarkLightest: Color(0xFF8F9098),

        supportErrorDark: Color(0xFFED3241),
        supportErrorMedium: Color(0xFFFF616D),
        supportErrorLight: Color(0xFFFFE2E5),

        supportSuccessDark: Color(0xFF6EBD54),
        supportSuccessMedium: Color(0xFFACE26F),
        supportSuccessLight: Color(0xFFE7F4E8),

        supportWarningDark: Color(0xFFE86339),
        supportWarningMedium: Color(0xFFFFB37C),
        supportWarningLight: Color(0xFFFFF4E4),

        red: Color(0xFFEF488E),

        pushIndicator: Color(0xFFE94057),

        pushGreen: Color(0xFF23C698),

        gradientWarmBegin: Color(0xFFFF7D27),
        gradientWarmEnd: Color(0xFFEF488E),
        gradientColdBegin: Color(0xFF35C9EA),
        gradientColdEnd: Color(0xFF636FF4),

        shadow: Color(0x73675C95),
      );
}

class DarkColorScheme extends AppThemeColorScheme {
  DarkColorScheme()
    : super(
        brightness: Brightness.dark,
        background: Color(0xFFFFFFFF),
        onBackground: Color(0xFF000000),

        primaryDarkset: Color(0xFF7065E4),
        primaryDark: Color(0xFF487FFF),
        primaryMedium: Color(0xFF9AA4FF),
        primaryLight: Color(0xFFDBD2FF),
        primaryLightest: Color(0xFFF2EEFF),

        neutralLightDarkset: Color(0xFFC5C6CC),
        neutralLightDark: Color(0xFFD4D6DD),
        neutralLightMedium: Color(0xFFE8E9F1),
        neutralLightLight: Color(0xFFF8F9FE),
        neutralLightLightest: Color(0xFFFFFFFF),

        neutralDarkDarkset: Color(0xFF1F2024),
        neutralDarkDark: Color(0xFF2F3036),
        neutralDarkMedium: Color(0xFF494A50),
        neutralDarkLight: Color(0xFF71727A),
        neutralDarkLightest: Color(0xFF8F9098),

        supportErrorDark: Color(0xFFED3241),
        supportErrorMedium: Color(0xFFFF616D),
        supportErrorLight: Color(0xFFFFE2E5),

        supportSuccessDark: Color(0xFF6EBD54),
        supportSuccessMedium: Color(0xFFACE26F),
        supportSuccessLight: Color(0xFFE7F4E8),

        supportWarningDark: Color(0xFFE86339),
        supportWarningMedium: Color(0xFFFFB37C),
        supportWarningLight: Color(0xFFFFF4E4),

        red: Color(0xFFEF488E),

        pushIndicator: Color(0xFFE94057),

        pushGreen: Color(0xFF23C698),

        gradientWarmBegin: Color(0xFFFF7D27),
        gradientWarmEnd: Color(0xFFEF488E),
        gradientColdBegin: Color(0xFF35C9EA),
        gradientColdEnd: Color(0xFF636FF4),

        shadow: Color(0x73675C95),
      );
}

extension ColorFilterExtension on Color {
  ColorFilter get filter => ColorFilter.mode(this, BlendMode.srcIn);
}
