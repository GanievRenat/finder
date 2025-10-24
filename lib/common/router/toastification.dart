import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:toastification/toastification.dart';

@singleton
class AppToast {
  void show({
    required BuildContext context,
    required String message,
    EdgeInsetsGeometry margin = const EdgeInsets.only(bottom: 64),
  }) {
    toastification.show(
      context: context,
      style: ToastificationStyle.simple,
      autoCloseDuration: const Duration(seconds: 5),
      borderSide: BorderSide.none,
      alignment: Alignment.bottomCenter,
      applyBlurEffect: false,
      borderRadius: BorderRadius.circular(16),
      backgroundColor: AppTheme.of(context).color.primaryLightest,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      margin: margin,
      closeOnClick: true,
      dragToClose: true,

      closeButton: ToastCloseButton(showType: CloseButtonShowType.none),
      title: Text(message, style: AppTheme.of(context).textStyle.header5),
    );
  }
}
