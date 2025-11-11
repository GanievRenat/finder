import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SegmentValueTen extends StatefulWidget {
  const SegmentValueTen({
    super.key,
    required this.onChanged,
    required this.title,
    this.initValue = 1,
  });

  final int? initValue;
  final String title;
  final Function(int value) onChanged;

  @override
  State<SegmentValueTen> createState() => _SegmentValueTenState();
}

class _SegmentValueTenState extends State<SegmentValueTen> {
  int selectValue = 1;

  @override
  void initState() {
    super.initState();
    selectValue = widget.initValue ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              '${widget.title}:',
              style: AppTheme.of(context).textStyle.header5,
            ),
          ),
          Expanded(
            flex: 7,
            child: SegmentedButton(
              multiSelectionEnabled: false,
              selected: {selectValue},
              showSelectedIcon: false,
              segments: [
                ButtonSegment(value: 1, label: Text('1')),
                ButtonSegment(value: 2, label: Text('2')),
                ButtonSegment(value: 3, label: Text('3')),
                ButtonSegment(value: 4, label: Text('4')),
                ButtonSegment(value: 5, label: Text('5')),
                ButtonSegment(value: 6, label: Text('6')),
                ButtonSegment(value: 7, label: Text('7')),
                ButtonSegment(value: 8, label: Text('8')),
                ButtonSegment(value: 9, label: Text('9')),
                ButtonSegment(value: 10, label: Text('10')),
              ],
              onSelectionChanged: (value) {
                setState(() {
                  selectValue = value.first;
                });
                widget.onChanged(selectValue);
              },
            ),
          ),
        ],
      ),
    );
  }
}
