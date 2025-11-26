import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/enums/enums.dart';
import 'package:flirta/featuries/chat/pages/detail_chat/widget/message_my.dart';
import 'package:flirta/featuries/chat/pages/detail_chat/widget/message_person.dart';
import 'package:flutter/material.dart';

import '../input_message_panel.dart';

class ChatDetailDataFragment extends StatelessWidget {
  const ChatDetailDataFragment({super.key, required this.messages});

  final List<Messages> messages;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              final chatItem = messages[index];

              bool isLast = ((index + 1) < messages.length
                  ? (messages[index + 1].owner != chatItem.owner)
                  : true);

              if (chatItem.owner == Owner.person) {
                return MessagePerson(message: chatItem.message, isLast: isLast);
              } else {
                return MessageMy(message: chatItem.message, isLast: isLast);
              }
            },
            itemCount: messages.length,
          ),
        ),
        InputMessagePanel(),
      ],
    );
  }
}
