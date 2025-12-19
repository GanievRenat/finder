import 'dart:async';

import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/enums/enums.dart';
import 'package:flirta/common/service/app_state_service.dart';
import 'package:flirta/common/service/secure_storage_service.dart';
import 'package:flirta/featuries/chat/pages/detail_chat/widget/message_my.dart';
import 'package:flirta/featuries/chat/pages/detail_chat/widget/message_person.dart';
import 'package:flirta/featuries/chat/state/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../input_message_panel.dart';

class ChatDetailDataFragment extends StatefulWidget {
  const ChatDetailDataFragment({
    super.key,
    required this.modelId,
    required this.onSliderPhoto,
    required this.onPayWall,
  });
  final String modelId;
  final Function({required String modelId, required String fileName})
  onSliderPhoto;
  final Function() onPayWall;

  @override
  State<ChatDetailDataFragment> createState() => _ChatDetailDataFragmentState();
}

class _ChatDetailDataFragmentState extends State<ChatDetailDataFragment> {
  final ScrollController _scrollController = ScrollController();
  List<Messages> messages = [];
  bool _waitingAnswer = false;

  void _scrollToEnd(BuildContext context) {
    /*if (_scrollController.hasClients) {
      double addPOsition =
          (_scrollController.position.maxScrollExtent >
              MediaQuery.of(context).size.height -
                  (MediaQuery.of(context).padding.bottom + kToolbarHeight + 50))
          ? MediaQuery.of(context).padding.bottom + kToolbarHeight + 50
          : 0;

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + addPOsition,
        duration: Duration(milliseconds: 1000),
        curve: Curves.easeOut,
      );
    }*/
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: Duration(milliseconds: 800),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    //Отмечаем все сообщения как прочитанные
    getIt<ChatCubit>().setReadChat(widget.modelId);
    super.deactivate();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isPremium = getIt<AppStateService>().isPremium;

    return Column(
      children: [
        Expanded(
          child: BlocBuilder<ChatCubit, ChatState>(
            bloc: getIt<ChatCubit>(),
            builder: (context, state) {
              state.mapOrNull(
                data: (value) {
                  var res = value.chatList
                      .where((chat) => chat.modelId == widget.modelId)
                      .toList();
                  if (res.isNotEmpty) {
                    messages = res.first.messages.reversed.toList();
                    _waitingAnswer = res.first.waitingAnswer;

                    Future.delayed(Duration(milliseconds: 100), () {
                      if (context.mounted) {
                        _scrollToEnd(context);
                      }
                    });
                  }
                },
              );

              return ListView.builder(
                controller: _scrollController,
                reverse: true,
                itemBuilder: (context, index) {
                  if (_waitingAnswer && index == (0)) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: MessagePerson(
                        isPremium: isPremium,
                        message: '',
                        isLast: true,
                        waiting: true,
                        onPayWall: () {},
                        onSliderPhoto: () {},
                      ),
                    );
                  }

                  int idx = _waitingAnswer ? index - 1 : index;

                  final chatItem = messages[idx];

                  bool isLastOfGroup = ((idx) < messages.length
                      ? (messages[idx].owner != chatItem.owner)
                      : true);

                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: (messages[idx] == messages.first) ? 8 : 0,
                    ),
                    child: (chatItem.owner == Owner.person)
                        ? MessagePerson(
                            isPremium: isPremium,
                            message: chatItem.message,
                            image: (chatItem.imageUrls.isNotEmpty)
                                ? getIt<SecureStorageService>().getImage(
                                    widget.modelId,
                                    chatItem.imageUrls.first,
                                  )
                                : null,
                            isLast: isLastOfGroup,
                            waiting: false,
                            onSliderPhoto: () {
                              widget.onSliderPhoto(
                                fileName: chatItem.imageUrls.first,
                                modelId: widget.modelId,
                              );
                            },
                            onPayWall: () => widget.onPayWall(),
                          )
                        : MessageMy(
                            message: chatItem.message,
                            isLast: isLastOfGroup,
                          ),
                  );
                },
                itemCount: messages.length + (_waitingAnswer ? 1 : 0),
              );
            },
          ),
        ),
        InputMessagePanel(modelId: widget.modelId),
      ],
    );
  }
}
