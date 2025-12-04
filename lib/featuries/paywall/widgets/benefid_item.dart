import 'package:flirta/common/ui/theme/app_spacing.dart';
import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flirta/generated/assets.gen.dart';
import 'package:flutter/material.dart';

class BenefidItem extends StatelessWidget {
  const BenefidItem({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Assets.images.icons.starFilled.svg(),
        AppSpacing.horizontal.s3,
        HtmlText(
          text,
          style: AppTheme.of(context).textStyle.bodyXL.copyWith(
            color: AppTheme.of(context).color.neutralLightLightest,
          ),
        ),
      ],
    );
  }
}
