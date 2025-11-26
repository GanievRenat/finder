import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/featuries/chat/state/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef ChatListSuccessWidgetBuilder<T> =
    Widget Function(
      BuildContext context,
      T value,
      int countNewMessage,
      Widget? child,
    );

class ChatBuilder extends StatelessWidget {
  const ChatBuilder({
    super.key,
    required this.init,
    required this.loading,
    required this.empty,
    required this.error,
    required this.success,
  });

  final WidgetBuilder init;
  final WidgetBuilder loading;
  final WidgetBuilder empty;
  final ValueWidgetBuilder error;
  final ChatListSuccessWidgetBuilder success;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      bloc: getIt<ChatCubit>(),
      builder: (context, state) {
        return state.when(
          init: () => init(context),
          loading: () => loading(context),
          empty: () => empty(context),
          error: (errorText) => error(context, errorText, this),
          data: (List<Chat> chat, int countNew) =>
              success(context, chat, countNew, this),
        );
      },
    );
  }
}
