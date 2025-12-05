import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/enums/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'paywall_data.dart';
part 'paywall_state.dart';
part 'paywall_cubit.freezed.dart';

@singleton
class PaywallCubit extends Cubit<PaywallState> {
  PaywallCubit() : super(PaywallState.init());

  Future<void> init() async {}
}
