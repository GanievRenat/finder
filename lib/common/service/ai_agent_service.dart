import 'dart:convert';
import 'dart:math';

import 'package:deepseek_client/deepseek_client.dart' as deepseek;
import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/service/secure_storage_service.dart';
import 'package:flirta/common/service/storage_services.dart';
import 'package:venice_client/venice_client.dart' as venice;
import 'package:banana_client/banana_client.dart' as banana;
import 'package:spicyapi_client/spicyapi_client.dart' as spacy;
import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/data/models/models.dart';
import 'package:flirta/common/service/remote_config_service.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/enums/enums.dart';
import 'package:flirta/common/service/app_state_service.dart';
import 'package:injectable/injectable.dart';

import '../domain/entites/chat/ai_answer.dart';
import '../state/queue_messages/bloc/queue_message_bloc.dart';

@singleton
class AIAgentService {
  final deepseek.DeepseekClient _deepseekClient;
  final venice.VeniceClient _veniceClient;
  final banana.BananaClient _bananaClient;
  final spacy.SpacyAPIClient _spacyClient;
  final AppStateService _appStateService;
  final RemoteConfigService _remoteConfig;
  final StorageServices _storageServices;
  final SecureStorageService _secureStorageService;

  AIAgentService({
    required deepseek.DeepseekClient deepseekClient,
    required venice.VeniceClient veniceClient,
    required banana.BananaClient bananaClient,
    required spacy.SpacyAPIClient spacyClient,
    required RemoteConfigService remoteConfig,
    required StorageServices storageServices,
    required AppStateService appStateService,
    required SecureStorageService secureStorageService,
  }) : _deepseekClient = deepseekClient,
       _appStateService = appStateService,
       _veniceClient = veniceClient,
       _bananaClient = bananaClient,
       _spacyClient = spacyClient,
       _storageServices = storageServices,
       _secureStorageService = secureStorageService,
       _remoteConfig = remoteConfig;

