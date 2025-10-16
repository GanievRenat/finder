import 'package:flinder/common/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class GenderOptionItem<T> extends StatelessWidget {
  const GenderOptionItem({
    super.key,
    required this.title,
    required this.valuel,
    required this.onTap,
    this.isSelected = false,
  });

  final String title;
  final T valuel;
  final bool isSelected;
  final Function(T gender) onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(valuel);
      },
      borderRadius: BorderRadius.circular(16.0),
      splashColor: AppTheme.of(context).color.primaryLightest,
      child: Container(
        constraints: BoxConstraints(minHeight: 75, minWidth: double.infinity),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.of(context).color.primaryLightest : null,
          borderRadius: BorderRadius.circular(16.0),
          border: isSelected
              ? null
              : Border.all(
                  color: AppTheme.of(context).color.neutralLightDark,
                  width: 0.5,
                ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(title, style: AppTheme.of(context).textStyle.header4),
            ),
            Checker(isSelected: isSelected),
          ],
        ),
      ),
    );
  }
}

class Checker extends StatelessWidget {
  const Checker({super.key, this.isSelected = false});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 24,
        minWidth: 24,
        maxHeight: 24,
        maxWidth: 24,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: isSelected
            ? null
            : Border.all(
                color: AppTheme.of(context).color.neutralLightDarkset,
                width: 1.5,
              ),
        color: isSelected
            ? AppTheme.of(context).color.primaryDarkset
            : Colors.transparent,
      ),
      child: isSelected
          ? Center(
              child: Icon(
                Icons.check,
                size: 16,
                color: AppTheme.of(context).color.neutralLightLightest,
              ),
            )
          : null,
    );
  }
}
