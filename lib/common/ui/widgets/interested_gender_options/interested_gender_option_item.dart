import 'package:flinder/common/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../gender_options/gender_option_item.dart';

class InterestedGenderOptionItem<T> extends StatelessWidget {
  const InterestedGenderOptionItem({
    super.key,
    required this.title,
    required this.valuel,
    required this.onTap,
    required this.image,
    this.isSelected = false,
  });

  final String title;
  final T valuel;
  final bool isSelected;
  final ImageProvider image;
  final Function(T gender) onTap;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        image: DecorationImage(image: image, fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black.withAlpha(125), Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),

          borderRadius: BorderRadius.circular(16.0),
        ),
        child: InkWell(
          onTap: () {
            onTap(valuel);
          },
          borderRadius: BorderRadius.circular(16.0),
          splashColor: AppTheme.of(context).color.primaryLightest.withAlpha(50),
          child: Column(
            children: [
              Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                  bottom: 24.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: AppTheme.of(context).textStyle.header4.copyWith(
                          color: AppTheme.of(
                            context,
                          ).color.neutralLightLightest,
                        ),
                      ),
                    ),
                    Checker(isSelected: isSelected),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
