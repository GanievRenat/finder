import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/service/ai_agent_service.dart';
import 'package:flirta/common/service/crashlytics_service.dart';
import 'package:flirta/common/service/notification_service.dart';
import 'package:flirta/common/service/remote_config_service.dart';
import 'package:flirta/common/service/secure_storage_service.dart';
import 'package:flirta/featuries/chat/state/chat_cubit.dart';
import 'package:flirta/featuries/dating/pages/dating/state/dating_cubit.dart';
import 'package:flirta/featuries/dating/pages/filter/state/filter_cubit.dart';
import 'package:flirta/generated/locale_keys.g.dart';

class InitAuthStateService {
  static bool _init = false;

  static Future<void> initState(String userUid) async {
    if (!_init) {
      getIt<CrashlyticsService>().setUserId(userUid, properties: null);

      await getIt<RemoteConfigService>().init();
      await getIt<FilterCubit>().init();
      await getIt<DatingCubit>().init();
      await getIt<ChatCubit>().init();
      await getIt<AIAgentService>().init();

      await getIt<NotificationService>().init();

      await getIt<SecureStorageService>().init();

      //
      int value = Random().nextInt(10);
      getIt<NotificationService>().scheduleNotification(
        title: LocaleKeys.project_name.tr(),
        body: 'properties.notification_text.$value'.tr(),
      );

      _init = true;
    }
    return;
  }
}
