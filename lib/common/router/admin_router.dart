import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/data/models/persons/person_model.dart';
import 'package:flirta/featuries/admin/auth/pages/auth_admin_page.dart';
import 'package:flirta/featuries/admin/main/main_page.dart';
import 'package:flirta/featuries/admin/persons/pages/detail/person_detail_page.dart';
import 'package:flirta/featuries/admin/persons/pages/list/persons_admin_page.dart';
import 'package:flirta/featuries/admin/settings/pages/settings_admin_page.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

import 'package:flirta/common/di/init_di.dart';

import 'package:flirta/common/router/router.dart';
import 'package:flirta/common/service/app_state_service.dart';

import 'package:go_router/go_router.dart';

part 'routers/admin/auth_routers/auth_router.dart';
part 'routers/admin/main_routers/home_router.dart';
part 'routers/admin/main_routers/main_router.dart';

part 'admin_router.g.dart';

final GlobalKey<NavigatorState> shellNavigatorKeyAdmin =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> rootNavigatorKeyAdmin =
    GlobalKey<NavigatorState>();

@TypedGoRoute<AdminRootRoute>(path: '/')
class AdminRootRoute extends GoRouteData with $AdminRootRoute {
  const AdminRootRoute();

  @override
  String? redirect(BuildContext context, GoRouterState state) {
    try {
      if (getIt<AppStateService>().isAuth) {
        return const PersonsAdminRoute().location;
      } else {
        return const AuthAdminRoute().location;
      }
    } catch (e) {
      return const AuthAdminRoute().location;
    }
  }
}
