import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:flirta/common/domain/usecase/usecases.dart';
import 'package:flirta/common/enums/enums.dart';
import 'package:flirta/common/service/ai_agent_service.dart';
import 'package:flirta/common/state/queue_messages/bloc/queue_message_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:venice_client/common/di/init_di.dart';

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
    required SetReadChat setReadChat,
  }) : _cretaeNewChat = cretaeNewChat,
       _getChatList = getChatList,
       _sendMessageToChat = sendMessageToChat,
       _detailOfPerson = detailOfPerson,
       _aiAgentService = aiAgentService,
       _setReadChat = setReadChat,
       super(ChatState.init());

  final CreateNewChat _cretaeNewChat;
  final GetChatList _getChatList;
  final SendMessageToChat _sendMessageToChat;
  final GetDetailOfPerson _detailOfPerson;
  final AIAgentService _aiAgentService;
  final SetReadChat _setReadChat;

  List<Chat> _chatList = [];

  Map<String, bool> typingStatus = {};
  Map<String, bool> sendingPhotoStatus = {};

  Future<void> init() async {
    updateChatList(loadingStatus: true);
  }

  void setReadChat(String modelId) async {
    await _setReadChat(modelId);
    updateChatList(loadingStatus: false);
  }

  Future<void> newChat({required Person person}) async {
    // Надо проверить, возможно уже существует чат с этой моделью

    int index = _chatList.indexWhere((c) => c.modelId == person.modelId);
    if (index == -1) {
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
  }

  void updateChatList({required bool loadingStatus}) async {
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

      _chatList.sort((a, b) => b.lastUpdate.compareTo(a.lastUpdate));

      var photoList = getIt<TickerBloc>().queueMessages;

      emit(
        ChatState.data(
          _chatList
              .map(
                (e) => e.copyWith(
                  waitingAnswer: typingStatus[e.modelId] ?? false,
                  waitingPhoto: photoList[e.modelId] != null ? true : false,
                ),
              )
              .toList(),
          countNoReadMessage,
        ),
      );
    } else {
      emit(ChatState.error(result.left.errorText));
    }
  }

  bool setWaitingStatus(String modelId, bool status) {
    int index = _chatList.indexWhere((item) => item.modelId == modelId);

    if (index != -1) {
      /*var updatedItem = _chatList[index].copyWith(waitingAnswer: status);
      _chatList[index] = updatedItem;

      int countNoReadMessage = _chatList
          .where((chat) => chat.countNewMessage > 0)
          .length;
      emit(ChatState.data(_chatList, countNoReadMessage));
      */
      typingStatus[modelId] = status;

      return true;
    }
    typingStatus[modelId] = false;
    //updateChatList(loadingStatus: false);
    return false;
  }

  bool setWaitingPhotoStatus(String modelId, bool status) {
    int index = _chatList.indexWhere((item) => item.modelId == modelId);

    if (index != -1) {
      /*var updatedItem = _chatList[index].copyWith(waitingPhoto: status);
      _chatList[index] = updatedItem;

      int countNoReadMessage = _chatList
          .where((chat) => chat.countNewMessage > 0)
          .length;
      emit(ChatState.data(_chatList, countNoReadMessage));*/

      sendingPhotoStatus[modelId] = status;

      return true;
    }
    sendingPhotoStatus[modelId] = false;
    return false;
  }

  // Написать сообщение в конкретный чат (отправить запрос на сервер)
  void sendMessage({
    required String modelId,
    required String message,
    List<String> images = const [],
    Owner owner = Owner.you,
  }) async {
    await _sendMessageToChat(
      AddNewMessageBody(
        modelId: modelId,
        owner: owner,
        message: message,
        images: images,
      ),
    );

    if (owner == Owner.you) {
      var resultDetailPerson = await _detailOfPerson(modelId);
      if (resultDetailPerson.isRight) {
        // надо найти чат
        var result = _chatList.where((c) => c.modelId == modelId);
        if (result.isNotEmpty) {
          setWaitingStatus(modelId, true);

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
                        setWaitingStatus(modelId, false);
                        updateChatList(loadingStatus: false);
                      })
                      .onError((error, stackTrace) {
                        setWaitingStatus(modelId, false);
                        updateChatList(loadingStatus: false);
                      });
                }
              })
              .onError((error, stackTrace) {
                setWaitingStatus(modelId, false);
                updateChatList(loadingStatus: false);
              });
        }
      } else {
        setWaitingStatus(modelId, false);
        updateChatList(loadingStatus: false);
      }
    }
    updateChatList(loadingStatus: false);
  }
}
