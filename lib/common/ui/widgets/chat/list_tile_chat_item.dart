import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ListTileChatItem extends StatelessWidget {
  const ListTileChatItem({
    super.key,
    required this.imageURL,
    required this.modelName,
    required this.lastMessage,
    required this.onTap,
    required this.image,
    this.countNewMessage = 0,
    this.waitingAnswer = false,
    required this.waitingPhoto,
  }) : _isLoading = false;

  const ListTileChatItem.loading({super.key})
    : imageURL = '',
      modelName = 'Eleanor Pena',
      lastMessage = 'One day you’re seventeen One day you’re seventeen',
      countNewMessage = 0,
      waitingAnswer = false,
      waitingPhoto = false,
      onTap = null,
      image = false,
      _isLoading = true;

  final String imageURL;
  final String modelName;
  final String lastMessage;
  final bool image;
  final int countNewMessage;
  final bool waitingAnswer;
  final bool waitingPhoto;

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
                  LastMessageWithPhoto(
                    lastMessage: lastMessage,
                    photo: image,
                    sendingPhoto: waitingPhoto,
                    typing: waitingAnswer,
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
                    style: AppTheme.of(context).textStyle.captionL.copyWith(
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

class SendingPhoto extends StatelessWidget {
  const SendingPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'sending photo  ',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTheme.of(context).textStyle.bodyL.copyWith(
            color: AppTheme.of(context).color.neutralDarkLight,
          ),
        ),
        LoadingAnimationWidget.progressiveDots(
          color: AppTheme.of(context).color.primaryDarkset,
          size: 20,
        ),
      ],
    );
  }
}

class TypingText extends StatelessWidget {
  const TypingText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'typing  ',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTheme.of(context).textStyle.bodyL.copyWith(
            color: AppTheme.of(context).color.neutralDarkLight,
          ),
        ),
        LoadingAnimationWidget.staggeredDotsWave(
          color: AppTheme.of(context).color.primaryDarkset,
          size: 20,
        ),
      ],
    );
  }
}

class LastMessageWithPhoto extends StatelessWidget {
  const LastMessageWithPhoto({
    super.key,
    required this.lastMessage,
    this.photo = false,
    this.typing = false,
    this.sendingPhoto = false,
  });

  final String lastMessage;
  final bool photo;
  final bool typing;
  final bool sendingPhoto;

  @override
  Widget build(BuildContext context) {
    if (sendingPhoto) {
      return SendingPhoto();
    }
    if (typing) {
      return TypingText();
    }
    if (photo) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.photo,
            color: AppTheme.of(context).color.neutralDarkLight,
            size: 16,
          ),
          SizedBox(width: 4),
          Expanded(
            child: Text(
              lastMessage.isEmpty ? 'photo' : lastMessage,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTheme.of(context).textStyle.bodyL.copyWith(
                color: AppTheme.of(context).color.neutralDarkLight,
              ),
            ),
          ),
        ],
      );
    }
    return Text(
      lastMessage,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: AppTheme.of(context).textStyle.bodyL.copyWith(
        color: AppTheme.of(context).color.neutralDarkLight,
      ),
    );
  }
}
