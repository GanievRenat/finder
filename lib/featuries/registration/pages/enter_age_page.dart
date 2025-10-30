import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/featuries/registration/state/registration_cubit.dart';
import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flirta/featuries/registration/widgets/auth_widgets.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EnterAgePage extends StatefulWidget {
  const EnterAgePage({
    super.key,
    required this.onSelectGender,
    required this.onTerms,
  });

  final Function onSelectGender;
  final Function onTerms;

  @override
  State<EnterAgePage> createState() => _EnterAgePageState();
}

class _EnterAgePageState extends State<EnterAgePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthAppBar(
        totalSteps: 4,
        currentStep: 2,
        onBack: () {
          context.pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: BodyStepPage(
          title: LocaleKeys.auth_how_old_are_you_title.tr(),
          subtitle: LocaleKeys.auth_how_old_are_you_subtitle.tr(),
          content: BlocBuilder<RegistrationCubit, RegistrationState>(
            bloc: getIt<RegistrationCubit>(),
            builder: (context, state) {
              return state.when(
                loading: () => Center(child: CircularProgressIndicator()),
                init: () => Center(child: CircularProgressIndicator()),
                data: (data) => SelectAge(
                  beginAge: 18,
                  endAge: 99,
                  initAge: data.age,
                  onChange: (age) {
                    getIt<RegistrationCubit>().setAge(age);
                  },
                ),
              );
            },
          ),
          onPressed: () async {
            if (getIt<RegistrationCubit>().currentData.age < 18) {
              var result = await AgeValidateDialog().present(context) ?? false;
              if (result) {
                widget.onTerms();
              }
            } else {
              await getIt<RegistrationCubit>().saveCurrentState();
              widget.onSelectGender();
            }
          },
        ),
      ),
    );
  }
}
