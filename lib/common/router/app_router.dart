import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/service/app_state_service.dart';

import 'package:flirta/featuries/home/pages/home/home_page.dart';
import 'package:flirta/featuries/profile/pages/profile/edit_profile_page.dart';
import 'package:flirta/featuries/profile/pages/settings/notification_settings_page.dart';
import 'package:flirta/featuries/profile/profile.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'transition.dart';

import 'package:flirta/featuries/registration/auth.dart';

part 'routers/auth_routers/auth_router.dart';
part 'routers/main_routers/home_router.dart';
part 'routers/main_routers/main_router.dart';
part 'app_router.g.dart';

final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

@TypedGoRoute<RootRoute>(path: '/')
class RootRoute extends GoRouteData with $RootRoute {
  const RootRoute();

  @override
  String? redirect(BuildContext context, GoRouterState state) {
    try {
      if (getIt<AppStateService>().isAuth) {
        return const HomeRoute().location;
      } else {
        return const AuthRoute().location;
      }
    } catch (e) {
      return const AuthRoute().location;
    }
  }
}
