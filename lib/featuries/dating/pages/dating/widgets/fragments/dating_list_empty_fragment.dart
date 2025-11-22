import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/ui/theme/theme.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class DatingListEmptyFragment extends StatelessWidget {
  const DatingListEmptyFragment({super.key, required this.onRefresh});

  final Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        LocaleKeys.dating_text_empty_result_search.tr(),
        textAlign: TextAlign.center,
        style: AppTheme.of(context).textStyle.bodyM.copyWith(
          color: AppTheme.of(context).color.neutralLightDark,
        ),
      ),
    );
  }
}
