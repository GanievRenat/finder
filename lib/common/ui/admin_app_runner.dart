import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/domain/usecase/usecases.dart';
import 'package:flirta/common/service/analytics/events.dart';
import 'package:flirta/common/service/auth_init_admin_service.dart';
import 'package:flirta/common/service/properties_service.dart';
import 'package:flirta/common/service/secure_storage_service.dart';
import 'package:flirta/common/service/services.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../domain/app_builder.dart';
import '../domain/app_runner.dart';
import '../state/global_main_bloc_state.dart';

class AdminAppRunner implements AppRunner {
  final String env;

  AdminAppRunner({required this.env});

  @override
  Future<void> preloadData() async {
    // init app
    WidgetsFlutterBinding.ensureInitialized();

    await EasyLocalization.ensureInitialized();
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyB-dbDurmfE0nGg5yYyHdREHgBKpn8DU4c",
        authDomain: "flirta-3e6b0.firebaseapp.com",
        projectId: "flirta-3e6b0",
        storageBucket: "flirta-3e6b0.firebasestorage.app",
        messagingSenderId: "150185515407",
        appId: "1:150185515407:web:2e1a647d5cc5d9f49153fa",
        measurementId: "G-E3L5TXLD1V",
      ),
    );

    // init di
    await initDi(env);
    // init config

    getIt<CrashlyticsService>().init();
    await getIt<AnalyticsService>().init();
    await getIt<PropertiesService>().loadAllProperties();
    await getIt<SecureStorageService>().init();

    AuthInitAdminService(
      initAdmin: getIt<InitAdmin>(),
      auth: (user) async {
        // Добавить все что надо проинициализировать если пользователь авторизован
        getIt<CrashlyticsService>().setUserId(user.uid, properties: null);
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
