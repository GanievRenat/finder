import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LikeButton extends StatelessWidget {
  const LikeButton({super.key, required this.onTap});

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'likeButton',
      backgroundColor: Colors.white,
      mini: false,
      onPressed: () => onTap(),
      shape: CircleBorder(),
      child: Icon(
        CupertinoIcons.heart_solid,
        color: AppTheme.of(context).color.primaryDarkset,
        size: 30,
      ),
    );
  }
}
