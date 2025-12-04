import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/ui/theme/app_spacing.dart';
import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flirta/generated/assets.gen.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class GetPremiumStatusButton extends StatelessWidget {
  const GetPremiumStatusButton({super.key, required this.onTap});

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        gradient: LinearGradient(
          colors: [
            AppTheme.of(context).color.gradientColdEnd,
            AppTheme.of(context).color.gradientColdBegin,
          ],
          begin: AlignmentGeometry.centerLeft,
          end: AlignmentGeometry.centerRight,
        ),
      ),
      child: InkWell(
        onTap: () {
          onTap();
        },
        borderRadius: BorderRadius.circular(50),
        splashColor: AppTheme.of(
          context,
        ).color.neutralLightLightest.withAlpha(50),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                LocaleKeys.dating_messages_completed_no_premium_button.tr(),
                style: AppTheme.of(context).textStyle.actionXL.copyWith(
                  color: AppTheme.of(context).color.neutralLightLightest,
                ),
              ),
              AppSpacing.horizontal.s2,
              Assets.images.icons.logoWhite.svg(),
            ],
          ),
        ),
      ),
    );
  }
}
