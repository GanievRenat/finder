import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/detail_chat_cubit.dart';

class DetailChatBuilder extends StatelessWidget {
  const DetailChatBuilder({
    super.key,
    required this.init,
    required this.loading,
    required this.error,
    required this.success,
  });

  final WidgetBuilder init;
  final WidgetBuilder loading;
  final ValueWidgetBuilder error;
  final ValueWidgetBuilder<SuccessDataState> success;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailChatCubit, DetailChatState>(
      bloc: context.read<DetailChatCubit>(),
      builder: (context, state) {
        return state.when(
          init: () => init(context),
          loading: () => loading(context),
          error: (errorText) => error(context, errorText, this),
          data: (SuccessDataState data) => success(context, data, this),
        );
      },
    );
  }
}
