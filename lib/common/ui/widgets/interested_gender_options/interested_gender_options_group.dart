import 'package:flinder/common/enums/enums.dart';
import 'package:flinder/common/ui/theme/app_spacing.dart';
import 'package:flutter/material.dart';
import 'interested_gender_option_item.dart';

class InterestedGenderOptionsGroup extends StatefulWidget {
  const InterestedGenderOptionsGroup({
    super.key,
    required this.onChanged,
    this.selectedOption,
  });

  final ValueChanged<Gender> onChanged;
  final Gender? selectedOption;

  @override
  State<InterestedGenderOptionsGroup> createState() =>
      _InterestedGenderOptionsGroupState();
}

class _InterestedGenderOptionsGroupState
    extends State<InterestedGenderOptionsGroup> {
  Gender? value;

  @override
  void initState() {
    super.initState();
    value = widget.selectedOption;
  }

  @override
  void didUpdateWidget(covariant InterestedGenderOptionsGroup oldWidget) {
    if (oldWidget.selectedOption != widget.selectedOption) {
      value = widget.selectedOption;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: InterestedGenderOptionItem<Gender>(
                    title: 'Woman',
                    valuel: Gender.female,
                    isSelected: Gender.female == value,
                    image: Gender.female.getImageProvider(),
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
                AppSpacing.horizontal.s4,
                Expanded(
                  child: InterestedGenderOptionItem<Gender>(
                    title: 'Man',
                    valuel: Gender.male,
                    isSelected: Gender.male == value,
                    image: Gender.male.getImageProvider(),
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
              ],
            ),
          ),
          AppSpacing.vertical.s4,
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: InterestedGenderOptionItem<Gender>(
                    title: 'Non-binary',
                    valuel: Gender.nonBinary,
                    isSelected: Gender.nonBinary == value,
                    image: Gender.nonBinary.getImageProvider(),
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
                AppSpacing.horizontal.s4,
                Expanded(
                  child: InterestedGenderOptionItem<Gender>(
                    title: 'Everyone',
                    valuel: Gender.none,
                    isSelected: Gender.none == value,
                    image: Gender.none.getImageProvider(),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
