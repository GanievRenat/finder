import 'package:flinder/common/ui/theme/app_theme.dart';
import 'package:flinder/common/ui/widgets/buttons/black_button.dart';
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
                      'Get PRO plan',
                      style: AppTheme.of(context).textStyle.header3.copyWith(
                        color: AppTheme.of(context).color.neutralLightLightest,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Access exclusive tools',
                      style: AppTheme.of(context).textStyle.bodyM.copyWith(
                        color: AppTheme.of(context).color.neutralLightLightest,
                      ),
                    ),
                  ],
                ),
              ),
              BlackButton(title: 'Upgrade'),
            ],
          ),
        ),
      ),
    );
  }
}
