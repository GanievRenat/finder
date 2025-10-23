import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

import 'title_chat_app_bar.dart';

class ChatAppBar extends AppBar {
  ChatAppBar({
    super.key,
    required String imageURL,
    required String modelName,
    required Function onProfile,
    required Function onPhoto,
  }) : super(
         title: TitleChatAppBar(imageURL: imageURL, modelName: modelName),
         actions: [
           PopupMenuButton<int>(
             onSelected: (int item) {
               if (item == 1) onProfile();
               if (item == 2) onPhoto();
             },
             itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
               PopupMenuItem<int>(
                 value: 1,
                 padding: EdgeInsets.only(
                   right: 48,
                   left: 16,
                   top: 16,
                   bottom: 16,
                 ),
                 child: Text(LocaleKeys.chat_menu_0.tr()),
               ),
               PopupMenuItem<int>(
                 value: 2,
                 padding: EdgeInsets.only(
                   right: 48,
                   left: 16,
                   bottom: 16,
                   top: 16,
                 ),
                 child: Text(LocaleKeys.chat_menu_1.tr()),
               ),
             ],
           ),
         ],
       );
}
