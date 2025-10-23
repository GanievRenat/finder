import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/service/app_state_service.dart';
import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flirta/featuries/auth/widgets/auth_widgets.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EnterAgePage extends StatelessWidget {
  const EnterAgePage({super.key, required this.onSelectGender});

  final Function onSelectGender;

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  LocaleKeys.auth_how_old_are_you_title.tr(),
                  style: AppTheme.of(context).textStyle.header1,
                  textAlign: TextAlign.center,
                ),
                Text(
                  LocaleKeys.auth_how_old_are_you_subtitle.tr(),
                  style: AppTheme.of(context).textStyle.bodyM,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SelectAge(
              beginAge: 18,
              endAge: 99,
              initAge: getIt<AppStateService>().currentUser.age,
              onChange: (age) {},
            ),
            MainButton(
              onPressed: () => onSelectGender(),
              title: LocaleKeys.auth_button_continue.tr(),
            ),
          ],
        ),
      ),
    );
  }
}
