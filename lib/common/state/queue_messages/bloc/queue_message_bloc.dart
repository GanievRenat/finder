import 'dart:async';
import 'dart:developer';

import 'package:flirta/common/enums/enums.dart';
import 'package:flirta/common/service/remote_config_service.dart';
import 'package:flirta/common/service/secure_storage_service.dart';
import 'package:flirta/featuries/chat/state/chat_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:spicyapi_client/spicyapi_client.dart' as spacy;

import '../event/queue_messages_event.dart';
import '../state/queue_message_state.dart';

@singleton
class TickerBloc extends Bloc<TickerEvent, TickerState> {
  Timer? _timer;

  final spacy.SpacyAPIClient _spacyClient;
  final RemoteConfigService _remoteConfig;
  final SecureStorageService _secureStorageService;
  final ChatCubit _chatCubit;

  Map<String, String> queueMessages = {};

  // Локальная очередь, для скорости
  // При инициализации тикета, надо заполнить очередь.
  // Функция добавления в очередь ожидание

  TickerBloc({
    required spacy.SpacyAPIClient spacyClient,
    required RemoteConfigService remoteConfig,
    required SecureStorageService securiteStore,
    required ChatCubit chatCubit,
  }) : _spacyClient = spacyClient,
       _remoteConfig = remoteConfig,
       _chatCubit = chatCubit,
       _secureStorageService = securiteStore,
       super(const TickerState()) {
    on<TickerStarted>(_onStarted);
    on<TickerGo>(_onTickerGo);

    init();
  }

  void init() async {
    if (!_remoteConfig.isInit) {
      await _remoteConfig.init();
    }
    _spacyClient.setKey(
      key: _remoteConfig.spacyapiKey,
      clientId: _remoteConfig.spacyapiClientId,
      negativePrompt: '',
    );
  }

  void _onStarted(TickerStarted event, Emitter<TickerState> emit) {
    _timer?.cancel();

    _timer = Timer.periodic(
      const Duration(seconds: 30),
      (_) => add((TickerGo())),
    );
  }

  void _onTickerGo(TickerGo event, Emitter<TickerState> emit) {
    _doWork();

    emit(state.copyWith(tickCount: state.tickCount + 1));
  }

  void _doWork() async {
    // Получаем все события которые ожидают результат.
    // Делаем запросы по очереди.
    // Обновляем состояние каждого события.
    // Сохраняем файл, отправляем сообщение.
    // Удаляем из очереди событие.
    // Если очередь пуста, останавливаем тикер
    if (queueMessages.isNotEmpty) {
      var modelId = queueMessages.keys.first;
      var reuestId = queueMessages[modelId] ?? '';
      // Узнаем статус и
      if (reuestId.isNotEmpty) {
        var resultStatus = await _spacyClient.checkStatus(requestId: reuestId);
        if (resultStatus.isRight) {
          if (resultStatus.right.downloadUrl.isNotEmpty) {
            // Скачиваем и сохраняем фотографию
            try {
              String fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
              var file = await _secureStorageService.downloadImage(
                modelId: modelId,
                imageUrl: resultStatus.right.downloadUrl,
                fileName: fileName,
              );
              if (file.existsSync()) {
                _chatCubit.sendMessage(
                  modelId: modelId,
                  owner: Owner.person,
                  message: '',
                  images: [fileName],
                );
              }
            } catch (e) {
              log(e.toString());
            }
            queueMessages.remove(modelId);
          }
        } else {
          queueMessages.remove(modelId);
        }
      }
    }
    if (queueMessages.isEmpty) {
      _timer?.cancel();
    }
  }

  void addNewMessage({required String modelId, required String requestId}) {
    queueMessages[modelId] = requestId;
    add(TickerStarted());
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
