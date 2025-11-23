import 'dart:async';

import 'package:flirta/common/domain/entites/person/person.dart';
import 'package:flirta/common/enums/enums.dart';
import 'package:flirta/common/ui/theme/app_spacing.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

import 'dating_widgets.dart';

class CardsSwiper extends StatefulWidget {
  const CardsSwiper({
    super.key,
    required this.persons,
    required this.onLike,
    required this.onSkip,
    required this.onUndo,
    required this.onEnd,
    required this.onTapToPerson,
    required this.canSwipe,
    required this.canUndo,
    required this.onPayWall,
  });

  final List<Person> persons;
  final Function onEnd;
  final Future<void> Function(Person) onLike;
  final Future<void> Function(Person) onSkip;
  final Future<void> Function() onUndo;
  final Future<ActionCallBackPersonDetailEnums> Function({
    required Person person,
  })
  onTapToPerson;
  final bool Function() canSwipe;
  final bool Function() canUndo;
  final Function onPayWall;

  @override
  State<CardsSwiper> createState() => _CardsSwiperState();
}

class _CardsSwiperState extends State<CardsSwiper> {
  late CardSwiperController _swipeController;
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
    _swipeController = CardSwiperController();
  }

  @override
  void dispose() {
    _likeAnimationController.dispose();
    _skipAnimationController.disable();
    _swipeController.dispose();
    _shiftStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        if (widget.persons.isNotEmpty)
          CardSwiper(
            controller: _swipeController,
            cardsCount: widget.persons.length,
            numberOfCardsDisplayed: (widget.persons.isNotEmpty)
                ? (widget.persons.length >= 4)
                      ? 4
                      : widget.persons.length
                : 0,
            maxAngle: 90,
            cardBuilder:
                (context, index, percentThresholdX, percentThresholdY) {
                  if (percentThresholdX != 0) {
                    _shiftStreamController.add(
                      Offset(
                        percentThresholdX.toDouble() * 0.7,
                        percentThresholdY.toDouble(),
                      ),
                    );
                  }
                  return CardSwipe(
                    key: ValueKey(widget.persons[index].modelId),
                    person: widget.persons[index],
                    onTap: () async {
                      var action = await widget.onTapToPerson(
                        person: widget.persons[index],
                      );
                      if (action == ActionCallBackPersonDetailEnums.like) {
                        Future.delayed(
                          Duration(milliseconds: 200),
                          () => _likeAnimation(),
                        );
                      } else if (action ==
                          ActionCallBackPersonDetailEnums.skip) {
                        Future.delayed(
                          Duration(milliseconds: 200),
                          () => _skipAnimation(),
                        );
                      }
                    },
                  );
                },
            onSwipe: (previousIndex, currentIndex, direction) async {
              if (!widget.canSwipe()) {
                widget.onPayWall();
                return false;
              }
              if (direction == CardSwiperDirection.right) {
                await widget.onLike(widget.persons[previousIndex]);
              } else if (direction == CardSwiperDirection.left) {
                await widget.onSkip(widget.persons[previousIndex]);
              }
              return true;
            },
            padding: EdgeInsetsGeometry.zero,
            scale: 1,
            isLoop: false,
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
            onUndo: (previousIndex, currentIndex, direction) {
              return true;
            },
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
                  swipeController: _swipeController,
                  undoStreamController: _undoStreamController,
                  canUndo: widget.canUndo,
                  onPayWall: widget.onPayWall,
                  onUndo: widget.onUndo,
                ),
                AppSpacing.horizontal.s3,
                SkipButton(onTap: () => _skipAnimation()),
                AppSpacing.horizontal.s3,
                LikeButton(onTap: () => _likeAnimation()),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _likeAnimation() {
    if (widget.canSwipe()) {
      _shiftStreamController.add(Offset(0, 0));
      _likeAnimationController.completeAuto();
      Future.delayed(
        Duration(milliseconds: 300),
        () => _swipeController.swipe(CardSwiperDirection.right),
      );
    } else {
      widget.onPayWall();
    }
  }

  void _skipAnimation() {
    if (widget.canSwipe()) {
      _shiftStreamController.add(Offset(0, 0));
      _skipAnimationController.completeAuto();
      Future.delayed(
        Duration(milliseconds: 300),
        () => _swipeController.swipe(CardSwiperDirection.left),
      );
    } else {
      widget.onPayWall();
    }
  }
}
