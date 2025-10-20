import 'package:flirta/common/ui/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectAge extends StatefulWidget {
  const SelectAge({
    super.key,
    required this.beginAge,
    required this.endAge,
    required this.onChange,
    this.initAge = 20,
    this.height = 400,
  });

  final int beginAge;
  final int endAge;
  final int initAge;
  final Function(int age) onChange;
  final double height;

  @override
  State<SelectAge> createState() => _SelectAgeState();
}

class _SelectAgeState extends State<SelectAge> {
  int _selectedAge = 0;
  int begin = 0;
  int end = 0;

  @override
  void initState() {
    super.initState();
    if (widget.beginAge > widget.endAge) {
      begin = widget.endAge;
      end = widget.beginAge;
    } else {
      begin = widget.beginAge;
      end = widget.endAge;
    }
    if (widget.initAge >= begin && widget.initAge <= end) {
      _selectedAge = (widget.initAge - begin) + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: CupertinoPicker(
        magnification: 2,
        squeeze: 1,
        useMagnifier: true,
        itemExtent: 50,
        changeReportingBehavior: ChangeReportingBehavior.onScrollEnd,
        selectionOverlay: CupertinoPickerFlirtaSelection(),
        scrollController: FixedExtentScrollController(
          initialItem: _selectedAge,
        ),
        onSelectedItemChanged: (int selectedItem) {
          setState(() {
            _selectedAge = selectedItem;
          });
          widget.onChange(
            (selectedItem == 0) ? begin - 1 : (begin + selectedItem - 1),
          );
        },
        children: List<Widget>.generate((end - begin) + 2, (int index) {
          return Center(
            child: Text(
              (index == 0)
                  ? '< ${widget.beginAge}'
                  : '${widget.beginAge + index - 1}',
              style: AppTheme.of(context).textStyle.header1,
            ),
          );
        }),
      ),
    );
  }
}

class CupertinoPickerFlirtaSelection extends StatelessWidget {
  const CupertinoPickerFlirtaSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final kDriver = Divider(
      thickness: 1,
      height: 1,
      indent: 100,
      endIndent: 100,
      color: AppTheme.of(context).color.neutralLightDarkset,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 8),
        kDriver,
        Expanded(child: Container(color: Colors.transparent)),
        kDriver,
        SizedBox(height: 8),
      ],
    );
  }
}
