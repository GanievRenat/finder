import 'package:flirta/common/extension/extension.dart';
import 'package:flirta/common/ui/widgets/tags/tag.dart';
import 'package:flutter/material.dart';

class GroupPersonTags extends StatefulWidget {
  const GroupPersonTags({super.key, required this.tags});

  final Set<String> tags;

  @override
  State<GroupPersonTags> createState() => _GroupPersonTagsState();
}

class _GroupPersonTagsState extends State<GroupPersonTags> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: double.infinity),
      child: Wrap(
        alignment: WrapAlignment.start,
        runAlignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        spacing: 8,
        runSpacing: 8,
        children: widget.tags
            .map((tag) => Tag(key: ValueKey(tag), name: tag.capitalize()))
            .toList(),
      ),
    );
  }
}
