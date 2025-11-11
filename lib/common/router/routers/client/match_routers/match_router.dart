part of '../../../client_router.dart';

@TypedGoRoute<MatchRoute>(path: MatchRoute.path, name: MatchRoute.name)
class MatchRoute extends GoRouteData with $MatchRoute {
  const MatchRoute({required this.imageUrl});

  final String imageUrl;

  static const path = '/match';
  static const name = '/match';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return Transition.matching(
      pageKey: state.pageKey,
      name: name,
      child: MatchPage(imageUrl: imageUrl),
    );
  }
}
