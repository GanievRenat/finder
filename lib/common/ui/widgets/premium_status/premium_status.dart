import 'package:flinder/common/ui/theme/app_theme.dart';
import 'package:flinder/generated/assets.gen.dart';
import 'package:flutter/material.dart';

class PremiumStatus extends StatelessWidget {
  const PremiumStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
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
                      'PRO plan activated',
                      style: AppTheme.of(context).textStyle.header3.copyWith(
                        color: AppTheme.of(context).color.neutralLightLightest,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Enjoy all premium features',
                      style: AppTheme.of(context).textStyle.bodyM.copyWith(
                        color: AppTheme.of(context).color.neutralLightLightest,
                      ),
                    ),
                  ],
                ),
              ),
              Assets.images.icons.starsPro.svg(width: 24),
            ],
          ),
        ),
      ),
    );
  }
}
