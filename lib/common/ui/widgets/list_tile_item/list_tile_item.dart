import 'package:flinder/common/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ListTileItem extends StatelessWidget {
  const ListTileItem({super.key, required this.title, this.onTap});

  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Color activeColor = (onTap != null)
        ? AppTheme.of(context).color.neutralDarkDark
        : AppTheme.of(context).color.neutralDarkLight;

    return Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: AppTheme.of(context).color.neutralLightLight,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.0),
        splashColor: AppTheme.of(context).color.primaryLightest,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.0)),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppTheme.of(
                    context,
                  ).textStyle.header4.copyWith(color: activeColor),
                ),
              ),
              Icon(Icons.chevron_right_sharp, color: activeColor, size: 35),
            ],
          ),
        ),
      ),
    );
  }
}
