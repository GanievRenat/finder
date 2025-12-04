import 'package:flutter/material.dart';

import 'app_theme_color_scheme.dart';

class AppTextTheme extends TextTheme {
  const AppTextTheme({
    required this.header1,
    required this.header2,
    required this.header3,
    required this.header4,
    required this.header5,
    required this.bodyXXL,
    required this.bodyXL,
    required this.bodyL,
    required this.bodyM,
    required this.bodyS,
    required this.bodyXS,
    required this.actionL,
    required this.actionXL,
    required this.actionM,
    required this.actionS,
    required this.captionL,
    required this.captionM,
  }) : super();

  factory AppTextTheme.byColorScheme(AppThemeColorScheme colorScheme) =>
      AppTextTheme(
        header1: AppThemeTextStyle(colorScheme).merge(
          TextStyle(
            fontFamily: 'Inter',
            color: colorScheme.neutralDarkDarkset,
            fontWeight: FontWeight.w800,
            fontStyle: FontStyle.normal,
            fontSize: 28,
            letterSpacing: 18 * 0.01,
          ),
        ),
        header2: AppThemeTextStyle(colorScheme).merge(
          TextStyle(
            fontFamily: 'Inter',
            color: colorScheme.neutralDarkDarkset,
            fontWeight: FontWeight.w800,
            fontStyle: FontStyle.normal,
            fontSize: 24,
            letterSpacing: 18 * 0.005,
          ),
        ),
        header3: AppThemeTextStyle(colorScheme).merge(
          TextStyle(
            fontFamily: 'Inter',
            color: colorScheme.neutralDarkDarkset,
            fontWeight: FontWeight.w800,
            fontStyle: FontStyle.normal,
            fontSize: 18,
            letterSpacing: 18 * 0.005,
          ),
        ),
        header4: AppThemeTextStyle(colorScheme).merge(
          TextStyle(
            fontFamily: 'Inter',
            color: colorScheme.neutralDarkDark,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            fontSize: 16,
          ),
        ),
        header5: AppThemeTextStyle(colorScheme).merge(
          TextStyle(
            fontFamily: 'Inter',
            color: colorScheme.neutralDarkDark,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            fontSize: 14,
          ),
        ),
        bodyXXL: AppThemeTextStyle(colorScheme).merge(
          TextStyle(
            fontFamily: 'Inter',
            color: colorScheme.neutralDarkDark,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 24,
            height: 24 / 18,
          ),
        ),
        bodyXL: AppThemeTextStyle(colorScheme).merge(
          TextStyle(
            fontFamily: 'Inter',
            color: colorScheme.neutralDarkDark,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 18,
            height: 24 / 18,
          ),
        ),
        bodyL: AppThemeTextStyle(colorScheme).merge(
          TextStyle(
            fontFamily: 'Inter',
            color: colorScheme.neutralDarkDark,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 16,
            height: 22 / 16,
          ),
        ),
        bodyM: AppThemeTextStyle(colorScheme).merge(
          TextStyle(
            fontFamily: 'Inter',
            color: colorScheme.neutralDarkDark,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 14,
            height: 20 / 14,
          ),
        ),
        bodyS: AppThemeTextStyle(colorScheme).merge(
          TextStyle(
            fontFamily: 'Inter',
            color: colorScheme.neutralDarkDark,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 12,
            height: 16 / 12,
            letterSpacing: 10 * 0.01,
          ),
        ),
        bodyXS: AppThemeTextStyle(colorScheme).merge(
          TextStyle(
            fontFamily: 'Inter',
            color: colorScheme.neutralDarkDark,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 10,
            height: 14 / 10,
            letterSpacing: 10 * 0.015,
          ),
        ),
        actionXL: AppThemeTextStyle(colorScheme).merge(
          TextStyle(
            fontFamily: 'Inter',
            color: colorScheme.neutralDarkDark,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.normal,
            fontSize: 20,
          ),
        ),
        actionL: AppThemeTextStyle(colorScheme).merge(
          TextStyle(
            fontFamily: 'Inter',
            color: colorScheme.neutralDarkDark,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
            fontSize: 16,
          ),
        ),
        actionM: AppThemeTextStyle(colorScheme).merge(
          TextStyle(
            fontFamily: 'Inter',
            color: colorScheme.neutralDarkDark,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
            fontSize: 14,
          ),
        ),
        actionS: AppThemeTextStyle(colorScheme).merge(
          TextStyle(
            fontFamily: 'Inter',
            color: colorScheme.neutralDarkDark,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
            fontSize: 12,
          ),
        ),
        captionL: AppThemeTextStyle(colorScheme).merge(
          TextStyle(
            fontFamily: 'Inter',
            color: colorScheme.neutralDarkDark,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
            fontSize: 12,
            letterSpacing: 10 * 0.05,
          ),
        ),
        captionM: AppThemeTextStyle(colorScheme).merge(
          TextStyle(
            fontFamily: 'Inter',
            color: colorScheme.neutralDarkDark,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
            fontSize: 10,
            letterSpacing: 10 * 0.05,
          ),
        ),
      );

