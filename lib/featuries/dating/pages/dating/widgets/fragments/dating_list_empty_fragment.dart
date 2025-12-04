import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/ui/theme/theme.dart';
import 'package:flirta/featuries/admin/widgets/admin_widgets.dart';
import 'package:flirta/generated/assets.gen.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class DatingListEmptyFragment extends StatelessWidget {
  const DatingListEmptyFragment({super.key, required this.onRefresh});

  final Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Spacer(),
          Assets.images.icons.update.svg(),
          AppSpacing.vertical.s8,
          Text(
            LocaleKeys.dating_messages_empty_title.tr(),
            textAlign: TextAlign.center,
            style: AppTheme.of(context).textStyle.header2.copyWith(
              color: AppTheme.of(context).color.neutralDarkDarkset,
            ),
          ),
          AppSpacing.vertical.s1,
          Text(
            LocaleKeys.dating_messages_empty_subtitle.tr(),
            textAlign: TextAlign.center,
            style: AppTheme.of(context).textStyle.bodyL.copyWith(
              color: AppTheme.of(context).color.neutralDarkLight,
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: MainButton(
              title: LocaleKeys.dating_messages_empty_button.tr(),
              onPressed: () => onRefresh(),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
