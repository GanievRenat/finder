import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/ui/theme/theme.dart';
import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flirta/generated/assets.gen.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class ChatListEmptyFragment extends StatelessWidget {
  const ChatListEmptyFragment({super.key, required this.onDating});

  final Function() onDating;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Spacer(),
          Assets.images.icons.emptyChat.svg(),
          AppSpacing.vertical.s8,
          Text(
            LocaleKeys.chat_messages_empty_title.tr(),
            textAlign: TextAlign.center,
            style: AppTheme.of(context).textStyle.header2.copyWith(
              color: AppTheme.of(context).color.neutralDarkDarkset,
            ),
          ),
          AppSpacing.vertical.s1,
          Text(
            LocaleKeys.chat_messages_empty_subtitle.tr(),
            textAlign: TextAlign.center,
            style: AppTheme.of(context).textStyle.bodyL.copyWith(
              color: AppTheme.of(context).color.neutralDarkLight,
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: MainButton(
              title: LocaleKeys.chat_messages_empty_button.tr(),
              onPressed: () => onDating(),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
