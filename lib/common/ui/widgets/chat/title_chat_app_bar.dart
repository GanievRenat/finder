import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flirta/common/ui/widgets/avatar/avatar_models.dart';
import 'package:flutter/material.dart';

class TitleChatAppBar extends StatelessWidget {
  const TitleChatAppBar({
    super.key,
    required this.imageURL,
    required this.modelName,
    this.onTap,
  });

  final String imageURL;
  final String modelName;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AvatarModel(imageURL: imageURL, radius: 20),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              modelName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTheme.of(context).textStyle.header3,
            ),
          ),
        ],
      ),
    );
  }
}
