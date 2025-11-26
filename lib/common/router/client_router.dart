import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/domain/entites/person/person.dart';
import 'package:flirta/common/enums/enums.dart';
import 'package:flirta/common/router/router.dart';
import 'package:flirta/common/service/app_state_service.dart';
import 'package:flirta/featuries/chat/pages/detail_chat/detail_chat_page.dart';
import 'package:flirta/featuries/chat/pages/list_chat/list_chat_page.dart';
import 'package:flirta/featuries/dating/pages/filter/filter_page.dart';

import 'package:flirta/featuries/dating/pages/dating/dating_page.dart';
import 'package:flirta/featuries/dating/pages/match/match_page.dart';
import 'package:flirta/featuries/dating/pages/person/detail_person_page.dart';
import 'package:flirta/featuries/main/main_page.dart';
import 'package:flirta/featuries/paywall/pages/paywall_page.dart';
import 'package:flirta/featuries/profile/pages/profile/edit_profile_page.dart';
import 'package:flirta/featuries/profile/pages/settings/notification_settings_page.dart';
import 'package:flirta/featuries/profile/profile.dart';
import 'package:flirta/generated/locale_keys.g.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flirta/featuries/registration/auth.dart';

part 'routers/client/auth_routers/auth_router.dart';
part 'routers/client/main_routers/home_router.dart';
part 'routers/client/main_routers/main_router.dart';
part 'routers/client/match_routers/match_router.dart';
part 'routers/client/paywall_routers/paywall_router.dart';
part 'client_router.g.dart';

final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

@TypedGoRoute<ClientRootRoute>(path: '/')
class ClientRootRoute extends GoRouteData with $ClientRootRoute {
  const ClientRootRoute();

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
