import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flirta/common/ui/widgets/animations/flip_and_grow_transition.dart';
import 'package:flirta/common/ui/widgets/animations/heartbeat_animation.dart';
import 'package:flirta/generated/assets.gen.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class HeartWidget extends StatelessWidget {
  const HeartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FlipAndGrowVerticalTransition(
      child: HeartbeatAnimation(
        childWave: Assets.images.icons.matchIcon.svg(width: 150),
        child: SizedBox(
          width: 150,
          height: 125,
          child: Stack(
            children: [
              Assets.images.icons.matchIcon.svg(width: 150),
              Align(
                alignment: AlignmentGeometry.center,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    LocaleKeys.dating_match_match.tr(),
                    style: AppTheme.of(context).textStyle.header1.copyWith(
                      color: AppTheme.of(context).color.neutralLightLightest,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
