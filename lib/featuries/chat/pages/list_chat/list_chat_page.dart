import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flirta/featuries/chat/pages/list_chat/fragments/chat_list_data_fragment.dart';

import 'package:flirta/featuries/chat/widget/chat_list_builder.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

import 'fragments/chat_list_error_fragment.dart';
import 'fragments/chat_list_empty_fragment.dart';
import 'fragments/chat_list_loader_fragment.dart';

class ListChatPage extends StatelessWidget {
  const ListChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          LocaleKeys.chat_title.tr(),
          style: AppTheme.of(context).textStyle.header3,
        ),
      ),
      body: ChatBuilder(
        init: (context) => ChatListLoaderFragment(),
        loading: (context) => ChatListLoaderFragment(),
        empty: (context) => ChatListEmptyFragment(),
        error: (context, value, child) =>
            ChatListErrorFragment(error: value.toString()),
        success: (context, value, countNew, child) =>
            ChatListDataFragment(chat: value, onDetailChat: (chat) {}),
      ),
    );
  }
}
