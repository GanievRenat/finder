import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/domain/usecase/usecases.dart';
import 'package:flirta/common/service/analytics/events.dart';
import 'package:flirta/common/service/services.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/featuries/chat/state/chat_cubit.dart';
import 'package:flirta/featuries/dating/pages/dating/state/dating_cubit.dart';
import 'package:flirta/featuries/dating/pages/filter/state/filter_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../domain/app_builder.dart';
import '../domain/app_runner.dart';
import '../state/global_main_bloc_state.dart';

class MainAppRunner implements AppRunner {
  final String env;

  MainAppRunner({required this.env});

  @override
  Future<void> preloadData() async {
    // init app
    WidgetsFlutterBinding.ensureInitialized();

    await EasyLocalization.ensureInitialized();

    await Firebase.initializeApp();

    // init di
    await initDi(env);
    // init config

    getIt<CrashlyticsService>().init();
    await getIt<AnalyticsService>().init();

    AuthInitService(
      getProfile: getIt<GetProfile>(),
      auth: (user) async {
        // Добавить все что надо проинициализировать если пользователь авторизован
        getIt<CrashlyticsService>().setUserId(user.uid, properties: null);
        await getIt<FilterCubit>().init();
        await getIt<DatingCubit>().init();
        await getIt<ChatCubit>().init();
      },
      noAuth: () async {
        // Добавить все что надо проинициализировать если пользователь НЕ авторизован
      },
    );

    unawaited(getIt<AnalyticsService>().logEvent(OnStartApp()));
  }

  @override
  Future<void> run(AppBuilder appBuilder) async {
    await preloadData();
    final router = getIt<GoRouter>();
    final languageService = getIt<LanguageService>();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
      _,
    ) {
      runApp(
        EasyLocalization(
          supportedLocales: languageService.getSupportedLocales(),
          path: 'assets/translations',
          fallbackLocale: languageService.getDefaultLocale(),
          startLocale: languageService.loadLocale(),
          child: GlobalMainBlocState(child: appBuilder.buildApp(router)),
        ),
      );
    });
  }
}
