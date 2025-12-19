// ignore_for_file: must_be_immutable

import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AgeOption extends StatefulWidget {
  const AgeOption({
    super.key,
    required this.initAgeStart,
    required this.initAgeFinish,
    required this.onChanched,
  });

  final int initAgeStart;
  final int initAgeFinish;
  final Function(int ageStart, int ageFinish) onChanched;

  @override
  State<AgeOption> createState() => _AgeOptionState();
}

class _AgeOptionState extends State<AgeOption> {
  int oldValueMin = 0;
  int oldValueMax = 0;

  @override
  void initState() {
    super.initState();
    oldValueMin = widget.initAgeStart >= 18 ? widget.initAgeStart : 18;
    oldValueMax =
        (widget.initAgeFinish > widget.initAgeStart &&
            widget.initAgeFinish > 18 &&
            widget.initAgeFinish <= 60)
        ? widget.initAgeFinish
        : 60;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Age range',
                  style: AppTheme.of(context).textStyle.header3,
                ),
              ),
              Text(
                '$oldValueMin-$oldValueMax',
                style: AppTheme.of(context).textStyle.header5,
              ),
            ],
          ),
        ),
        SizedBox(height: 0),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: RangeSlider(
            min: 18,
            max: 60,
            values: RangeValues(oldValueMin.toDouble(), oldValueMax.toDouble()),
            onChangeEnd: (value) {
              widget.onChanched(value.start.toInt(), value.end.toInt());
            },
            onChanged: (value) {
              if (oldValueMin != value.start.toInt()) {
                if (value.start.toInt() == 18) {
                  HapticFeedback.heavyImpact();
                } else {
                  HapticFeedback.selectionClick();
                }
                oldValueMin = value.start.toInt();
              }
              if (oldValueMax != value.end.toInt()) {
                if (value.end.toInt() == 60) {
                  HapticFeedback.heavyImpact();
                } else {
                  HapticFeedback.selectionClick();
                }
                oldValueMax = value.end.toInt();
              }
              setState(() {});
            },
          ),
        ),
      ],
    );
  }
}
