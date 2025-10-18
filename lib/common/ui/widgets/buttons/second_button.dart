import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SecondButton extends StatelessWidget {
  const SecondButton({
    super.key,
    required this.title,
    this.isLoading = false,
    this.onPressed,
  }) : _small = false;

  const SecondButton.small({
    super.key,
    required this.title,
    this.isLoading = false,
    this.onPressed,
  }) : _small = true;

  final String title;
  final bool isLoading;
  final VoidCallback? onPressed;

  final bool _small;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: double.infinity,
        minHeight: _small ? 40 : 48,
      ),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: AppTheme.of(context).color.primaryMedium,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60),
          ),
          side: BorderSide(
            color: AppTheme.of(context).color.primaryDarkset,
            width: 2,
            style: BorderStyle.solid,
          ),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: (isLoading)
            ? SizedBox.square(
                dimension: _small ? 15 : 20,
                child: CircularProgressIndicator(
                  color: AppTheme.of(context).color.primaryDarkset,
                ),
              )
            : Text(
                title,
                style: _small
                    ? AppTheme.of(context).textStyle.actionM.copyWith(
                        color: AppTheme.of(context).color.primaryDarkset,
                      )
                    : AppTheme.of(context).textStyle.actionL.copyWith(
                        color: AppTheme.of(context).color.primaryDarkset,
                      ),
              ),
      ),
    );
  }
}
