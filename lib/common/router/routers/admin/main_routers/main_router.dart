part of '../../../admin_router.dart';

class PersonBranchData extends StatefulShellBranchData {
  static List<NavigatorObserver> $observers = [getIt<MainAnalyticsObserver>()];

  const PersonBranchData();
}

class SettingsBranchData extends StatefulShellBranchData {
  static List<NavigatorObserver> $observers = [getIt<MainAnalyticsObserver>()];

  const SettingsBranchData();
}

@TypedStatefulShellRoute<MainAdminRoute>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<PersonBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<PersonsAdminRoute>(
          path: PersonsAdminRoute.path,
          name: PersonsAdminRoute.name,
          routes: [
            TypedGoRoute<PersonDetailAdminRoute>(
              path: PersonDetailAdminRoute.path,
              name: PersonDetailAdminRoute.name,
              routes: [
                TypedGoRoute<AlertDialogDeleteModelRoute>(
                  path: AlertDialogDeleteModelRoute.path,
                  name: AlertDialogDeleteModelRoute.name,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<SettingsBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<SettingsAdminRoute>(
          path: SettingsAdminRoute.path,
          name: SettingsAdminRoute.name,
        ),
      ],
    ),
  ],
)
class MainAdminRoute extends StatefulShellRouteData {
  const MainAdminRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey =
      rootNavigatorKeyAdmin;
  static final GlobalKey<NavigatorState> $navigatorKey = shellNavigatorKeyAdmin;

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return ScaffoldWithSideNav(navigationShell: navigationShell);
  }
}
