import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:flirta/common/domain/usecase/usecases.dart';
import 'package:flirta/common/enums/enums.dart';

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
  }) : _cretaeNewChat = cretaeNewChat,
       _getChatList = getChatList,
       _sendMessageToChat = sendMessageToChat,
       super(ChatState.init());

  final CreateNewChat _cretaeNewChat;
  final GetChatList _getChatList;
  final SendMessageToChat _sendMessageToChat;

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

  void updateChatList({required bool loadingStatus}) async {
    if (loadingStatus) {
      emit(ChatState.loading());
    }

    var result = await _getChatList();
    if (result.isRight) {
      var chatList = result.right;

      if (chatList.isEmpty) {
        emit(ChatState.empty());
        return;
      }

      int countNoReadMessage = result.right
          .where((chat) => chat.countNewMessage > 0)
          .length;

      emit(ChatState.data(chatList, countNoReadMessage));
    } else {
      emit(ChatState.error(result.left.errorText));
    }
  }
}
