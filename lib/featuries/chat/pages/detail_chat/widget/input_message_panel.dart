import 'package:flirta/featuries/admin/widgets/admin_widgets.dart';
import 'package:flirta/featuries/chat/pages/detail_chat/state/detail_chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputMessagePanel extends StatelessWidget {
  const InputMessagePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MainButton(
        title: 'Send message',
        onPressed: () {
          context.read<DetailChatCubit>().sendMessage(message: 'Hello!');
        },
      ),
    );
  }
}
