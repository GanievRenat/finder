import 'dart:developer';

import 'package:flirta/common/ui/theme/app_spacing.dart';
import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flirta/common/ui/widgets/logo/logo.dart';
import 'package:flirta/generated/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

import 'widgets/animated_icon.dart';
import 'widgets/card_swipe.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.onFilter});

  final VoidCallback onFilter;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CardSwipe> cards = [
    CardSwipe(
      key: ValueKey(1),
      imageUrl:
          'https://pg11.ru/userfiles/picfullsize/img-53415-14964303316571.jpg',
      name: 'Jane Cooper',
      age: 25,
      job: 'Professional model',
    ),
    CardSwipe(
      key: ValueKey(2),
      imageUrl:
          'https://img.freepik.com/free-photo/portrait-blonde-woman-looking-photographer_23-2148348970.jpg?semt=ais_hybrid&w=740&q=80',
      name: 'Jane Cooper',
      age: 25,
      job: 'Professional model',
    ),
    CardSwipe(
      key: ValueKey(3),
      imageUrl:
          'https://img.freepik.com/free-photo/attractive-positive-elegant-young-woman-cafe_23-2148071691.jpg?semt=ais_hybrid&w=740&q=80',
      name: 'Jane Cooper',
      age: 25,
      job: 'Professional model',
    ),
  ];

  late CardSwiperController _swiperController;
  late final AnimationIconController _likeAnimationController;
  late final AnimationIconController _skipAnimationController;

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const LogoFlirta(),
        actions: [
          IconButton(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Assets.images.icons.filter.svg(),
            ),
            onPressed: widget.onFilter,
          ),
        ],
      ),

      body: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          CardSwiper(
            controller: _swiperController,
            cardsCount: cards.length,
            maxAngle: 90,
            cardBuilder:
                (context, index, percentThresholdX, percentThresholdY) =>
                    cards[index],
            padding: EdgeInsetsGeometry.zero,
            scale: 0.8,
            isLoop: true,
            backCardOffset: Offset(0, 0),
            showBackCardOnUndo: false,
            onSwipeDirectionChange: (horizontalDirection, verticalDirection) {
              log('onSwipeDirectionChange: ${horizontalDirection.name}');
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
            onSwipe: (previousIndex, currentIndex, direction) {
              log('onSwipe: ${direction.name}');
              if (direction == CardSwiperDirection.right) {
                _skipAnimationController.disable();
                _likeAnimationController.complete();
              } else if (direction == CardSwiperDirection.left) {
                _skipAnimationController.complete();
                _likeAnimationController.disable();
              }
              return true;
            },
            onEnd: () {
              log('onEnd');
            },
            onAddUndo: (direction) {
              if (direction == CardSwiperDirection.left) {
                return true;
              } else {
                return false;
              }
            },
            onUndo: (previousIndex, currentIndex, direction) {
              log(
                'onUndo: ${direction.name}, previousIndex: $previousIndex, currentIndex: $currentIndex, ',
              );
              return true;
            },
            onUndoCallBack: (countHistoryElement) {
              log('countHistoryElement: $countHistoryElement');
            },
            allowedSwipeDirection: AllowedSwipeDirection.only(
              left: true,
              right: true,
            ),
          ),
          Positioned(
            top: 48,
            left: 48,
            child: ControlledAnimationIcon(
              angle: 0,
              controller: _likeAnimationController,
              child: Assets.images.icons.like.svg(width: 100, height: 100),
            ),
          ),
          Positioned(
            top: 48,
            right: 48,
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
                        'Skip',
                        style: AppTheme.of(context).textStyle.header3.copyWith(
                          color: AppTheme.of(
                            context,
                          ).color.neutralLightLightest,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentGeometry.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton.small(
                    backgroundColor: Colors.white,
                    onPressed: () {
                      _swiperController.undo();
                    },
                    shape: CircleBorder(),
                    child: Icon(
                      CupertinoIcons.arrow_turn_up_left,
                      color: AppTheme.of(context).color.green,
                      size: 25,
                    ),
                  ),
                  AppSpacing.horizontal.s3,
                  FloatingActionButton(
                    backgroundColor: Colors.white,
                    mini: false,
                    onPressed: () {
                      _skipAnimationController.completeAuto();
                      Future.delayed(
                        Duration(milliseconds: 300),
                        () => _swiperController.swipe(CardSwiperDirection.left),
                      );
                    },
                    shape: CircleBorder(),
                    child: Icon(
                      CupertinoIcons.clear,
                      color: AppTheme.of(context).color.red,
                      size: 30,
                    ),
                  ),
                  AppSpacing.horizontal.s3,
                  FloatingActionButton(
                    backgroundColor: Colors.white,
                    mini: false,
                    onPressed: () {
                      _likeAnimationController.completeAuto();
                      Future.delayed(
                        Duration(milliseconds: 300),
                        () =>
                            _swiperController.swipe(CardSwiperDirection.right),
                      );
                    },
                    shape: CircleBorder(),
                    child: Icon(
                      CupertinoIcons.heart_solid,
                      color: AppTheme.of(context).color.primaryDarkset,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomCardSwiperDirection implements CardSwiperDirection {
  @override
  double get angle => 300;

  @override
  bool isCloseTo(CardSwiperDirection other, {double tolerance = 5}) {
    final diff = (angle - other.angle).abs();
    return diff <= tolerance || (360 - diff) <= tolerance;
  }

  @override
  bool get isHorizontal => true;

  @override
  bool get isVertical => false;

  @override
  // TODO: implement name
  String get name => 'left';
}
