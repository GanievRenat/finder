import 'package:flirta/common/enums/gender_enums.dart';
import 'package:flutter/material.dart';
import 'gender_option_item.dart';

class GenderOptionsGroup<T extends Gender> extends StatefulWidget {
  const GenderOptionsGroup({
    super.key,
    required this.options,
    required this.onChanged,
    this.selectedOption,
  });

  final List<T> options;
  final ValueChanged<T> onChanged;
  final T? selectedOption;

  @override
  State<GenderOptionsGroup<Gender>> createState() =>
      _GenderOptionsGroupState<Gender>();
}

class _GenderOptionsGroupState<T extends Gender>
    extends State<GenderOptionsGroup<Gender>> {
  Gender? value;

  @override
  void initState() {
    super.initState();
    value = widget.selectedOption;
  }

  @override
  void didUpdateWidget(covariant GenderOptionsGroup<T> oldWidget) {
    if (oldWidget.selectedOption != widget.selectedOption) {
      value = widget.selectedOption;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: widget.options
          .map(
            (option) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: GenderOptionItem<Gender>(
                title: option.getGenderName(),
                valuel: option,
                isSelected: option == value,
                onTap: (selectedOption) {
                  if (value != selectedOption) {
                    setState(() {
                      value = selectedOption;
                    });
                    widget.onChanged(selectedOption);
                  }
                },
              ),
            ),
          )
          .toList(),
    );
  }
}
