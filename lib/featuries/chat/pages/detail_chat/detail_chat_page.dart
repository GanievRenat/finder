import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/domain/usecase/usecases.dart';
import 'package:flirta/featuries/chat/state/chat_cubit.dart';
import 'package:flirta/generated/assets.gen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'state/detail_chat_cubit.dart';
import 'widget/app_bar_chat.dart';
import 'widget/detail_chat_builder.dart';
import 'widget/fragments/chat_detail_data_fragment.dart';
import 'widget/fragments/chat_detail_error_fragment.dart';
import 'widget/fragments/chat_detail_loader_fragment.dart';

class DetailChatPage extends StatelessWidget {
  DetailChatPage({
    super.key,
    required this.modelId,
    required this.onDetailPerson,
    required this.onPhotoGallery,
    required this.onSliderPhoto,
    required this.onPayWall,
  });

  final String modelId;
  final Function({required Person person}) onDetailPerson;
  final Function({required Person person}) onPhotoGallery;
  final Function({required String fileName, required String modelId})
  onSliderPhoto;
  final Future<bool> Function() onPayWall;

  final GlobalKey _chatListKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailChatCubit(
        modelId: modelId,
        getDetailOfPerson: getIt<GetDetailOfPerson>(),
        chatCubit: getIt<ChatCubit>(),
      ),
      child: KeyboardDismissOnTap(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBarChat(
            onPersonDetail: onDetailPerson,
            onPhotoGallery: onPhotoGallery,
          ),
          body: DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Assets.images.bgChat.provider(),
                fit: BoxFit.cover,
              ),
            ),
            child: DetailChatBuilder(
              init: (context) => ChatDetailLoaderFragment(),
              loading: (context) => ChatDetailLoaderFragment(),
              error: (context, value, child) =>
                  ChatDetailErrorFragment(error: value.toString()),
              success: (context, value, child) => ChatDetailDataFragment(
                key: _chatListKey,
                modelId: modelId,
                onSliderPhoto: onSliderPhoto,
                onPayWall: () async {
                  var result = await onPayWall();
                  if (result && context.mounted) {
                    BlocProvider.of<DetailChatCubit>(context).getDetailChat();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
