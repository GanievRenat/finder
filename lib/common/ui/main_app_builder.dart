import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/extension/extension.dart';
import 'package:flirta/common/service/app_state_service.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../domain/app_builder.dart';

class MainAppBuilder implements AppBuilder {
  @override
  Widget buildApp(RouterConfig<Object> routerConfig) {
    return Application(routerConfig);
  }
}

class Application extends StatelessWidget {
  const Application(this.routerConfig, {super.key});

  final RouterConfig<Object> routerConfig;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: LocaleKeys.project_name.tr(),
      theme: context.themeData,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      routerConfig: routerConfig,
      builder: (context, child) {
        getIt<AppStateService>().currentLocale = context.locale;
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.noScaling),
          child: child ?? Container(),
        );
      },
    );
  }
}
