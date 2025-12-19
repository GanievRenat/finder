import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flirta/common/ui/widgets/buttons/animation_click_widget.dart';
import 'package:flutter/material.dart';
import 'package:spoiler_widget/models/widget_spoiler.dart';
import 'package:spoiler_widget/spoiler_overlay_widget.dart';

class PersonPhoto extends StatelessWidget {
  const PersonPhoto({
    super.key,
    required this.imageBite,
    required this.onTap,
    required this.isPremium,
  });

  final bool isPremium;
  final FutureOr<Uint8List?> imageBite;
  final Function(bool premiumStatus) onTap;

  Future<Uint8List?> _getFuture() async {
    if (imageBite is Future<Uint8List?>) {
      return await imageBite;
    } else {
      return imageBite as Uint8List?;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimationClickWidget(
      onTap: () {
        onTap(isPremium);
      },
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(15),
        child: (isPremium)
            ? loadingImage()
            : AbsorbPointer(
                absorbing: true,
                child: SpoilerOverlay(
                  config: WidgetSpoilerConfig(
                    isEnabled: true,
                    fadeRadius: 3,
                    enableFadeAnimation: true,
                    enableGestureReveal: false,
                    imageFilter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                  ),
                  child: loadingImage(),
                ),
              ),
      ),
    );
  }

  Widget loadingImage() {
    return FutureBuilder<Uint8List?>(
      future: _getFuture(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data != null) {
            return Image.memory(
              snapshot.data!,
              fit: BoxFit.cover,
              width: double.infinity,
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
