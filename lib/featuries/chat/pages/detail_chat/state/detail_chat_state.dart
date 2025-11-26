part of 'detail_chat_cubit.dart';

@freezed
class DetailChatState with _$DetailChatState {
  factory DetailChatState.init() = _DetailChatStateInit;
  factory DetailChatState.loading() = _DetailChatStateLoading;
  factory DetailChatState.data(List<Messages> chatList) = _ChatStateData;
  factory DetailChatState.empty() = _DetailChatStateEmpty;
  factory DetailChatState.error(String errorText) = _DetailChatStateError;
}
