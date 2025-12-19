import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ChatListDataFragment extends StatelessWidget {
  const ChatListDataFragment({
    super.key,
    required this.chat,
    required this.onDetailChat,
  });

  final List<Chat> chat;
  final Function(Chat chat) onDetailChat;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final chatItem = chat[index];
        return ListTileChatItem(
          imageURL: chatItem.modelAvatar,
          modelName: chatItem.modelName,
          lastMessage: chatItem.lastMessage,
          image: chatItem.messages.isNotEmpty
              ? chatItem.messages.last.imageUrls.isNotEmpty
              : false,
          countNewMessage: chatItem.countNewMessage,
          onTap: () => onDetailChat(chatItem),
          waitingAnswer: chat[index].waitingAnswer,
          waitingPhoto: chat[index].waitingPhoto,
        );
      },
      itemCount: chat.length,
    );
  }
}
