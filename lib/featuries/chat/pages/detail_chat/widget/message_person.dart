import 'dart:async';
import 'dart:typed_data';

import 'package:flirta/common/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../widget/person_photo.dart';

class MessagePerson extends StatelessWidget {
  const MessagePerson({
    super.key,
    required this.message,
    required this.isLast,
    required this.onSliderPhoto,
    required this.onPayWall,
    required this.isPremium,
    this.typing = false,
    this.sendignPhoto = false,
    this.image,
  });

  final FutureOr<Uint8List?> image;
  final String message;
  final bool isLast;
  final bool typing;
  final bool sendignPhoto;
  final bool isPremium;
  final Function() onSliderPhoto;
  final Function() onPayWall;

  @override
  Widget build(BuildContext context) {
    var textWidget = message.isNotEmpty
        ? SelectableText(
            message,
            contextMenuBuilder: (context, editableTextState) {
              final List<ContextMenuButtonItem> buttonItems =
                  editableTextState.contextMenuButtonItems;

              return AdaptiveTextSelectionToolbar.buttonItems(
                anchors: editableTextState.contextMenuAnchors,
                buttonItems: buttonItems,
              );
            },
            //softWrap: true,
            style: AppTheme.of(context).textStyle.bodyL,
          )
        : null;

    return Align(
      alignment: Alignment.topLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.of(context).color.neutralLightLight,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: (isLast) ? Radius.zero : Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          margin: EdgeInsets.only(top: 8, left: 8),
          child: (sendignPhoto)
              ? Row(
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
                )
              : (!typing)
              ? (image != null)
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          PersonPhoto(
                            imageBite: image,
                            isPremium: isPremium,
                            onTap: (premiumStatus) {
                              if (premiumStatus) {
                                onSliderPhoto();
                              } else {
                                onPayWall();
                              }
                            },
                          ),
                          if (textWidget != null) SizedBox(height: 4),
                          if (textWidget != null) textWidget,
                        ],
                      )
                    : textWidget
              : LoadingAnimationWidget.waveDots(
                  color: AppTheme.of(context).color.neutralDarkLight,
                  size: 20,
                ),
        ),
      ),
    );
  }
}
