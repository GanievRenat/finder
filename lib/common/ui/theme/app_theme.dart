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
    inputDecorationTheme: InputDecorationTheme(
      // Толщина нижней линии
      border: UnderlineInputBorder(
        borderSide: BorderSide(width: 1.0, color: colorScheme.neutralLightDark),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(width: 1.0, color: colorScheme.neutralLightDark),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(width: 1.0, color: colorScheme.primaryDarkset),
      ),
      // Цвет выделенного состояния
      focusColor: colorScheme.primaryDarkset,
      // Цвет ошибки
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(width: 1.0, color: colorScheme.error),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(width: 2.0, color: colorScheme.error),
      ),
      errorStyle: textTheme.bodyXL.copyWith(color: colorScheme.error),
      hintStyle: textTheme.bodyXL,
      labelStyle: textTheme.bodyXL,
      // Размер текста
      contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.background,
      foregroundColor: colorScheme.onBackground,
      actionsPadding: EdgeInsets.all(0),
      titleTextStyle: textTheme.header3,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: colorScheme.background,
      elevation: 4,
      shadowColor: colorScheme.shadow,
      labelTextStyle: WidgetStatePropertyAll(textTheme.actionL),
      position: PopupMenuPosition.under,
      menuPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    menuTheme: MenuThemeData(
      style: MenuStyle(padding: WidgetStatePropertyAll(EdgeInsets.all(16))),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      enableFeedback: false,
      backgroundColor: colorScheme.background,
      selectedItemColor: colorScheme.neutralDarkDarkset,
      unselectedItemColor: colorScheme.neutralDarkLight,
      selectedLabelStyle: textTheme.actionS.copyWith(
        color: colorScheme.neutralDarkDarkset,
      ),
      unselectedLabelStyle: textTheme.bodyXS.copyWith(
        color: colorScheme.neutralDarkLight,
      ),
      type: BottomNavigationBarType.fixed,
      selectedIconTheme: IconThemeData(
        size: AppSpacing.s8,
        color: colorScheme.neutralDarkDarkset,
      ),
      unselectedIconTheme: IconThemeData(
        size: AppSpacing.s8,
        color: colorScheme.neutralLightDark,
      ),
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
