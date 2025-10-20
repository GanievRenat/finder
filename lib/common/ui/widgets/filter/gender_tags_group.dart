import 'package:flirta/common/enums/enums.dart';
import 'package:flirta/common/ui/theme/theme.dart';
import 'package:flutter/material.dart';

import '../tags/group_options_tags.dart';

class GenderTagsGroup extends StatefulWidget {
  const GenderTagsGroup({
    super.key,
    required this.title,
    this.initGender = Gender.none,
  });

  final Gender initGender;
  final String title;

  @override
  State<GenderTagsGroup> createState() => _GenderTagsGroupState();
}

class _GenderTagsGroupState extends State<GenderTagsGroup> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: AppTheme.of(context).textStyle.header4),
        SizedBox(height: 16),
        GroupOptionsTags(
          tags: {
            Gender.female.displayName,
            Gender.male.displayName,
            Gender.nonBinary.displayName,
            Gender.none.displayName,
          },
          initTag: widget.initGender.displayName,
          onChange: (tags) {},
        ),
      ],
    );
  }
}