  final AppThemeTextStyle header1;
  final AppThemeTextStyle header2;
  final AppThemeTextStyle header3;
  final AppThemeTextStyle header4;
  final AppThemeTextStyle header5;

  final AppThemeTextStyle bodyXXL;
  final AppThemeTextStyle bodyXL;
  final AppThemeTextStyle bodyL;
  final AppThemeTextStyle bodyM;
  final AppThemeTextStyle bodyS;
  final AppThemeTextStyle bodyXS;

  final AppThemeTextStyle actionL;
  final AppThemeTextStyle actionXL;
  final AppThemeTextStyle actionM;
  final AppThemeTextStyle actionS;

  final AppThemeTextStyle captionL;
  final AppThemeTextStyle captionM;

  TextTheme toTextTheme() {
    return TextTheme(
      displayLarge: header1,
      displayMedium: header2,
      displaySmall: header3,
      headlineMedium: header4,
      headlineSmall: header5,
      labelLarge: bodyXL,
      bodyLarge: bodyL,
      bodyMedium: bodyM,
      bodySmall: bodyS,
      labelSmall: bodyXS,
      titleLarge: actionL,
      titleMedium: actionM,
      titleSmall: actionS,
      labelMedium: captionM,
    );
  }
}

class AppThemeTextStyle extends TextStyle {
  const AppThemeTextStyle(
    this.colorScheme, {
    super.inherit,
    super.color,
    super.backgroundColor,
    super.fontFamily,
    super.fontFamilyFallback,
    super.fontSize,
    super.fontWeight,
    super.fontStyle,
    super.letterSpacing,
    super.wordSpacing,
    super.textBaseline,
    super.height,
    super.locale,
    super.foreground,
    super.background,
    super.decoration,
    super.decorationColor,
    super.decorationStyle,
    super.decorationThickness,
    super.debugLabel,
    super.shadows,
    super.fontFeatures,
  });

  final AppThemeColorScheme colorScheme;

  @override
  AppThemeTextStyle copyWith({
    bool? inherit,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextLeadingDistribution? leadingDistribution,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    List<FontVariation>? fontVariations,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
    TextOverflow? overflow,
  }) {
    return AppThemeTextStyle(
      colorScheme,
      inherit: inherit ?? this.inherit,
      color: this.foreground == null && foreground == null
          ? color ?? this.color
          : null,
      backgroundColor: this.background == null && background == null
          ? backgroundColor ?? this.backgroundColor
          : null,
      fontFamily: fontFamily ?? this.fontFamily,
      fontFamilyFallback: fontFamilyFallback ?? this.fontFamilyFallback,
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      fontStyle: fontStyle ?? this.fontStyle,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      wordSpacing: wordSpacing ?? this.wordSpacing,
      textBaseline: textBaseline ?? this.textBaseline,
      height: height ?? this.height,
      locale: locale ?? this.locale,
      foreground: foreground ?? this.foreground,
      background: background ?? this.background,
      shadows: shadows ?? this.shadows,
      fontFeatures: fontFeatures ?? this.fontFeatures,
      decoration: decoration ?? this.decoration,
      decorationColor: decorationColor ?? this.decorationColor,
      decorationStyle: decorationStyle ?? this.decorationStyle,
      decorationThickness: decorationThickness ?? this.decorationThickness,
    );
  }

  @override
  AppThemeTextStyle merge(TextStyle? other) {
    final merged = super.merge(other);

    return copyWith(
      inherit: merged.inherit,
      color: merged.color,
      backgroundColor: merged.backgroundColor,
      fontFamily: merged.fontFamily,
      fontFamilyFallback: merged.fontFamilyFallback,
      fontSize: merged.fontSize,
      fontWeight: merged.fontWeight,
      fontStyle: merged.fontStyle,
      letterSpacing: merged.letterSpacing,
      wordSpacing: merged.wordSpacing,
      textBaseline: merged.textBaseline,
      height: merged.height,
      locale: merged.locale,
      foreground: merged.foreground,
      background: merged.background,
      shadows: merged.shadows,
      fontFeatures: merged.fontFeatures,
      decoration: merged.decoration,
      decorationColor: merged.decorationColor,
      decorationStyle: merged.decorationStyle,
      decorationThickness: merged.decorationThickness,
      debugLabel: merged.debugLabel,
    );
  }
}
