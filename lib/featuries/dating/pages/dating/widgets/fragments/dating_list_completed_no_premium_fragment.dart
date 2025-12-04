import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/ui/theme/theme.dart';
import 'package:flirta/featuries/admin/widgets/admin_widgets.dart';
import 'package:flirta/generated/assets.gen.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class DatingListCompletedNoPremiumFragment extends StatelessWidget {
  const DatingListCompletedNoPremiumFragment({
    super.key,
    required this.onRefresh,
  });

  final Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Spacer(),
          Assets.images.icons.diamond.svg(),
          AppSpacing.vertical.s8,
          Text(
            LocaleKeys.dating_messages_completed_no_premium_title.tr(),
            textAlign: TextAlign.center,
            style: AppTheme.of(context).textStyle.header2.copyWith(
              color: AppTheme.of(context).color.neutralDarkDarkset,
            ),
          ),
          AppSpacing.vertical.s1,
          Text(
            LocaleKeys.dating_messages_completed_no_premium_subtitle.tr(),
            textAlign: TextAlign.center,
            style: AppTheme.of(context).textStyle.bodyL.copyWith(
              color: AppTheme.of(context).color.neutralDarkLight,
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 64.0),
            child: GetPremiumStatusButton(onTap: () => onRefresh()),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
