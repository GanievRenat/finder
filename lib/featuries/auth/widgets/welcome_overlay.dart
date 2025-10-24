import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class OverlayManager {
  static OverlayEntry? _overlayEntry;

  static void showOverlay({
    required BuildContext context,
    required String message,
    required Function onHideOverlay,
  }) {
    _overlayEntry = OverlayEntry(
      builder: (context) => TweenAnimationBuilder<double>(
        duration: Duration(milliseconds: 500),
        tween: Tween(begin: 0.0, end: 1.0),
        onEnd: () {
          Future.delayed(Duration(seconds: 1), () {
            hideOverlay();
            onHideOverlay();
          });
        },
        builder: (context, value, child) {
          return Material(
            child: Stack(
              children: [
                // Полупрозрачный фон
                GestureDetector(
                  onTap: () {
                    hideOverlay();
                    onHideOverlay();
                  },
                  child: Opacity(
                    opacity: value,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.white,
                      child: Center(
                        child: Text(
                          message,
                          style: AppTheme.of(context).textStyle.header1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  static void hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
