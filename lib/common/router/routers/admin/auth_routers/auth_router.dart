part of '../../../admin_router.dart';

@TypedGoRoute<AuthAdminRoute>(
  path: AuthAdminRoute.path,
  name: AuthAdminRoute.name,
)
class AuthAdminRoute extends GoRouteData with $AuthAdminRoute {
  const AuthAdminRoute();

  static const path = '/auth';
  static const name = '/auth';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return Transition.fade(
      pageKey: state.pageKey,
      name: name,

      child: AuthAdminPage(onHome: () => PersonsAdminRoute().go(context)),
    );
  }
}
