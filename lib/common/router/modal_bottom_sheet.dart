import 'package:flirta/common/ui/theme/app_spacing.dart';
import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

class ModalBottomSheetPage<T> extends Page<T> {
  const ModalBottomSheetPage({
    required this.child,
    this.title = '',
    this.subtitle = '',
    this.closeButton = false,
    super.key,
    super.name,
  });

  final Widget child;
  final String title;
  final String subtitle;
  final bool closeButton;

  @override
  Route<T> createRoute(BuildContext context) {
    return ModalBottomSheetRoute(
      settings: this,
      builder: (BuildContext context) => Container(
        constraints: BoxConstraints(minWidth: double.infinity),
        padding: EdgeInsets.only(
          left: 16,
          top: 16,
          right: 16,
          bottom: 16 + MediaQuery.of(context).padding.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title.isNotEmpty)
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: AppTheme.of(context).textStyle.header3,
                    ),
                  ),
                  if (closeButton)
                    IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: Icon(
                        Icons.close,
                        color: AppTheme.of(context).color.neutralLightDark,
                      ),
                    ),
                ],
              ),
            if (subtitle.isNotEmpty) AppSpacing.vertical.s2,
            if (subtitle.isNotEmpty)
              Text(subtitle, style: AppTheme.of(context).textStyle.bodyM),
            if (title.isNotEmpty || subtitle.isNotEmpty) AppSpacing.vertical.s4,
            Expanded(child: child),
          ],
        ),
      ),
      isScrollControlled: false,
      backgroundColor: AppTheme.of(context).color.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
    );
  }
}

@singleton
class AppModalBottomSheet {
  AppModalBottomSheet();

  Future<T?> show<T>(
    BuildContext context, {
    required Widget content,
    List<Widget> action = const [],
    String title = '',
    String subtitle = '',
    bool closeButton = false,
  }) async {
    return await showModalBottomSheet<T?>(
      context: context,
      backgroundColor: AppTheme.of(context).color.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      builder: (context) => Container(
        constraints: BoxConstraints(minWidth: double.infinity),
        padding: EdgeInsets.only(
          left: 16,
          top: 16,
          right: 16,
          bottom: 16 + MediaQuery.of(context).padding.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title.isNotEmpty)
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: AppTheme.of(context).textStyle.header3,
                    ),
                  ),
                  if (closeButton)
                    IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: Icon(
                        Icons.close,
                        color: AppTheme.of(context).color.neutralLightDark,
                      ),
                    ),
                ],
              ),
            if (subtitle.isNotEmpty) AppSpacing.vertical.s2,
            if (subtitle.isNotEmpty)
              Text(subtitle, style: AppTheme.of(context).textStyle.bodyM),
            if (title.isNotEmpty || subtitle.isNotEmpty) AppSpacing.vertical.s4,
            Expanded(child: content),
            if (action.isNotEmpty) Row(children: action),
          ],
        ),
      ),
    );
  }
}
