import 'package:flutter/material.dart';

import 'theme.dart';

class AppTheme {
  AppTheme({
    required this.color,
    required this.textStyle,
    required this.themeData,
    required this.shadow,
  });

  static AppTheme darkTheme = AppTheme.initializeTheme(
    colorScheme: AppThemeColorScheme.dark,
    baseThemeData: ThemeData.dark(),
  );

  static AppTheme lightTheme = AppTheme.initializeTheme(
    colorScheme: AppThemeColorScheme.light,
    baseThemeData: ThemeData.light(),
  );

  static Iterable<AppTheme> themes = [lightTheme, darkTheme];

  bool get isDark => this == darkTheme;

  static AppTheme of(BuildContext context) {
    final brightness = MediaQueryData.fromView(
      View.of(context),
    ).platformBrightness;
    return brightness == Brightness.dark
        ? AppTheme.darkTheme
        : AppTheme.lightTheme;
  }

  final AppThemeColorScheme color;
  final AppTextTheme textStyle;
  final ThemeData themeData;
  final AppShadow shadow;

  static ThemeData _createBaseThemeData(
    AppThemeColorScheme colorScheme,
    AppTextTheme textTheme,
    ThemeData baseThemeData,
  ) => baseThemeData.copyWith(
    /*splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,*/
    scaffoldBackgroundColor: colorScheme.background,
    textTheme: textTheme.toTextTheme(),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
    switchTheme: SwitchThemeData(
      trackOutlineWidth: WidgetStatePropertyAll(0),
      trackOutlineColor: WidgetStateColor.resolveWith((states) {
        return Colors.transparent;
      }),
      thumbColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.neutralLightLightest;
        }
        return colorScheme.neutralLightLightest;
      }),
      trackColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.primaryDarkset;
        }
        return colorScheme.neutralLightDark;
      }),
      thumbIcon: WidgetStateProperty.resolveWith<Icon?>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.selected)) {
          return Icon(Icons.circle, color: Colors.white, size: 16);
        }
        return Icon(Icons.circle, color: Colors.white, size: 16);
      }),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),
    listTileTheme: ListTileThemeData(
      titleTextStyle: textTheme.header5,
      subtitleTextStyle: textTheme.bodyS,
    ),
    dividerTheme: DividerThemeData(
      color: colorScheme.neutralLightDark,
      space: 0.5,
      thickness: 0.5,
      radius: BorderRadius.circular(1),
    ),
  );

  factory AppTheme.initializeTheme({
    required AppThemeColorScheme colorScheme,
    required ThemeData baseThemeData,
  }) {
    final textTheme = AppTextTheme.byColorScheme(colorScheme);

    return AppTheme(
      color: colorScheme,
      themeData: _createBaseThemeData(colorScheme, textTheme, baseThemeData),
      textStyle: textTheme,
      shadow: AppShadow.byColorScheme(colorScheme: colorScheme),
    );
  }
}
