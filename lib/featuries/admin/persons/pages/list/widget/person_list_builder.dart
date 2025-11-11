import 'package:flirta/common/di/init_di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/person_list_cubit.dart';

class PersonListBuilder extends StatelessWidget {
  const PersonListBuilder({
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
    return BlocBuilder<PersonListCubit, PersonListState>(
      bloc: getIt<PersonListCubit>()..init(),
      builder: (context, state) {
        return state.when(
          init: () => init(context),
          loading: () => loading(context),
          error: (errorText) => error(context, errorText.errorText, this),
          data: (list) => success(context, list, this),
        );
      },
    );
  }
}
