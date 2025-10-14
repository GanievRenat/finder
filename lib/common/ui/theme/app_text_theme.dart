import 'package:flutter/material.dart';

import 'app_theme_color_scheme.dart';

class AppTextTheme extends TextTheme {
  const AppTextTheme({
    required this.header1,
    required this.header2,
    required this.header3,
    required this.header4,
    required this.header3Light,
    required this.counter,
    required this.primaryLightText,
    required this.primaryText,
    required this.labelLightText,
    required this.labelRegularText,
  }) : super();

  factory AppTextTheme.byColorScheme(AppThemeColorScheme colorScheme) =>
      AppTextTheme(
        header1: AppThemeTextStyle(colorScheme).merge(
          TextStyle(
            fontFamily: 'Roboto',
            color: colorScheme.neutralDarkDarkset,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            fontSize: 48,
            height: 48 / 48,
          ),
        ),
        header2: AppThemeTextStyle(colorScheme).merge(
          TextStyle(
            fontFamily: 'Roboto',
            color: colorScheme.neutralDarkDarkset,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.normal,
            fontSize: 32,
            height: 28 / 32,
          ),
        ),
        header3: AppThemeTextStyle(colorScheme).merge(
          TextStyle(
            fontFamily: 'Roboto',
            color: colorScheme.neutralDarkDarkset,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.normal,
            fontSize: 34,
            height: 40 / 34,
          ),
        ),
        header4: AppThemeTextStyle(colorScheme).merge(
          TextStyle(
            fontFamily: 'Roboto',
            color: colorScheme.neutralDarkDark,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            fontSize: 20,
            height: 28 / 20,
          ),
        ),
        header3Light: AppThemeTextStyle(colorScheme).merge(
          TextStyle(
            fontFamily: 'Roboto',
            color: colorScheme.neutralLightDark,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.normal,
            fontSize: 20,
            height: 28 / 20,
          ),
        ),
        counter: AppThemeTextStyle(colorScheme).merge(
          TextStyle(
            fontFamily: 'Roboto',
            color: colorScheme.neutralDarkDark,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            fontSize: 24,
            height: 24 / 24,
          ),
        ),
        primaryText: AppThemeTextStyle(colorScheme).merge(
          TextStyle(
            fontFamily: 'Roboto',
            color: colorScheme.neutralDarkDark,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 16,
            height: 28 / 16,
          ),
        ),
        primaryLightText: AppThemeTextStyle(colorScheme).merge(
          TextStyle(
            fontFamily: 'Roboto',
            color: colorScheme.neutralDarkDark,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.normal,
            fontSize: 16,
            height: 28 / 16,
          ),
        ),
        labelRegularText: AppThemeTextStyle(colorScheme).merge(
          TextStyle(
            fontFamily: 'Roboto',
            color: colorScheme.neutralDarkDark,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            fontSize: 12,
            height: 16 / 12,
          ),
        ),
        labelLightText: AppThemeTextStyle(colorScheme).merge(
          TextStyle(
            fontFamily: 'Roboto',
            color: colorScheme.neutralDarkDark,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.normal,
            fontSize: 12,
            height: 16 / 12,
          ),
        ),
      );

  final AppThemeTextStyle header1;
  final AppThemeTextStyle header2;
  final AppThemeTextStyle header3;
  final AppThemeTextStyle header4;
  final AppThemeTextStyle header3Light;
  final AppThemeTextStyle counter;
  final AppThemeTextStyle primaryText;
  final AppThemeTextStyle primaryLightText;
  final AppThemeTextStyle labelLightText;
  final AppThemeTextStyle labelRegularText;

  TextTheme toTextTheme() {
    return TextTheme(
      displayLarge: header1,
      displayMedium: header2,
      displaySmall: header3,
      headlineMedium: header4,
      headlineSmall: header3Light,
      titleLarge: counter,
      bodyLarge: primaryText,
      bodyMedium: primaryLightText,
      labelLarge: labelRegularText,
      labelSmall: labelLightText,
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
