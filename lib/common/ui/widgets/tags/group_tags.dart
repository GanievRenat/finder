import 'package:flirta/common/extension/extension.dart';
import 'package:flirta/common/ui/widgets/tags/tag.dart';
import 'package:flutter/material.dart';

class GroupTags extends StatefulWidget {
  const GroupTags({
    super.key,
    required this.tags,
    required this.onChange,
    this.initTags = const {},
  });

  final Set<String> tags;
  final Set<String> initTags;
  final Function(Set<String>) onChange;

  @override
  State<GroupTags> createState() => _GroupTagsState();
}

class _GroupTagsState extends State<GroupTags> {
  Set<String> selectTags = {};

  @override
  void initState() {
    super.initState();
    selectTags = widget.initTags;
  }

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
            .map(
              (tag) => Tag(
                key: ValueKey(tag),
                name: tag.capitalize(),
                onChange: (value) {
                  setState(() {
                    if (value) {
                      selectTags.add(tag);
                    } else {
                      selectTags.remove(tag);
                    }
                  });
                  widget.onChange(selectTags);
                },
                isSelect: selectTags.contains(tag),
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  void didUpdateWidget(GroupTags oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initTags != widget.initTags) {
      setState(() {
        selectTags = widget.initTags;
      });
    }
  }
}
