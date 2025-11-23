part of '../../../client_router.dart';

@TypedGoRoute<PawWallRoute>(path: PawWallRoute.path, name: PawWallRoute.name)
class PawWallRoute extends GoRouteData with $PawWallRoute {
  const PawWallRoute();

  static const path = '/paywall';
  static const name = '/paywall';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return Transition.slide(
      pageKey: state.pageKey,
      name: name,
      child: PaywallPage(),
    );
  }
}
