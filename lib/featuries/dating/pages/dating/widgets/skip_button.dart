import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({super.key, required this.onTap});

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'skipButton',
      backgroundColor: AppTheme.of(context).color.neutralLightLightest,
      mini: false,
      onPressed: () => onTap(),
      shape: CircleBorder(),
      child: Icon(
        CupertinoIcons.clear,
        color: AppTheme.of(context).color.red,
        size: 30,
      ),
    );
  }
}
