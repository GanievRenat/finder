import 'package:flirta/common/enums/enums.dart';
import 'package:flirta/common/ui/theme/theme.dart';
import 'package:flutter/material.dart';

import '../tags/group_options_tags.dart';

class GenderTagsGroup extends StatefulWidget {
  const GenderTagsGroup({
    super.key,
    required this.title,
    required this.onChanged,
    this.initGender = Gender.none,
  });

  final Gender initGender;
  final String title;
  final Function(Gender newGender) onChanged;

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
        Text(widget.title, style: AppTheme.of(context).textStyle.header3),
        SizedBox(height: 16),
        GroupOptionsTags(
          tags: {
            Gender.female.getGenderForInterestedName(),
            Gender.male.getGenderForInterestedName(),
            Gender.nonBinary.getGenderForInterestedName(),
            Gender.none.getGenderForInterestedName(),
          },
          initTag: widget.initGender.getGenderForInterestedName(),
          onChange: (tags) {
            if (tags == Gender.female.getGenderForInterestedName()) {
              widget.onChanged(Gender.female);
            }
            if (tags == Gender.male.getGenderForInterestedName()) {
              widget.onChanged(Gender.male);
            }
            if (tags == Gender.nonBinary.getGenderForInterestedName()) {
              widget.onChanged(Gender.nonBinary);
            }
            if (tags == Gender.none.getGenderForInterestedName()) {
              widget.onChanged(Gender.none);
            }
          },
        ),
      ],
    );
  }
}
