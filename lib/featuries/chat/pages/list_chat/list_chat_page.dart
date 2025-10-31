import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTileChatItem(
              imageURL:
                  'https://img.freepik.com/free-photo/portrait-blonde-woman-looking-photographer_23-2148348970.jpg?semt=ais_hybrid&w=740&q=80',
              modelName: 'Annette Black',
              lastMessage:
                  'Stand up for what you believ Stand up for what you believ',
              countNewMessage: 200,
            ),
            Divider(),
            ListTileChatItem(
              imageURL:
                  'https://pg11.ru/userfiles/picfullsize/img-53415-14964303316571.jpg',
              modelName: 'Jane Cooper',
              lastMessage: 'One day you’re seventeen One day you’re seventeen',
              countNewMessage: 2,
            ),
            Divider(),
            ListTileChatItem(
              imageURL:
                  'https://img.freepik.com/free-photo/attractive-positive-elegant-young-woman-cafe_23-2148071691.jpg?semt=ais_hybrid&w=740&q=80',
              modelName: 'Eleanor Pena',
              lastMessage: 'One day you’re seventeen One day you’re seventeen',
              countNewMessage: 0,
            ),
          ],
        ),
      ),
    );
  }
}
