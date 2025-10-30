import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/featuries/profile/pages/profile/state/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBuilder extends StatelessWidget {
  const ProfileBuilder({
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
    return BlocBuilder<ProfileCubit, ProfileState>(
      bloc: getIt<ProfileCubit>(),
      builder: (context, state) {
        return state.when(
          init: () => init(context),
          loading: () => loading(context),
          error: (errorText) => error(context, errorText, this),
          data: (User user) => success(context, user, this),
        );
      },
    );
  }
}
