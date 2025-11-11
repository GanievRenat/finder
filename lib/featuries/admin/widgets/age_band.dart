import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AgeBand extends StatefulWidget {
  const AgeBand({super.key, required this.onChanged, this.initValue = 18});

  final int? initValue;
  final Function(int value) onChanged;

  @override
  State<AgeBand> createState() => _AgeBandState();
}

class _AgeBandState extends State<AgeBand> {
  int selectAge = 18;

  @override
  void initState() {
    super.initState();
    selectAge = widget.initValue ?? 18;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Age:', style: AppTheme.of(context).textStyle.header5),
        Expanded(
          child: Slider(
            value: selectAge.toDouble(),
            onChanged: (value) {
              setState(() {
                selectAge = value.toInt();
              });
            },
            label: '$selectAge',
            onChangeEnd: (value) {
              widget.onChanged(value.toInt());
            },
            divisions: 50 - 18,
            max: 50,
            min: 18,
          ),
        ),
        Text('$selectAge', style: AppTheme.of(context).textStyle.header1),
      ],
    );
  }
}
