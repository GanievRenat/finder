import 'package:flirta/common/di/init_di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/paywall_cubit.dart';

class PayWallBuilder extends StatelessWidget {
  const PayWallBuilder({
    super.key,
    required this.init,
    required this.loading,
    required this.error,
    required this.success,
  });

  final WidgetBuilder init;
  final WidgetBuilder loading;
  final ValueWidgetBuilder error;
  final ValueWidgetBuilder<PayWallData> success;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaywallCubit, PaywallState>(
      bloc: getIt<PaywallCubit>(),
      builder: (context, state) {
        return state.when(
          init: () => init(context),
          loading: () => loading(context),
          error: (errorText) => error(context, errorText, this),
          data: (PayWallData data) => success(context, data, this),
        );
      },
    );
  }
}
