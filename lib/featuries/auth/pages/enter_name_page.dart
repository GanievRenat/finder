import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/service/app_state_service.dart';
import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flirta/featuries/auth/widgets/auth_widgets.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

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
    void checkContinue() {
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

        OverlayManager.showOverlay(
          context: context,
          message: LocaleKeys.auth_welcome.tr(
            args: [getIt<AppStateService>().currentUser.name],
          ),
          onHideOverlay: () {
            widget.onEnterAge();
          },
        );
      }
    }

    Widget content = Form(
      key: formKey,
      child: FieldUserName(
        initName: getIt<AppStateService>().currentUser.name,
        onChange: (name) {
          getIt<AppStateService>().currentUser = getIt<AppStateService>()
              .currentUser
              .copyWith(name: name);
        },
        onFieldSubmitted: () {
          checkContinue();
        },
      ),
    );

    return KeyboardDismissOnTap(
      child: Scaffold(
        appBar: AuthAppBar(totalSteps: 4, currentStep: 1, onBack: null),
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
