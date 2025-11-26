import 'package:flirta/common/ui/theme/theme.dart';
import 'package:flutter/material.dart';

class MessagePerson extends StatelessWidget {
  const MessagePerson({super.key, required this.message, required this.isLast});

  final String message;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
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

          child: Text(
            message,
            softWrap: true,
            style: AppTheme.of(context).textStyle.bodyL,
          ),
        ),
      ),
    );
  }
}
