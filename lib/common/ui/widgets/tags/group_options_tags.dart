import 'package:flirta/common/ui/widgets/tags/tag.dart';
import 'package:flutter/material.dart';

const Widget _kIconSelect = Icon(
  Icons.check_circle,
  color: Colors.white,
  size: 12,
);

class GroupOptionsTags extends StatefulWidget {
  const GroupOptionsTags({
    super.key,
    required this.tags,
    required this.onChange,
    this.initTag = '',
  });

  final Set<String> tags;
  final String initTag;
  final Function(String) onChange;

  @override
  State<GroupOptionsTags> createState() => _GroupOptionsTagsState();
}

class _GroupOptionsTagsState extends State<GroupOptionsTags> {
  String selectTags = '';

  @override
  void initState() {
    super.initState();
    selectTags = widget.initTag;
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
                name: tag,
                onChange: (value) {
                  if (selectTags != tag) {
                    setState(() {
                      selectTags = tag;
                    });
                    widget.onChange(selectTags);
                  }
                },
                selectIcon: _kIconSelect,
                isSelect: selectTags == tag,
              ),
            )
            .toList(),
      ),
    );
  }
}
