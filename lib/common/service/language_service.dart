import 'dart:async';

import 'package:flinder/common/domain/app_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class LanguageService {
  final SharedPreferences store;
  final AppConfig config;

  LanguageService(this.store, this.config);

  final languageController = StreamController<Locale>.broadcast();

  Locale getDefaultLocale() => Locale(config.defaultLocale);
  List<Locale> getSupportedLocales() =>
      config.localies.map((l) => Locale(l)).toSet().toList();

  Future<bool> setLocale(BuildContext context, String locale) {
    var newLocal = Locale(locale);
    context.setLocale(newLocal);
    var result = store.setString('locale', locale);

    // Костыль, только из-за того что у нас данные не подгружаються с сервера.
    // Оповещение Cubit идет быстрее чем обновление locale в приложении
    // Создаем искуственную задержку, чтобы все успело поменяться
    Future.delayed(Duration(milliseconds: 500), () {
      languageController.add(newLocal);
    });

    return result;
  }

  Locale loadLocale() {
    String currentLocale = store.getString('locale') ?? '';
    if (currentLocale.isNotEmpty) {
      if (config.localies.contains(currentLocale)) {
        return Locale(currentLocale);
      }
    }
    return getDefaultLocale();
  }
}
