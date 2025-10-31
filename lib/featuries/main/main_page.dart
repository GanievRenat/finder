import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/ui/theme/theme.dart';
import 'package:flirta/generated/assets.gen.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Assets.images.icons.homeIconBottomMenu.image(
                width: AppSpacing.s7,
                color: navigationShell.currentIndex == 0
                    ? AppTheme.of(context).color.neutralDarkDarkset
                    : AppTheme.of(context).color.neutralLightDark,
              ),
              label: LocaleKeys.bottom_menu_0.tr(),
            ),
            BottomNavigationBarItem(
              icon: Assets.images.icons.chatIconBottomMenu.image(
                width: AppSpacing.s7,
                color: navigationShell.currentIndex == 1
                    ? AppTheme.of(context).color.neutralDarkDarkset
                    : AppTheme.of(context).color.neutralLightDark,
              ),
              label: LocaleKeys.bottom_menu_1.tr(),
            ),
            BottomNavigationBarItem(
              icon: Assets.images.icons.profileIconBottomMenu.image(
                width: AppSpacing.s7,
                color: navigationShell.currentIndex == 2
                    ? AppTheme.of(context).color.neutralDarkDarkset
                    : AppTheme.of(context).color.neutralLightDark,
              ),
              label: LocaleKeys.bottom_menu_2.tr(),
            ),
          ],
          currentIndex: navigationShell.currentIndex,
          onTap: (int index) => _onTap(context, index),
        ),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
