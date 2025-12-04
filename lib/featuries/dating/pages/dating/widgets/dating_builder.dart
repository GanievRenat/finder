import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/featuries/dating/pages/dating/state/dating_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DatingBuilder extends StatelessWidget {
  const DatingBuilder({
    super.key,
    required this.init,
    required this.loading,
    required this.empty,
    required this.completed,
    required this.error,
    required this.success,
  });

  final WidgetBuilder init;
  final WidgetBuilder loading;
  final WidgetBuilder empty;
  final WidgetBuilder completed;
  final ValueWidgetBuilder error;
  final ValueWidgetBuilder success;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DatingCubit, DatingState>(
      bloc: getIt<DatingCubit>(),
      builder: (context, state) {
        return state.when(
          init: () => init(context),
          loading: () => loading(context),
          empty: () => empty(context),
          complited: () => completed(context),
          error: (errorText) => error(context, errorText, this),
          data: (List<Person> persons) => success(context, persons, this),
        );
      },
    );
  }
}
