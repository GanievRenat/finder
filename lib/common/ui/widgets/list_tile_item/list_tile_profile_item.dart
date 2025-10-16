import 'package:flinder/common/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ListTileProfileItem extends StatelessWidget {
  const ListTileProfileItem({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
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
          constraints: BoxConstraints(minWidth: double.infinity),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.0)),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTheme.of(context).textStyle.header4),
              SizedBox(height: 4),
              Text(
                subtitle,
                style: AppTheme.of(context).textStyle.bodyM.copyWith(
                  color: AppTheme.of(context).color.neutralDarkLight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
