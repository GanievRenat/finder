import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flirta/featuries/dating/pages/filter/state/filter_cubit.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class ApplyFilteresButton extends StatefulWidget {
  const ApplyFilteresButton({super.key, required this.onSaved});

  final Function onSaved;

  @override
  State<ApplyFilteresButton> createState() => _ApplyFilteresButtonState();
}

class _ApplyFilteresButtonState extends State<ApplyFilteresButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MainButton(
      title: LocaleKeys.filter_button_apply_filter.tr(),
      isLoading: isLoading,
      onPressed: () async {
        setState(() {
          isLoading = true;
        });
        await getIt<FilterCubit>().saveState();
        setState(() {
          isLoading = false;
        });
        widget.onSaved();
      },
    );
  }
}
