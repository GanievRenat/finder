import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ProductItem<T> extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.isSelect,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.priceLabel,
    required this.onTap,
    required this.value,
  });

  final bool isSelect;
  final String title;
  final String subtitle;
  final String price;
  final String priceLabel;
  final Function(T value) onTap;
  final T value;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: (isSelect)
              ? LinearGradient(
                  colors: [
                    AppTheme.of(context).color.gradientWarmEnd,
                    AppTheme.of(context).color.gradientWarmBegin,
                  ],
                  begin: AlignmentGeometry.centerLeft,
                  end: AlignmentGeometry.centerRight,
                )
              : null,
          border: isSelect
              ? null
              : Border.all(
                  width: 1,
                  color: AppTheme.of(context).color.neutralLightLightest,
                ),
        ),
        child: InkWell(
          onTap: () {
            onTap(value);
          },
          borderRadius: BorderRadius.circular(16),
          splashColor: AppTheme.of(
            context,
          ).color.neutralLightLightest.withAlpha(50),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
            padding: EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: AppTheme.of(context).textStyle.header3.copyWith(
                          color: AppTheme.of(
                            context,
                          ).color.neutralLightLightest,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: AppTheme.of(context).textStyle.bodyXL.copyWith(
                          color: AppTheme.of(
                            context,
                          ).color.neutralLightLightest,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      price,
                      style: AppTheme.of(context).textStyle.header3.copyWith(
                        color: AppTheme.of(context).color.neutralLightLightest,
                      ),
                    ),
                    Text(
                      priceLabel,
                      style: AppTheme.of(context).textStyle.bodyL.copyWith(
                        color: AppTheme.of(context).color.neutralLightLightest,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
