import 'dart:async';

import 'package:flirta/generated/assets.gen.dart';
import 'package:flutter/material.dart';

import 'home_widgets.dart';

class LikeFlag extends StatelessWidget {
  const LikeFlag({
    super.key,
    required AnimationIconController likeAnimationController,
    required StreamController<Offset> shiftStreamController,
  }) : _likeAnimationController = likeAnimationController,
       _shiftStreamController = shiftStreamController;

  final AnimationIconController _likeAnimationController;
  final StreamController<Offset> _shiftStreamController;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _shiftStreamController.stream,
      builder: (context, asyncSnapshot) {
        return Positioned(
          top: 48 + (asyncSnapshot.data?.dy ?? 0).toDouble(),
          left: 48 + (asyncSnapshot.data?.dx ?? 0).toDouble(),
          child: ControlledAnimationIcon(
            angle: 0,
            controller: _likeAnimationController,
            child: Assets.images.icons.like.svg(width: 100, height: 100),
          ),
        );
      },
    );
  }
}
