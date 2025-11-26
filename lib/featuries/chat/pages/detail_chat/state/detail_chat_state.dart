part of 'detail_chat_cubit.dart';

class SuccessDataState {
  List<Messages> chatList;
  Person person;
  SuccessDataState({required this.person, required this.chatList});
}

@freezed
class DetailChatState with _$DetailChatState {
  factory DetailChatState.init() = _DetailChatStateInit;
  factory DetailChatState.loading() = _DetailChatStateLoading;
  factory DetailChatState.data(SuccessDataState data) = _ChatStateData;
  factory DetailChatState.error(String errorText) = _DetailChatStateError;
}
