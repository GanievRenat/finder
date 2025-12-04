import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GoToBackButton extends StatelessWidget {
  const GoToBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.pop();
      },
      icon: CircleAvatar(
        backgroundColor: AppTheme.of(
          context,
        ).color.neutralLightLightest.withAlpha(180),
        radius: 16,
        child: Icon(
          Icons.close_rounded,
          fontWeight: FontWeight.bold,
          color: AppTheme.of(context).color.neutralDarkDarkset,
        ),
      ),
    );
  }
}
