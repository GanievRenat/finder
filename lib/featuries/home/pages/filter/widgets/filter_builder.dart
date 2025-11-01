import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/featuries/home/pages/filter/state/filter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterBuilder extends StatelessWidget {
  const FilterBuilder({
    super.key,
    required this.init,
    required this.loading,
    required this.error,
    required this.success,
  });

  final WidgetBuilder init;
  final WidgetBuilder loading;
  final ValueWidgetBuilder error;
  final ValueWidgetBuilder success;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterState>(
      bloc: getIt<FilterCubit>()..init(),
      builder: (context, state) {
        return state.when(
          init: () => init(context),
          loading: () => loading(context),
          error: (errorText) => error(context, errorText.errorText, this),
          data: (FilterData filter, int timeStemp) =>
              success(context, filter, this),
        );
      },
    );
  }
}
