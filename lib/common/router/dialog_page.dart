import 'package:flutter/material.dart';

class DialogPage<T> extends Page<T> {
  final Offset? anchorPoint;
  final bool barrierDismissible;
  final String? barrierLabel;
  final bool useSafeArea;
  final CapturedThemes? themes;
  final Widget dialogContent;

  const DialogPage({
    required this.dialogContent,
    this.anchorPoint,
    this.barrierDismissible = true,
    this.barrierLabel,
    this.useSafeArea = true,
    this.themes,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  @override
  Route<T> createRoute(BuildContext context) => DialogRoute<T>(
    context: context,
    settings: this,
    builder: (context) => dialogContent,
    anchorPoint: anchorPoint,
    barrierDismissible: barrierDismissible,
    barrierLabel: barrierLabel,
    useSafeArea: useSafeArea,
    themes: themes,
  );
}
