part of '../../app_router.dart';

@TypedGoRoute<AuthRoute>(path: AuthRoute.authLocation)
class AuthRoute extends GoRouteData with $AuthRoute {
  const AuthRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
  static const authLocation = '/auth';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return Transition.fade(
      pageKey: state.pageKey,
      child: AuthPage(
        onAuth: () {
          if (getIt<AppConfig>().showOnboarding) {
            // Если включена переменная, что надо показывать онбординг
            if (!getIt<AppStateService>().showedOnboarding) {
              // Если онбординг не был показан, то показываем его
              const OnboardingRoute().go(context);
              return;
            }
          }
          const HomeRoute().go(context);
        },
      ),
    );
  }
}
