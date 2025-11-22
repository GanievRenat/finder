import 'dart:async';
import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

import 'dating_widgets.dart';

class LikeButton extends StatelessWidget {
  const LikeButton({
    super.key,
    required StreamController shiftStreamController,
    required AnimationIconController animationIconController,
    required CardSwiperController swipeController,
    required this.canSwipe,
    required this.onPayWall,
  }) : _shiftStreamController = shiftStreamController,
       _animationIconController = animationIconController,
       _swipeController = swipeController;

  final StreamController _shiftStreamController;
  final AnimationIconController _animationIconController;
  final CardSwiperController _swipeController;
  final Function() canSwipe;
  final Function onPayWall;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'likeButton',
      backgroundColor: Colors.white,
      mini: false,
      onPressed: () {
        if (canSwipe()) {
          _shiftStreamController.add(Offset(0, 0));
          _animationIconController.completeAuto();
          Future.delayed(
            Duration(milliseconds: 300),
            () => _swipeController.swipe(CardSwiperDirection.right),
          );
        } else {
          onPayWall();
        }
      },
      shape: CircleBorder(),
      child: Icon(
        CupertinoIcons.heart_solid,
        color: AppTheme.of(context).color.primaryDarkset,
        size: 30,
      ),
    );
  }
}
