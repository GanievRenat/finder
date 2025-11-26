part of 'chat_cubit.dart';

@freezed
class ChatState with _$ChatState {
  factory ChatState.init() = _ChatStateInit;
  factory ChatState.loading() = _ChatStateLoading;
  factory ChatState.data(List<Chat> chatList, int countNoReadMessage) =
      _ChatStateData;
  factory ChatState.empty() = _ChatStateEmpty;
  factory ChatState.error(String errorText) = _ChatStateError;
}
