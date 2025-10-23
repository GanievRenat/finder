import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flirta/common/ui/widgets/buttons/black_button.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class NoPremiumStatus extends StatelessWidget {
  const NoPremiumStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            AppTheme.of(context).color.gradientWarmEnd,
            AppTheme.of(context).color.gradientWarmBegin,
          ],
          begin: AlignmentGeometry.centerLeft,
          end: AlignmentGeometry.centerRight,
        ),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        splashColor: AppTheme.of(
          context,
        ).color.neutralLightLightest.withAlpha(50),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.properties_no_premium_banner_title.tr(),
                      style: AppTheme.of(context).textStyle.header3.copyWith(
                        color: AppTheme.of(context).color.neutralLightLightest,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      LocaleKeys.properties_no_premium_banner_subtitle.tr(),
                      style: AppTheme.of(context).textStyle.bodyM.copyWith(
                        color: AppTheme.of(context).color.neutralLightLightest,
                      ),
                    ),
                  ],
                ),
              ),
              BlackButton(
                title: LocaleKeys.properties_no_premium_banner_button.tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
