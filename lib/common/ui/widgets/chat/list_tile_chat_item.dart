import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ListTileChatItem extends StatelessWidget {
  const ListTileChatItem({
    super.key,
    required this.imageURL,
    required this.modelName,
    required this.lastMessage,
    this.countNewMessage = 0,
  });

  final String imageURL;
  final String modelName;
  final String lastMessage;
  final int countNewMessage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.only(left: 8, top: 12, right: 16, bottom: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AvatarModel(imageURL: imageURL),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    modelName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.of(context).textStyle.header3,
                  ),
                  Text(
                    lastMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.of(context).textStyle.bodyM.copyWith(
                      color: AppTheme.of(context).color.neutralDarkLight,
                    ),
                  ),
                ],
              ),
            ),
            if (countNewMessage > 0)
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: AppTheme.of(context).color.pushIndicator,
                  child: Text(
                    '$countNewMessage',
                    maxLines: 1,
                    style: AppTheme.of(context).textStyle.captionM.copyWith(
                      color: AppTheme.of(context).color.neutralLightLightest,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
