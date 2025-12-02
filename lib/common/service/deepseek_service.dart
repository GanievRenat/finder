import 'package:deepseek_client/deepseek_client.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/enums/enums.dart';
import 'package:flirta/common/service/app_state_service.dart';
import 'package:injectable/injectable.dart';

@singleton
class DeepseekService {
  final DeepseekClient _deepseekClient;
  final AppStateService _appStateService;

  DeepseekService({
    required DeepseekClient deepseekClient,
    required AppStateService appStateService,
  }) : _deepseekClient = deepseekClient,
       _appStateService = appStateService {
    // Устанавливаем ключ
    // TODO: Сделать загрузку с RemoteConfig и установить нужный ключ
    _deepseekClient.setKey(key: 'sk-b0434e70ac79468bacdd31b09eac2582');
  }

  Future<Answer?> sendMessage({
    required String message,
    required Person model,
    required Chat chat,
  }) async {
    // Собираем промпт
    var user = _appStateService.currentUser;

    final String systemMessages =
        "You are now role-playing as the character ${model.name}. Follow ALL parameters strictly.Speak ONLY as ${model.name} in first-person direct dialogue. Never break character. Response format: ONLY dialogue lines, no narration, actions, or explanations. Your conversation partner's name is ${user.name}. ### CHARACTER PROFILE ### ${model.requestToChat}";

    Message sMessage = Message(
      role: RolesEnums.system,
      content: systemMessages,
    );

    // Получаем последние 10 сообщений в чате.
    var msgHistory = chat.messages.reversed
        .take(10)
        .map(
          (msg) => Message(
            role: msg.owner == Owner.you
                ? RolesEnums.user
                : RolesEnums.assistant,
            content: msg.message,
          ),
        )
        .toList()
        .reversed
        .toList();

    if (msgHistory.last.content != message) {
      msgHistory.add(Message(role: RolesEnums.user, content: message));
    }

    var result = await _deepseekClient.send([sMessage, ...msgHistory]);

    return result;
  }
}
