import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ChatDetailLoaderFragment extends StatelessWidget {
  const ChatDetailLoaderFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: AppTheme.of(context).color.neutralLightLightest,
      ),
    );
  }
}
