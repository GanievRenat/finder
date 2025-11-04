import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flirta/generated/assets.gen.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

import 'dating_widgets.dart';

class SkipFlag extends StatelessWidget {
  const SkipFlag({
    super.key,
    required AnimationIconController skipAnimationController,
    required StreamController<Offset> shiftStreamController,
  }) : _skipAnimationController = skipAnimationController,
       _shiftStreamController = shiftStreamController;

  final AnimationIconController _skipAnimationController;
  final StreamController<Offset> _shiftStreamController;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _shiftStreamController.stream,
      builder: (context, asyncSnapshot) {
        return Positioned(
          top: 48 + (asyncSnapshot.data?.dy ?? 0).toDouble(),
          right: 48 - (asyncSnapshot.data?.dx ?? 0).toDouble(),
          child: ControlledAnimationIcon(
            angle: 35,
            controller: _skipAnimationController,
            child: SizedBox(
              width: 120,
              height: 120,
              child: Stack(
                children: [
                  Assets.images.icons.skip.svg(width: 120, height: 120),
                  Align(
                    alignment: AlignmentGeometry.center,
                    child: Text(
                      LocaleKeys.properties_skip.tr(),
                      style: AppTheme.of(context).textStyle.header3.copyWith(
                        color: AppTheme.of(context).color.neutralLightLightest,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
