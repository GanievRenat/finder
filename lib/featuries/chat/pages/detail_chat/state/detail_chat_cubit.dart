import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:flirta/common/domain/usecase/usecases.dart';
import 'package:flirta/common/enums/enums.dart';
import 'package:flirta/featuries/chat/state/chat_cubit.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'detail_chat_state.dart';
part 'detail_chat_cubit.freezed.dart';

class DetailChatCubit extends Cubit<DetailChatState> {
  DetailChatCubit({
    required String modelId,
    required GetDetailChat getDetailChat,
    required SendMessageToChat sendMessageToChat,
    required GetDetailOfPerson getDetailOfPerson,
    required ChatCubit chatCubit,
  }) : _getDetailChat = getDetailChat,
       _sendMessageToChat = sendMessageToChat,
       _getDetailOfPerson = getDetailOfPerson,
       _chatCubit = chatCubit,
       _modelId = modelId,
       super(DetailChatState.init()) {
    init();
  }

  final String _modelId;
  final GetDetailChat _getDetailChat;
  final SendMessageToChat _sendMessageToChat;
  final GetDetailOfPerson _getDetailOfPerson;
  final ChatCubit _chatCubit;

  Person? _person;
  List<Messages> _chatList = [];

  Future<void> init() async {
    getDetailChat();
  }

  void getDetailChat() async {
    emit(DetailChatState.loading());

    var resultDetailPerson = await _getDetailOfPerson(_modelId);
    if (resultDetailPerson.isRight) {
      _person = resultDetailPerson.right;

      if (_person != null) {
        var result = await _getDetailChat(_modelId);
        if (result.isRight) {
          _chatList = result.right;
          emit(
            DetailChatState.data(
              SuccessDataState(person: _person!, chatList: _chatList),
            ),
          );

          _chatCubit.updateChatList(loadingStatus: false);
        } else {
          emit(DetailChatState.error(result.left.errorText));
        }
      } else {
        emit(DetailChatState.error('Not found person of chat'));
      }
    } else {
      emit(DetailChatState.error(resultDetailPerson.left.errorText));
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

      if (_person == null) {
        var resultDetailPerson = await _getDetailOfPerson(_modelId);
        if (resultDetailPerson.isRight) {
          _person = resultDetailPerson.right;
        }
      }
      if (_person != null) {
        emit(
          DetailChatState.data(
            SuccessDataState(person: _person!, chatList: _chatList),
          ),
        );
        _chatCubit.updateChatList(loadingStatus: false);
      }
    } else {
      emit(DetailChatState.error(result.left.errorText));
    }
  }
}
