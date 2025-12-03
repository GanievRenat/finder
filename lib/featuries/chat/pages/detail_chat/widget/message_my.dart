import 'package:flirta/common/ui/theme/theme.dart';
import 'package:flutter/material.dart';

class MessageMy extends StatelessWidget {
  const MessageMy({super.key, required this.message, required this.isLast});

  final String message;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.of(context).color.primaryDark,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: (isLast) ? Radius.zero : Radius.circular(20),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          margin: EdgeInsets.only(top: 8, left: 8, right: 8),
          child: SelectableText(
            message,
            contextMenuBuilder: (context, editableTextState) {
              final List<ContextMenuButtonItem> buttonItems =
                  editableTextState.contextMenuButtonItems;

              return AdaptiveTextSelectionToolbar.buttonItems(
                anchors: editableTextState.contextMenuAnchors,
                buttonItems: buttonItems,
              );
            },
            style: AppTheme.of(context).textStyle.bodyL.copyWith(
              color: AppTheme.of(context).color.neutralLightLightest,
            ),
          ),
        ),
      ),
    );
  }
}
