import 'dart:async';
import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class UndoButton extends StatelessWidget {
  const UndoButton({
    super.key,
    required CardSwiperController swipeController,
    required StreamController<bool> undoStreamController,
    required this.onUndo,
    required this.canUndo,
    required this.onPayWall,
  }) : _swipeController = swipeController,
       _undoStreamController = undoStreamController;

  final bool Function() canUndo;
  final Future<void> Function() onUndo;
  final Function onPayWall;
  final CardSwiperController _swipeController;
  final StreamController<bool> _undoStreamController;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _undoStreamController.stream,
      builder: (context, asyncSnapshot) {
        bool thereIsUndo = asyncSnapshot.data ?? false;
        return SizedBox(
          width: 60,
          height: 60,
          child: FloatingActionButton.small(
            backgroundColor: Colors.white,
            onPressed: (thereIsUndo)
                ? () async {
                    if (canUndo()) {
                      await onUndo();
                      _swipeController.undo();
                    } else {
                      onPayWall();
                    }
                  }
                : null,
            shape: CircleBorder(),
            child: Icon(
              CupertinoIcons.arrow_turn_up_left,
              color: thereIsUndo
                  ? AppTheme.of(context).color.green
                  : AppTheme.of(context).color.neutralLightDark,
              size: 35,
            ),
          ),
        );
      },
    );
  }
}
