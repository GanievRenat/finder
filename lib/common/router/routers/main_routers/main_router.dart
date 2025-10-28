part of '../../app_router.dart';

@TypedShellRoute<MainRoute>(
  routes: [
    TypedGoRoute<HomeRoute>(path: HomeRoute.path),
    TypedGoRoute<ProfileRoute>(
      path: ProfileRoute.path,
      routes: [
        TypedGoRoute<EditProfileRoute>(
          path: EditProfileRoute.path,
          name: EditProfileRoute.name,
        ),
        TypedGoRoute<NotificationSettingsRoute>(
          path: NotificationSettingsRoute.path,
          name: NotificationSettingsRoute.name,
        ),
      ],
    ),
  ],
)
class MainRoute extends ShellRouteData {
  const MainRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  static final GlobalKey<NavigatorState> $navigatorKey = shellNavigatorKey;

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) =>
      navigator;
}
