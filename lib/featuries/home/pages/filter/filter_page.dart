import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/ui/theme/theme.dart';
import 'package:flirta/common/ui/widgets/buttons/main_button.dart';
import 'package:flirta/featuries/home/pages/filter/state/filter_cubit.dart';
import 'widgets/filter_builder.dart';
import 'widgets/filter_state/filter_state_data.dart';
import 'widgets/filter_state/filter_state_loading.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.filter_title.tr()),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              LocaleKeys.filter_button_clear_all.tr(),
              style: AppTheme.of(context).textStyle.actionM.copyWith(
                color: AppTheme.of(context).color.primaryDarkset,
              ),
            ),
          ),
          SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FilterBuilder(
              init: (context) => FilterStateLoading(),
              loading: (context) => FilterStateLoading(),
              success: (BuildContext context, value, Widget? child) =>
                  FilterStateData(filterStateData: value),
              error: (BuildContext context, value, Widget? child) =>
                  Center(child: Text(value)),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 16,
              top: 16,
              right: 16,
              bottom: 16 + MediaQuery.of(context).padding.bottom,
            ),
            child: MainButton(
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
