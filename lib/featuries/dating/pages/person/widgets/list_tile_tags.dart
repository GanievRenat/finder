import 'package:flirta/common/ui/theme/app_spacing.dart';
import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ListTileTags extends StatelessWidget {
  const ListTileTags({super.key, required this.title, required this.tags});

  final String title;
  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTheme.of(context).textStyle.header3),
        AppSpacing.vertical.s4,
        GroupPersonTags(tags: tags.toSet()),
      ],
    );
  }
}
