import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:flirta/common/domain/usecase/usecases.dart';
import 'package:flirta/common/enums/enums.dart';
import 'package:flirta/common/service/app_state_service.dart';
import 'package:flirta/common/service/ai_agent_service.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'chat_state.dart';
part 'chat_cubit.freezed.dart';

@singleton
class ChatCubit extends Cubit<ChatState> {
  ChatCubit({
    required CreateNewChat cretaeNewChat,
    required GetChatList getChatList,
    required SendMessageToChat sendMessageToChat,
    required GetDetailOfPerson detailOfPerson,
    required AIAgentService aiAgentService,
    required AppStateService appStateService,
  }) : _cretaeNewChat = cretaeNewChat,
       _getChatList = getChatList,
       _sendMessageToChat = sendMessageToChat,
       _detailOfPerson = detailOfPerson,
       _aiAgentService = aiAgentService,
       super(ChatState.init());

  final CreateNewChat _cretaeNewChat;
  final GetChatList _getChatList;
  final SendMessageToChat _sendMessageToChat;
  final GetDetailOfPerson _detailOfPerson;
  final AIAgentService _aiAgentService;

  List<Chat> _chatList = [];

  Future<void> init() async {
    updateChatList(loadingStatus: true);
  }

  void newChat({required Person person}) async {
    // Надо проверить, возможно уже существует чат с этой моделью

    // Создали новый чат
    var result = await _cretaeNewChat(person);
    // Надо добавить в него первое сообщение
    if (result.isRight) {
      int messageNumber = Random().nextInt(15);

      // Делаем иммитацию первого сообщения от модели
      await _sendMessageToChat(
        AddNewMessageBody(
          modelId: person.modelId,
          owner: Owner.person,
          message: 'dating.chat.first_welcome_message.$messageNumber'.tr(),
          images: [],
        ),
      );

      // Обновить список чатов
      updateChatList(loadingStatus: false);
    } else {
      emit(ChatState.error(result.left.errorText));
    }
  }

  void updateChatList({
    required bool loadingStatus,
    String modelId = '',
    bool waitingStatus = false,
  }) async {
    if (loadingStatus) {
      emit(ChatState.loading());
    }

    var result = await _getChatList();
    if (result.isRight) {
      _chatList = result.right;

      if (_chatList.isEmpty) {
        emit(ChatState.empty());
        return;
      }

      int countNoReadMessage = result.right
          .where((chat) => chat.countNewMessage > 0)
          .length;

      if (modelId.isNotEmpty) {
        _setWaitingStatus(modelId, waitingStatus);
      }

      _chatList.sort((a, b) => b.lastUpdate.compareTo(a.lastUpdate));

      emit(ChatState.data(_chatList, countNoReadMessage));
    } else {
      emit(ChatState.error(result.left.errorText));
    }
  }

  bool _setWaitingStatus(String modelId, bool status) {
    int index = _chatList.indexWhere((item) => item.modelId == modelId);

    if (index != -1) {
      var updatedItem = _chatList[index].copyWith(waitingAnswer: status);
      _chatList[index] = updatedItem;

      return true;
    }
    return false;
  }

  // Написать сообщение в конкретный чат (отправить запрос на сервер)
  void sendMessage({
    required String modelId,
    required String message,
    List<String> images = const [],
  }) async {
    await _sendMessageToChat(
      AddNewMessageBody(
        modelId: modelId,
        owner: Owner.you,
        message: message,
        images: images,
      ),
    );
    updateChatList(loadingStatus: false, modelId: modelId, waitingStatus: true);

    var resultDetailPerson = await _detailOfPerson(modelId);
    if (resultDetailPerson.isRight) {
      // надо найти чат
      var result = _chatList.where((c) => c.modelId == modelId);
      if (result.isNotEmpty) {
        _aiAgentService
            .sendMessage(
              message: message,
              model: resultDetailPerson.right,
              chat: result.first,
            )
            .then((value) {
              if (value.result != AIAgentResultAnswer.error) {
                _sendMessageToChat(
                      AddNewMessageBody(
                        modelId: modelId,
                        owner: Owner.person,
                        message: value.message,
                        images: value.images,
                      ),
                    )
                    .then((value) {
                      updateChatList(
                        loadingStatus: false,
                        modelId: modelId,
                        waitingStatus: false,
                      );
                    })
                    .onError((error, stackTrace) {
                      _setWaitingStatus(modelId, false);
                    });
              }
            })
            .onError((error, stackTrace) {
              _setWaitingStatus(modelId, false);
            });
      }
    } else {
      _setWaitingStatus(modelId, false);
    }
  }

  // После успешной отправки в чат, нужен сервис который зарегистрирует callback с ответом.
  // callback должен быть привязан к чату, он может быть только один.
  // Если был отправлен новый запрос, то старый callback должен быть прерван новым.
}

// Получить диалог из чата
/*Future<SuccessDataState> getMessage(String modelId) async {
    var result = await _getChatList();

    if (result.isRight) {
      int countNoReadMessage = result.right
          .where((chat) => chat.countNewMessage > 0)
          .length;

      _chatList = result.right;
      emit(ChatState.data(_chatList, countNoReadMessage));

      // Модель
      var person = _personMap[modelId];
      if (person == null) {
        var resultDetailPerson = await _getDetailOfPerson(modelId);
        if (resultDetailPerson.isRight) {
          _personMap[modelId] = resultDetailPerson.right;
          person = resultDetailPerson.right;
        }
      }

      // списо диалогов
    }
  }*/

class SuccessDataState {
  List<Messages> chatList;
  Person person;
  SuccessDataState({required this.person, required this.chatList});
}
