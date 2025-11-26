import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/ui/widgets/chat/chat_app_bar.dart';
import 'package:flutter/material.dart';

import 'detail_chat_builder.dart';

class AppBarChat extends StatelessWidget implements PreferredSizeWidget {
  const AppBarChat({
    super.key,
    required this.onPersonDetail,
    required this.onPhotoGallery,
  });

  final Function({required Person person}) onPersonDetail;
  final Function({required String modelId}) onPhotoGallery;

  @override
  Widget build(BuildContext context) {
    return DetailChatBuilder(
      init: (context) => ChatAppBar.loading(context: context),
      loading: (context) => ChatAppBar.loading(context: context),
      error: (context, value, child) => ChatAppBar.loading(context: context),
      success: (context, value, child) => ChatAppBar(
        imageURL: value.person.photos.isNotEmpty
            ? value.person.photos.first
            : '',
        modelName: value.person.name,
        onProfile: () => onPersonDetail(person: value.person),
        onPhoto: () => onPhotoGallery(modelId: value.person.modelId),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
