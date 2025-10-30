part of '../../app_router.dart';

class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey =
      shellNavigatorKey;

  static const path = '/home';
  static const name = '/home';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return Transition.fade(
      pageKey: state.pageKey,
      name: name,
      child: HomePage(
        onSettings: () => const ProfileRoute().push(context),
        onSingOut: () {},
      ),
    );
  }
}

class ProfileRoute extends GoRouteData with $ProfileRoute {
  const ProfileRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey =
      shellNavigatorKey;

  static const path = '/profile';
  static const name = '/profile';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return Transition.slide(
      pageKey: state.pageKey,
      name: name,
      child: ProfilePage(
        onEditProfile: () => const EditProfileRoute().push(context),
        onNotificationSettings: () =>
            const NotificationSettingsRoute().push(context),
      ),
    );
  }
}

class EditProfileRoute extends GoRouteData with $EditProfileRoute {
  const EditProfileRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey =
      shellNavigatorKey;

  static const path = 'edit-profile';
  static const name = 'edit-profile';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return Transition.slide(
      pageKey: state.pageKey,
      name: name,
      child: EditProfilePage(onDeleteProfile: () => AuthRoute().go(context)),
    );
  }
}

class NotificationSettingsRoute extends GoRouteData
    with $NotificationSettingsRoute {
  const NotificationSettingsRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey =
      shellNavigatorKey;

  static const path = 'notification-settings';
  static const name = 'notification-settings';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return Transition.slide(
      pageKey: state.pageKey,
      name: name,
      child: NotificationSettingsPage(),
    );
  }
}
