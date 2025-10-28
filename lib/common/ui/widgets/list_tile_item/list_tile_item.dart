import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ListTileItem extends StatelessWidget {
  const ListTileItem({
    super.key,
    required this.title,
    this.onTap,
    this.isLink = false,
  });

  final String title;
  final VoidCallback? onTap;
  final bool isLink;

  @override
  Widget build(BuildContext context) {
    Color activeColor = (onTap != null)
        ? !isLink
              ? AppTheme.of(context).color.neutralDarkDark
              : AppTheme.of(context).color.neutralDarkLight
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
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: !isLink ? 24 : 16,
          ),
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
              Icon(
                !isLink
                    ? Icons.chevron_right_sharp
                    : Icons.arrow_outward_rounded,
                color: activeColor,
                size: 35,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
