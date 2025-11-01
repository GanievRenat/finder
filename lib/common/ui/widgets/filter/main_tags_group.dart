import 'package:flirta/common/ui/theme/theme.dart';
import 'package:flutter/material.dart';

import '../tags/group_tags.dart';

class MainTagsGroup extends StatefulWidget {
  const MainTagsGroup({
    super.key,
    required this.title,
    required this.tags,
    required this.onChanged,
    this.initTags = const {},
  });

  final String title;
  final Set<String> tags;
  final Set<String> initTags;
  final Function(Set<String> selectTags) onChanged;

  @override
  State<MainTagsGroup> createState() => _MainTagsGroupState();
}

class _MainTagsGroupState extends State<MainTagsGroup> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: AppTheme.of(context).textStyle.header4),
        SizedBox(height: 16),
        GroupTags(
          tags: widget.tags,
          initTags: widget.initTags,
          onChange: widget.onChanged,
        ),
      ],
    );
  }
}
