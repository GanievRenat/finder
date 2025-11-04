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
  }) : _swipeController = swipeController,
       _undoStreamController = undoStreamController;

  final CardSwiperController _swipeController;
  final StreamController<bool> _undoStreamController;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _undoStreamController.stream,
      builder: (context, asyncSnapshot) {
        bool canUndo = asyncSnapshot.data ?? false;
        return FloatingActionButton.small(
          backgroundColor: Colors.white,
          onPressed: canUndo
              ? () {
                  _swipeController.undo();
                }
              : null,
          shape: CircleBorder(),
          child: Icon(
            CupertinoIcons.arrow_turn_up_left,
            color: canUndo
                ? AppTheme.of(context).color.green
                : AppTheme.of(context).color.neutralLightDark,
            size: 25,
          ),
        );
      },
    );
  }
}
