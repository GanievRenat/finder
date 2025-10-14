import 'package:flinder/common/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.title,
    this.isLoading = false,
    this.onPressed,
  }) : _small = false,
       _inversion = false,
       _red = false,
       _reset = false;

  const MainButton.small({
    super.key,
    required this.title,
    this.isLoading = false,
    this.onPressed,
  }) : _small = true,
       _inversion = false,
       _red = false,
       _reset = false;

  const MainButton.inversion({
    super.key,
    required this.title,
    this.isLoading = false,
    this.onPressed,
  }) : _small = false,
       _inversion = true,
       _red = false,
       _reset = false;

  const MainButton.inversionSmall({
    super.key,
    required this.title,
    this.isLoading = false,
    this.onPressed,
  }) : _small = true,
       _inversion = true,
       _red = false,
       _reset = false;

  const MainButton.red({
    super.key,
    required this.title,
    this.isLoading = false,
    this.onPressed,
  }) : _small = false,
       _inversion = false,
       _red = true,
       _reset = false;

  const MainButton.redSmall({
    super.key,
    required this.title,
    this.isLoading = false,
    this.onPressed,
  }) : _small = true,
       _inversion = false,
       _red = true,
       _reset = false;

  const MainButton.reset({
    super.key,
    required this.title,
    this.isLoading = false,
    this.onPressed,
  }) : _small = false,
       _inversion = false,
       _red = false,
       _reset = true;

  final String title;
  final bool isLoading;
  final VoidCallback? onPressed;

  final bool _small;
  final bool _inversion;
  final bool _red;
  final bool _reset;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = _inversion
        ? AppTheme.of(context).color.neutralLightLightest
        : (_red)
        ? AppTheme.of(context).color.supportErrorLight
        : (_reset)
        ? AppTheme.of(context).color.primaryLightest
        : AppTheme.of(context).color.primaryDarkset;

    Color foregroundColor = _inversion
        ? AppTheme.of(context).color.neutralDarkLightest
        : (_red)
        ? AppTheme.of(context).color.supportErrorMedium
        : (_reset)
        ? AppTheme.of(context).color.primaryMedium
        : AppTheme.of(context).color.neutralLightLightest;

    Color textColor = _inversion
        ? AppTheme.of(context).color.neutralDarkDarkset
        : (_red)
        ? AppTheme.of(context).color.supportErrorDark
        : (_reset)
        ? AppTheme.of(context).color.neutralDarkDarkset
        : AppTheme.of(context).color.neutralLightLightest;

    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: double.infinity,
        minHeight: _small ? 40 : 48,
      ),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60),
          ),
          elevation: 0,
          padding: EdgeInsets.zero,
          side: BorderSide.none,
        ),
        onPressed: onPressed,
        child: (isLoading)
            ? SizedBox.square(
                dimension: _small ? 15 : 20,
                child: CircularProgressIndicator(color: textColor),
              )
            : Text(
                title,
                style: _small
                    ? AppTheme.of(
                        context,
                      ).textStyle.actionM.copyWith(color: textColor)
                    : AppTheme.of(
                        context,
                      ).textStyle.actionL.copyWith(color: textColor),
              ),
      ),
    );
  }
}
