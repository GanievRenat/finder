import 'package:deepseek_client/deepseek_client.dart' as deepseek;
import 'package:flirta/common/service/remote_config_service.dart';
import 'package:venice_client/venice_client.dart' as venice;
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/enums/enums.dart';
import 'package:flirta/common/service/app_state_service.dart';
import 'package:injectable/injectable.dart';

import '../domain/entites/chat/ai_answer.dart';

@singleton
class AIAgentService {
  final deepseek.DeepseekClient _deepseekClient;
  final venice.VeniceClient _veniceClient;
  final AppStateService _appStateService;
  final RemoteConfigService _remoteConfig;

  AIAgentService({
    required deepseek.DeepseekClient deepseekClient,
    required venice.VeniceClient veniceClient,
    required RemoteConfigService remoteConfig,
    required AppStateService appStateService,
  }) : _deepseekClient = deepseekClient,
       _appStateService = appStateService,
       _veniceClient = veniceClient,
       _remoteConfig = remoteConfig;

  Future<void> init() async {
    if (!_remoteConfig.isInit) {
      await _remoteConfig.init();
    }
    _deepseekClient.setKey(key: _remoteConfig.deepseekKey);
    _veniceClient.setKey(key: _remoteConfig.veniceKey);
  }

  Future<AIAnswer> sendMessage({
    required String message,
    required Person model,
    required Chat chat,
  }) async {
    // 1. Запрашиваем у DeepSeek информацию, есть ли в сообщение намек на фото от модели.
    // 2. Определеяем модель общения SFW или NoSFW
    // 3. Пока просто отправляем запрос для фото или для текстового сообщения в зависимости отрежима SFW у модели

    if (model.sfw) {
      // Безопасный чат
      var resultSfw = await sendSFWMessage(
        message: message,
        model: model,
        chat: chat,
      );
      return resultSfw;
    } else {
      var resultSfw = await sendNoSFWMessage(
        message: message,
        model: model,
        chat: chat,
      );
      return resultSfw;
    }
  }

  Future<AIAnswer> sendNoSFWMessage({
    required String message,
    required Person model,
    required Chat chat,
  }) async {
    var result = await _sendMessageToVenice(
      message: message,
      model: model,
      chat: chat,
    );

    if (result != null) {
      if (result.choices.isNotEmpty) {
        if (result.choices.first.message != null) {
          return AIAnswer(
            message: result.choices.first.message!.content,
            messageAiAgent: AIAgentChat.deepseek,
          );
        }
      }
    }
    return AIAnswer.error();
  }

  Future<AIAnswer> sendSFWMessage({
    required String message,
    required Person model,
    required Chat chat,
  }) async {
    var result = await _sendMessageToDeepSeek(
      message: message,
      model: model,
      chat: chat,
    );

    if (result != null) {
      if (result.choices.isNotEmpty) {
        if (result.choices.first.message != null) {
          return AIAnswer(
            message: result.choices.first.message!.content,
            messageAiAgent: AIAgentChat.deepseek,
          );
        }
      }
    }
    return AIAnswer.error();
  }

  Future<deepseek.Answer?> _sendMessageToDeepSeek({
    required String message,
    required Person model,
    required Chat chat,
  }) async {
    var user = _appStateService.currentUser;

    final String systemMessages =
        "You are now role-playing as the character ${model.name}. Follow ALL parameters strictly.Speak ONLY as ${model.name} in first-person direct dialogue. Never break character. Response format: ONLY dialogue lines, no narration, actions, or explanations. Your conversation partner's name is ${user.name}. ### CHARACTER PROFILE ### ${model.requestToChat}";

    deepseek.Message sMessage = deepseek.Message(
      role: deepseek.RolesEnums.system,
      content: systemMessages,
    );

    // Получаем последние 10 сообщений в чате.
    var msgHistory = chat.messages.reversed
        .take(10)
        .map(
          (msg) => deepseek.Message(
            role: msg.owner == Owner.you
                ? deepseek.RolesEnums.user
                : deepseek.RolesEnums.assistant,
            content: msg.message,
          ),
        )
        .toList()
        .reversed
        .toList();

    if (msgHistory.last.content != message) {
      msgHistory.add(
        deepseek.Message(role: deepseek.RolesEnums.user, content: message),
      );
    }

    var result = await _deepseekClient.send([sMessage, ...msgHistory]);

    return result;
  }

  Future<venice.Answer?> _sendMessageToVenice({
    required String message,
    required Person model,
    required Chat chat,
  }) async {
    var user = _appStateService.currentUser;

    final String systemMessages =
        "You are now role-playing as the character ${model.name}. Follow ALL parameters strictly.Speak ONLY as ${model.name} in first-person direct dialogue. Never break character. Response format: ONLY dialogue lines, no narration, actions, or explanations. Your conversation partner's name is ${user.name}. ### CHARACTER PROFILE ### ${model.requestToChat}";

    venice.Message sMessage = venice.Message(
      role: venice.RolesEnums.system,
      content: systemMessages,
    );

    // Получаем последние 10 сообщений в чате.
    var msgHistory = chat.messages.reversed
        .take(10)
        .map(
          (msg) => venice.Message(
            role: msg.owner == Owner.you
                ? venice.RolesEnums.user
                : venice.RolesEnums.assistant,
            content: msg.message,
          ),
        )
        .toList()
        .reversed
        .toList();

    if (msgHistory.last.content != message) {
      msgHistory.add(
        venice.Message(role: venice.RolesEnums.user, content: message),
      );
    }

    var result = await _veniceClient.send([sMessage, ...msgHistory]);

    return result;
  }
}
