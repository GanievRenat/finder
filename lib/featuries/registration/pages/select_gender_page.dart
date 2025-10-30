import 'package:flirta/common/enums/gender_enums.dart';
import 'package:flirta/common/router/toastification.dart';
import 'package:flirta/featuries/registration/state/registration_cubit.dart';
import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flirta/featuries/registration/widgets/auth_widgets.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SelectGenderPage extends StatelessWidget {
  const SelectGenderPage({super.key, required this.onSelectInterestingGender});

  final Function onSelectInterestingGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthAppBar(
        totalSteps: 4,
        currentStep: 3,
        onBack: () {
          context.pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: BodyStepPage(
          title: LocaleKeys.auth_you_identify_title.tr(),
          content: BlocBuilder<RegistrationCubit, RegistrationState>(
            bloc: getIt<RegistrationCubit>(),
            builder: (context, state) {
              return state.when(
                loading: () => Center(child: CircularProgressIndicator()),
                init: () => Center(child: CircularProgressIndicator()),
                data: (data) => GenderOptionsGroup<Gender>(
                  options: [Gender.male, Gender.female, Gender.nonBinary],
                  selectedOption: data.gender,
                  onChanged: (value) {
                    getIt<RegistrationCubit>().setGender(value);
                  },
                ),
              );
            },
          ),

          onPressed: () {
            if (getIt<RegistrationCubit>().currentData.gender != null) {
              getIt<RegistrationCubit>().saveCurrentState();
              onSelectInterestingGender();
            } else {
              getIt<AppToast>().show(
                context: context,
                message: LocaleKeys.auth_you_identify_tip.tr(),
              );
            }
          },
        ),
      ),
    );
  }
}
