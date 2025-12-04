import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flirta/generated/assets.gen.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class LogoFlirta extends StatelessWidget {
  const LogoFlirta({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Assets.images.icons.starsLogo.svg(width: 40),
        SizedBox(width: 8),
        ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              colors: [
                AppTheme.of(context).color.gradientWarmEnd,
                AppTheme.of(context).color.gradientWarmBegin,
              ],
              begin: AlignmentGeometry.centerLeft,
              end: AlignmentGeometry.centerRight,
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcIn,
          child: Text(
            LocaleKeys.project_name.tr(),
            style: TextStyle(fontSize: 46, fontFamily: 'Logo'),
          ),
        ),
      ],
    );
  }
}
