import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class BodyStepPage extends StatelessWidget {
  const BodyStepPage({
    super.key,
    required this.title,
    required this.content,
    required this.onPressed,
    this.subtitle,
    this.animationDuration = const Duration(milliseconds: 1000),
  });

  final String title;
  final String? subtitle;
  final Widget content;
  final Duration animationDuration;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: TweenAnimationBuilder<double>(
            duration: animationDuration,
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style: AppTheme.of(context).textStyle.header1,
                          textAlign: TextAlign.center,
                        ),
                        if (subtitle != null)
                          Text(
                            subtitle!,
                            style: AppTheme.of(context).textStyle.bodyM,
                            textAlign: TextAlign.center,
                          ),
                      ],
                    ),
                    Spacer(),
                    content,
                    Spacer(),
                  ],
                ),
              );
            },
          ),
        ),
        MainButton(
          onPressed: onPressed,
          title: LocaleKeys.auth_button_continue.tr(),
        ),
      ],
    );
  }
}
