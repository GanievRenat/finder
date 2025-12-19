import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/ui/theme/theme.dart';
import 'package:flirta/featuries/dating/pages/dating/state/dating_cubit.dart';
import 'package:flirta/featuries/dating/pages/filter/state/filter_cubit.dart';
import 'package:go_router/go_router.dart';
import 'widgets/apply_filteres_button.dart';
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
            onPressed: () {
              getIt<FilterCubit>().clearState();
            },
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
              top: 2,
              right: 16,
              bottom: 16 + MediaQuery.of(context).padding.bottom,
            ),
            child: ApplyFilteresButton(
              onSaved: () async {
                //await getIt<StorageServices>().createFolders();
                getIt<DatingCubit>().getListDatingPerson();
                if (context.mounted) {
                  context.pop();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