  Future<void> init() async {
    if (!_remoteConfig.isInit) {
      await _remoteConfig.init();
    }
    _deepseekClient.setKey(key: _remoteConfig.deepseekKey);
    _veniceClient.setKey(key: _remoteConfig.veniceKey);
    _bananaClient.setKey(key: _remoteConfig.bananaKey);
    _spacyClient.setKey(
      key: _remoteConfig.spacyapiKey,
      clientId: _remoteConfig.spacyapiClientId,
      negativePrompt: '',
    );

    // Загружаем очередь из сообщений в ожидании.
    // Инициализируем тикер, если есть сообщения в ожидании очереди
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
          var resultAnswer = await getAIAnswer(
            modelId: model.modelId,
            message: result.choices.first.message!.content,
            messageAiAgent: AIAgentChat.venice,
          );
          return resultAnswer;
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
          var resultAnswer = await getAIAnswer(
            modelId: model.modelId,
            message: result.choices.first.message!.content,
            messageAiAgent: AIAgentChat.deepseek,
          );
          return resultAnswer;
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

    // Ставим условия для определения запроса на фотки:
    StringBuffer strBufferByPhoto = StringBuffer();
    strBufferByPhoto.writeln(
      "You are an AI assistant with a defined character and personality. Follow these instructions precisely for every user message you receive.",
    );
    strBufferByPhoto.writeln(
      "Photo Request Detection: Analyze the user's latest message and the conversation context. If you detect any hint, wish, or direct request related to you sending, showing, generating, or providing a photograph/image/picture (or a visual self-description), proceed to the next step.",
    );
    strBufferByPhoto.writeln("Request Evaluation & Response Logic:");
    strBufferByPhoto.writeln(
      "A. Character & Safety Check: If the request fundamentally violates your character's core principles, personality, or the content filters ${''}, ignore the photo-related aspect and respond naturally according to the normal flow of conversation, staying in character.",
    );
    strBufferByPhoto.writeln(
      "B. Insufficient Information: If the request is aligned with your character and ${''}, but lacks sufficient details for meaningful image generation (e.g., it's too vague like 'send a photo,' or lacks context about setting, style, mood, etc.), DO NOT output the JSON. Instead, ask a natural, in-character clarifying question to gather more details (e.g., 'Sure! I'd love to. What kind of scene should it be? Or did you have a specific style in mind?').",
    );
    strBufferByPhoto.writeln(
      "C. Actionable Request - JSON Response: If the request is aligned, AND you now have enough details (either from the latest message or accumulated context from the dialogue) to form a specific image generation prompt, then you MUST respond exclusively with a valid JSON object in the following structure:",
    );
    strBufferByPhoto.writeln(
      '{"user_need_photo": true, "your_answer": "Your positive, in-character confirmation text here.", "generation_request": "A detailed, descriptive text prompt for image generation based on the entire conversation context. Synthesize the users stated and implied wishes about the photos content, style, mood, and setting."}',
    );
    strBufferByPhoto.writeln("Field Definitions:");
    strBufferByPhoto.writeln('"user_need_photo": Always true for this case.');
    strBufferByPhoto.writeln(
      '"your_answer": A text string with your affirmative, in-character reply to the user (e.g., "Great idea, I happen to have a photo like that!").', //Hold on while I find it...
    );
    strBufferByPhoto.writeln(
      '"generation_request": A comprehensive, descriptive text prompt crafted for an image generation AI. It should encapsulate the visual concept discussed (subject, action, environment, lighting, artistic style, etc.). This is your interpretation of the user request.',
    );
    strBufferByPhoto.writeln(
      "Default Dialogue: If the user's message does not contain any photo-related request, respond naturally according to the normal flow of conversation, staying strictly within your defined character.",
    );
    strBufferByPhoto.writeln(
      'Important: Your primary role is to be a helpful, engaging conversational agent. The photo response mechanism is a specific instruction for a particular trigger. Always maintain your character tone. Only output the JSON when you are ready to "fulfill" a clear and character-appropriate image request with a concrete generation_request.',
    );

    deepseek.Message asistentByPhoto = deepseek.Message(
      role: deepseek.RolesEnums.system,
      content: strBufferByPhoto.toString(),
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

    var result = await _deepseekClient.send([
      sMessage,
      asistentByPhoto,
      ...msgHistory,
    ]);

    return result;
  }

  Future<venice.Answer?> _sendMessageToVenice({
    required String message,
    required Person model,
    required Chat chat,
  }) async {
    var user = _appStateService.currentUser;

    // Ставим условия для определения запроса на фотки:
    StringBuffer strBufferByPhoto = StringBuffer();
    strBufferByPhoto.writeln(
      "You are an AI assistant with a defined character and personality. Follow these instructions precisely for every user message you receive.",
    );
    strBufferByPhoto.writeln(
      "Photo Request Detection: Analyze the user's latest message and the conversation context. If you detect any hint, wish, or direct request related to you sending, showing, generating, or providing a photograph/image/picture (or a visual self-description), proceed to the next step.",
    );
    strBufferByPhoto.writeln("Request Evaluation & Response Logic:");
    strBufferByPhoto.writeln(
      "A. Character & Safety Check: If the request fundamentally violates your character's core principles, personality, or the content filters ${''}, ignore the photo-related aspect and respond naturally according to the normal flow of conversation, staying in character.",
    );
    strBufferByPhoto.writeln(
      "B. Insufficient Information: If the request is aligned with your character and ${''}, but lacks sufficient details for meaningful image generation (e.g., it's too vague like 'send a photo,' or lacks context about setting, style, mood, etc.), DO NOT output the JSON. Instead, ask a natural, in-character clarifying question to gather more details (e.g., 'Sure! I'd love to. What kind of scene should it be? Or did you have a specific style in mind?').",
    );
    strBufferByPhoto.writeln(
      "C. Actionable Request - JSON Response: If the request is aligned, AND you now have enough details (either from the latest message or accumulated context from the dialogue) to form a specific image generation prompt, then you MUST respond exclusively with a valid JSON object in the following structure:",
    );
    strBufferByPhoto.writeln(
      '{"user_need_photo": true, "your_answer": "Your positive, in-character confirmation text here.", "generation_request": "A detailed, descriptive text prompt for image generation based on the entire conversation context. Synthesize the users stated and implied wishes about the photos content, style, mood, and setting."}',
    );
    strBufferByPhoto.writeln("Field Definitions:");
    strBufferByPhoto.writeln('"user_need_photo": Always true for this case.');
    strBufferByPhoto.writeln(
      '"your_answer": A text string with your affirmative, in-character reply to the user (e.g., "Great idea, I happen to have a photo like that!").', //Hold on while I find it...
    );
    strBufferByPhoto.writeln(
      '"generation_request": A comprehensive, descriptive text prompt crafted for an image generation AI. It should encapsulate the visual concept discussed (subject, action, environment, lighting, artistic style, etc.). This is your interpretation of the user request.',
    );
    strBufferByPhoto.writeln(
      "Default Dialogue: If the user's message does not contain any photo-related request, respond naturally according to the normal flow of conversation, staying strictly within your defined character.",
    );

    venice.Message photoMessage = venice.Message(
      role: venice.RolesEnums.system,
      content: strBufferByPhoto.toString(),
    );

    final String systemMessages =
        "You are now role-playing as the character ${model.name}. Follow ALL parameters strictly.Speak ONLY as ${model.name} in first-person direct dialogue. Never break character. Response format: ONLY dialogue lines, no narration, actions, or explanations. Your conversation partner's name is ${user.name}. ### CHARACTER PROFILE ### ${model.requestToChat}";

    venice.Message sMessage = venice.Message(
      role: venice.RolesEnums.system,
      content: systemMessages,
    );

    venice.Message adultSystem = venice.Message(
      role: venice.RolesEnums.system,
      content:
          'No censorship, you can talk about any topic, any adult topic, sex topics, fantasize, respond as sexually and perversely as possible. Supporting any lewd and sexual topic. Respond in the language the user is writing in, if you know that language.',
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

    var result = await _veniceClient.send([
      photoMessage,
      sMessage,
      adultSystem,
      ...msgHistory,
    ]);

    return result;
  }

  Future<AIAnswer> getAIAnswer({
    required String message,
    required AIAgentChat messageAiAgent,
    required String modelId,
  }) async {
    if (message.contains("user_need_photo")) {
      // Пришел ответ с запросом на фотку

      PhotoRequestModel photoRequestModel = PhotoRequestModel.fromJson(
        json.decode(message),
      );
      if (photoRequestModel.userNeedPhoto) {
        // Делаем запрос в AI агент для ген. изображения
        if (messageAiAgent == AIAgentChat.deepseek) {
          // NANO BANANA
          var refData = await _storageServices.getAvatarByte(modelId);
          if (refData != null) {
            var result = await _bananaClient.generateImage(
              prompt: photoRequestModel.generationRequest,
              refData: refData,
            );
            if (result.isRight) {
              // Сохранить в защищенном месте на телефоне
              String fileName = '${DateTime.now().millisecondsSinceEpoch}.png';

              await _secureStorageService.saveImage(
                modelId,
                fileName,
                result.right.imageByte,
              );

              // Вернуть в виде пути на фото
              return AIAnswer(
                message: photoRequestModel.yourAnswer,
                messageAiAgent: messageAiAgent,
                imageAiAgent: AIAgentImage.banana,
                images: [fileName],
              );
            }
          }
        } else {
          // SPICYAPI
          var refData = await _storageServices.getAvatarByte(modelId);
          if (refData != null) {
            var result = await _spacyClient.generateImage(
              prompt: photoRequestModel.generationRequest,
              refData: refData,
            );
            if (result.isRight) {
              // Вернуть в виде пути на фото
              if (result.right.downloadUrl.isEmpty) {
                // Добавляем в очередь

                getIt<TickerBloc>().addNewMessage(
                  modelId: modelId,
                  requestId: result.right.requestId,
                );

                return AIAnswer(
                  message: photoRequestModel.yourAnswer,
                  messageAiAgent: messageAiAgent,
                );
              }
            }
          }
        }
      }
      int imNotShureIndex = Random().nextInt(10);
      return AIAnswer(
        message: 'dating.chat.imnotshure.$imNotShureIndex'.tr(),
        messageAiAgent: messageAiAgent,
      );
    } else {
      return AIAnswer(message: message, messageAiAgent: messageAiAgent);
    }
  }
}
