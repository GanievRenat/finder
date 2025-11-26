import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:flirta/common/domain/usecase/usecases.dart';
import 'package:flirta/common/enums/enums.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'detail_chat_state.dart';
part 'detail_chat_cubit.freezed.dart';

@singleton
class DetailChatCubit extends Cubit<DetailChatState> {
  DetailChatCubit({
    required GetDetailChat getDetailChat,
    required SendMessageToChat sendMessageToChat,
  }) : _getDetailChat = getDetailChat,
       _sendMessageToChat = sendMessageToChat,
       super(DetailChatState.init());

  final GetDetailChat _getDetailChat;
  final SendMessageToChat _sendMessageToChat;

  String _modelId = '';
  List<Messages> _chatList = [];

  Future<void> init(String modelId) async {
    _modelId = modelId;
  }

  void getDetailChat() async {
    emit(DetailChatState.loading());

    var result = await _getDetailChat(_modelId);
    if (result.isRight) {
      if (result.right.isNotEmpty) {
        _chatList = result.right;
        emit(DetailChatState.data(_chatList));
      } else {
        emit(DetailChatState.empty());
      }
    } else {
      emit(DetailChatState.error(result.left.errorText));
    }
  }

  void sendMessage({
    required String message,
    List<String> images = const [],
  }) async {
    //emit(ChatState.loading());

    var result = await _sendMessageToChat(
      AddNewMessageBody(
        modelId: _modelId,
        owner: Owner.you,
        message: message,
        images: images,
      ),
    );

    if (result.isRight) {
      // Обновить список сообщений
      _chatList = result.right;
      emit(DetailChatState.data(_chatList));
    } else {
      emit(DetailChatState.error(result.left.errorText));
    }
  }
}
