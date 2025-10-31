part of '../../app_router.dart';

class HomeBranchData extends StatefulShellBranchData {
  static List<NavigatorObserver> $observers = [getIt<MainAnalyticsObserver>()];

  const HomeBranchData();
}

class ChatBranchData extends StatefulShellBranchData {
  static List<NavigatorObserver> $observers = [getIt<MainAnalyticsObserver>()];

  const ChatBranchData();
}

class ProfileBranchData extends StatefulShellBranchData {
  static List<NavigatorObserver> $observers = [getIt<MainAnalyticsObserver>()];

  const ProfileBranchData();
}

@TypedStatefulShellRoute<MainRoute>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<HomeBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<HomeRoute>(
          path: HomeRoute.path,
          name: HomeRoute.name,
          routes: [
            TypedGoRoute<FiltersRoute>(
              path: FiltersRoute.path,
              name: FiltersRoute.name,
            ),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<ChatBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<ChatsRoute>(path: ChatsRoute.path, name: ChatsRoute.name),
      ],
    ),
    TypedStatefulShellBranch<ProfileBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<ProfileRoute>(
          path: ProfileRoute.path,
          name: ProfileRoute.name,
          routes: [
            TypedGoRoute<EditProfileRoute>(
              path: EditProfileRoute.path,
              name: EditProfileRoute.name,
              routes: [
                TypedGoRoute<EditAgeProfileRoute>(
                  path: EditAgeProfileRoute.path,
                  name: EditAgeProfileRoute.name,
                ),
                TypedGoRoute<EditGenderProfileRoute>(
                  path: EditGenderProfileRoute.path,
                  name: EditGenderProfileRoute.name,
                ),
                TypedGoRoute<EditNameProfileRoute>(
                  path: EditNameProfileRoute.path,
                  name: EditNameProfileRoute.name,
                ),
                TypedGoRoute<AlertDialogDeleteProfileRoute>(
                  path: AlertDialogDeleteProfileRoute.path,
                  name: AlertDialogDeleteProfileRoute.name,
                ),
              ],
            ),
            TypedGoRoute<NotificationSettingsRoute>(
              path: NotificationSettingsRoute.path,
              name: NotificationSettingsRoute.name,
            ),
          ],
        ),
      ],
    ),
  ],
)
class MainRoute extends StatefulShellRouteData {
  const MainRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  static final GlobalKey<NavigatorState> $navigatorKey = shellNavigatorKey;

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return ScaffoldWithNavBar(navigationShell: navigationShell);
  }
}
