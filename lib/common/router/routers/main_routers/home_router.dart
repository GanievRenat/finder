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
        onSettings: () => const SettingsRoute().push(context),
        onSingOut: () {},
      ),
    );
  }
}

class SettingsRoute extends GoRouteData with $SettingsRoute {
  const SettingsRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey =
      shellNavigatorKey;

  static const path = '/settings';
  static const name = '/settings';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return Transition.fade(
      pageKey: state.pageKey,
      name: name,
      child: SettingsPage(),
    );
  }
}

class OnboardingRoute extends GoRouteData with $OnboardingRoute {
  const OnboardingRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey =
      shellNavigatorKey;

  static const path = '/onboarding';
  static const name = '/onboarding';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return Transition.fade(
      pageKey: state.pageKey,
      name: name,
      child: OnboardingPage(onHome: () => const HomeRoute().go(context)),
    );
  }
}
