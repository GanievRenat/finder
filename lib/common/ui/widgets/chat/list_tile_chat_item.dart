import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ListTileChatItem extends StatelessWidget {
  const ListTileChatItem({
    super.key,
    required this.imageURL,
    required this.modelName,
    required this.lastMessage,
    required this.onTap,
    this.countNewMessage = 0,
    this.waitingAnswer = false,
  }) : _isLoading = false;

  const ListTileChatItem.loading({super.key})
    : imageURL = '',
      modelName = 'Eleanor Pena',
      lastMessage = 'One day you’re seventeen One day you’re seventeen',
      countNewMessage = 0,
      waitingAnswer = false,
      onTap = null,
      _isLoading = true;

  final String imageURL;
  final String modelName;
  final String lastMessage;
  final int countNewMessage;
  final bool waitingAnswer;

  final bool _isLoading;

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(left: 8, top: 12, right: 16, bottom: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AvatarModel(imageURL: _isLoading ? '' : imageURL),
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
                    (waitingAnswer) ? 'typing...' : lastMessage,
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
