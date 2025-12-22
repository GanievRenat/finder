import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class BlackButton extends StatelessWidget {
  const BlackButton({
    super.key,
    required this.title,
    this.isLoading = false,
    this.onPressed,
  });

  final String title;
  final bool isLoading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 40),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: AppTheme.of(context).color.neutralDarkDarkset,
          foregroundColor: AppTheme.of(context).color.neutralLightLightest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60),
          ),
          elevation: 0,
          side: BorderSide.none,
          padding: EdgeInsets.symmetric(horizontal: 16),
        ),
        onPressed: onPressed,
        child: (isLoading)
            ? SizedBox.square(
                dimension: 20,
                child: CircularProgressIndicator(
                  color: AppTheme.of(context).color.neutralLightLightest,
                ),
              )
            : Text(
                title,
                textAlign: TextAlign.center,
                style: AppTheme.of(context).textStyle.actionXL.copyWith(
                  color: AppTheme.of(context).color.neutralLightLightest,
                ),
              ),
      ),
    );
  }
}
