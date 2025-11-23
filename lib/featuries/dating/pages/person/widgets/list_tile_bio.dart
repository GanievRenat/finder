import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ListTileBio extends StatelessWidget {
  const ListTileBio({super.key, required this.title, required this.text});

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTheme.of(context).textStyle.header4),
        Text(text, softWrap: true, style: AppTheme.of(context).textStyle.bodyM),
      ],
    );
  }
}
