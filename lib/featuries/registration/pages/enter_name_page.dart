import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/featuries/registration/state/registration_cubit.dart';
import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flirta/featuries/registration/widgets/auth_widgets.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';

class EnterNamePage extends StatefulWidget {
  const EnterNamePage({super.key, required this.onEnterAge});

  final Function onEnterAge;

  @override
  State<EnterNamePage> createState() => _EnterNamePageState();
}

class _EnterNamePageState extends State<EnterNamePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void checkContinue() async {
      if (formKey.currentState!.validate()) {
        bool keyboardVisible = KeyboardVisibilityProvider.isKeyboardVisible(
          context,
        );
        if (keyboardVisible) {
          final currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        }

        await getIt<RegistrationCubit>().saveCurrentState();

        if (context.mounted) {
          OverlayManager.showOverlay(
            context: context,
            message: LocaleKeys.auth_welcome.tr(
              args: [getIt<RegistrationCubit>().currentData.name],
            ),
            onHideOverlay: () {
              widget.onEnterAge();
            },
          );
        }
      }
    }

    Widget content = BlocBuilder<RegistrationCubit, RegistrationState>(
      bloc: getIt<RegistrationCubit>(),
      builder: (context, state) {
        return state.when(
          loading: () => Center(child: CircularProgressIndicator()),
          init: () => Center(child: CircularProgressIndicator()),
          data: (data) => Form(
            key: formKey,
            child: FieldUserName(
              initName: data.name,
              onChange: (name) {
                getIt<RegistrationCubit>().setName(name);
              },
              onFieldSubmitted: () {
                checkContinue();
              },
            ),
          ),
        );
      },
    );

    return KeyboardDismissOnTap(
      child: Scaffold(
        appBar: AuthAppBar(
          totalSteps: 4,
          currentStep: 1,
          onBack: () => context.pop(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: BodyStepPage(
            title: LocaleKeys.auth_whats_your_name_title.tr(),
            content: content,
            onPressed: () => checkContinue(),
          ),
        ),
      ),
    );
  }
}
