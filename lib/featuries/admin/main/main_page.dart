import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/service/services.dart';
import 'package:flirta/common/ui/theme/theme.dart';
import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithSideNav extends StatelessWidget {
  const ScaffoldWithSideNav({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const double _menuWidth = 240;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: _menuWidth,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                const SizedBox(height: 24),
                Expanded(child: _buildMenu(context)),
                _buildBottom(context),
              ],
            ),
          ),
          Expanded(child: Container(child: navigationShell)),
        ],
      ),
    );
  }

  /// Заголовок/логотип меню
  Widget _buildHeader(BuildContext context) {
    return Align(alignment: AlignmentGeometry.center, child: LogoFlirta());
  }

  /// Подвал
  Widget _buildBottom(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Icon(Icons.logout),
          title: Text(LocaleKeys.admin_home_menu_logout.tr()),
          onTap: () {},
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            getIt<AppStateService>().adminUser?.email ?? '',
            style: AppTheme.of(context).textStyle.bodyS.copyWith(
              color: AppTheme.of(context).color.neutralDarkLightest,
            ),
          ),
        ),
      ],
    );
  }

  /// Элементы меню
  Widget _buildMenu(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final items = [
      _NavItemData(
        label: LocaleKeys.admin_home_menu_models.tr(),
        icon: Icons.person_2,
      ),
      _NavItemData(
        label: LocaleKeys.admin_home_menu_settings.tr(),
        icon: Icons.settings,
      ),
    ];

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final isSelected = navigationShell.currentIndex == index;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: InkWell(
            onTap: () => _onTap(context, index),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                color: isSelected
                    ? colorScheme.primaryContainer
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),

              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Icon(
                    item.icon,
                    color: isSelected
                        ? colorScheme.onPrimaryContainer
                        : colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    item.label,
                    style: TextStyle(
                      color: isSelected
                          ? colorScheme.onPrimaryContainer
                          : colorScheme.onSurfaceVariant,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

class _NavItemData {
  final String label;
  final IconData icon;
  const _NavItemData({required this.label, required this.icon});
}
