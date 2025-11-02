import 'dart:async';

import 'package:flirta/common/ui/theme/app_spacing.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

import 'home_widgets.dart';

class CardsSwiper extends StatefulWidget {
  const CardsSwiper({
    super.key,
    required this.cards,
    required this.onLike,
    required this.onSkip,
    required this.onEnd,
    required this.onUndo,
  });

  final List<Widget> cards;
  final Function onEnd;
  final Function onSkip;
  final Function onLike;
  final Function onUndo;

  @override
  State<CardsSwiper> createState() => _CardsSwiperState();
}

class _CardsSwiperState extends State<CardsSwiper> {
  late CardSwiperController _swiperController;
  late final AnimationIconController _likeAnimationController;
  late final AnimationIconController _skipAnimationController;

  final StreamController<Offset> _shiftStreamController =
      StreamController<Offset>.broadcast();

  final StreamController<bool> _undoStreamController =
      StreamController<bool>.broadcast();

  @override
  void initState() {
    super.initState();
    _likeAnimationController = AnimationIconController();
    _skipAnimationController = AnimationIconController();
    _swiperController = CardSwiperController();
  }

  @override
  void dispose() {
    _likeAnimationController.dispose();
    _skipAnimationController.disable();
    _swiperController.dispose();
    _shiftStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        CardSwiper(
          controller: _swiperController,
          cardsCount: widget.cards.length,
          maxAngle: 90,
          cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
            if (percentThresholdX != 0) {
              _shiftStreamController.add(
                Offset(
                  percentThresholdX.toDouble() * 0.7,
                  percentThresholdY.toDouble(),
                ),
              );
            }
            return widget.cards[index];
          },

          padding: EdgeInsetsGeometry.zero,
          scale: 0.8,
          isLoop: true,
          backCardOffset: Offset(0, 0),
          showBackCardOnUndo: false,
          onSwipeDirectionChange:
              (horizontalDirection, verticalDirection, shift) {
                if (horizontalDirection == CardSwiperDirection.right) {
                  _likeAnimationController.show();
                  _skipAnimationController.disable();
                } else if (horizontalDirection == CardSwiperDirection.left) {
                  _skipAnimationController.show();
                  _likeAnimationController.disable();
                } else if (horizontalDirection == CardSwiperDirection.none) {
                  _likeAnimationController.disable();
                  _skipAnimationController.disable();
                }
              },
          onEnd: () => widget.onEnd(),
          onAddUndo: (direction) {
            if (direction == CardSwiperDirection.left) {
              return true;
            } else {
              return false;
            }
          },
          onUndo: (previousIndex, currentIndex, direction) => true,
          onUndoCallBack: (countHistoryElement) {
            if (countHistoryElement > 0) {
              _undoStreamController.add(true);
            } else {
              _undoStreamController.add(false);
            }
          },
          allowedSwipeDirection: AllowedSwipeDirection.only(
            left: true,
            right: true,
          ),
        ),
        LikeFlag(
          likeAnimationController: _likeAnimationController,
          shiftStreamController: _shiftStreamController,
        ),
        SkipFlag(
          skipAnimationController: _skipAnimationController,
          shiftStreamController: _shiftStreamController,
        ),
        Align(
          alignment: AlignmentGeometry.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                UndoButton(
                  swipeController: _swiperController,
                  undoStreamController: _undoStreamController,
                ),
                AppSpacing.horizontal.s3,
                SkipButton(
                  shiftStreamController: _shiftStreamController,
                  animationIconController: _skipAnimationController,
                  swipeController: _swiperController,
                ),
                AppSpacing.horizontal.s3,
                LikeButton(
                  shiftStreamController: _shiftStreamController,
                  animationIconController: _likeAnimationController,
                  swipeController: _swiperController,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


      /*onSwipe: (previousIndex, currentIndex, direction) {
          /*if (direction == CardSwiperDirection.right) {
                _skipAnimationController.disable();
                _likeAnimationController.complete();
              } else if (direction == CardSwiperDirection.left) {
                _skipAnimationController.complete();
                _likeAnimationController.disable();
              }*/
        return true;
      },*/