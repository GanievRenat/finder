import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/service/ai_agent_service.dart';
import 'package:flirta/common/service/crashlytics_service.dart';
import 'package:flirta/common/service/remote_config_service.dart';
import 'package:flirta/featuries/chat/state/chat_cubit.dart';
import 'package:flirta/featuries/dating/pages/dating/state/dating_cubit.dart';
import 'package:flirta/featuries/dating/pages/filter/state/filter_cubit.dart';

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
      _init = true;
    }
    return;
  }
}
