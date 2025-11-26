import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ChatListLoaderFragment extends StatelessWidget {
  const ChatListLoaderFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: ShimmerEffect(
        baseColor: AppTheme.of(context).color.neutralLightMedium,
        highlightColor: AppTheme.of(context).color.neutralLightLightest,
        duration: Duration(seconds: 2),
      ),
      enabled: true,
      ignoreContainers: false,
      child: Column(
        children: [
          ListTileChatItem.loading(),
          Divider(),
          ListTileChatItem.loading(),
          Divider(),
          ListTileChatItem.loading(),
          Divider(),
        ],
      ),
    );
  }
}
