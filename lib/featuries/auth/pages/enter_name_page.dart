import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/service/app_state_service.dart';
import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flirta/featuries/auth/widgets/auth_widgets.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class EnterNamePage extends StatelessWidget {
  const EnterNamePage({super.key, required this.onEnterAge});

  final Function onEnterAge;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthAppBar(totalSteps: 4, currentStep: 1, onBack: null),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              LocaleKeys.auth_whats_your_name_title.tr(),
              style: AppTheme.of(context).textStyle.header1,
              textAlign: TextAlign.center,
            ),
            Form(
              child: FieldUserName(
                initName: getIt<AppStateService>().currentUser.name,
                onChange: (name) {},
              ),
            ),
            MainButton(
              onPressed: () => onEnterAge(),
              title: LocaleKeys.auth_button_continue.tr(),
            ),
          ],
        ),
      ),
    );
  }
}
