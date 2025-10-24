import 'package:flirta/common/enums/gender_enums.dart';
import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/service/app_state_service.dart';
import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flirta/featuries/auth/widgets/auth_widgets.dart';
import 'package:flirta/generated/locale_keys.g.dart';
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
          content: GenderOptionsGroup<Gender>(
            options: [Gender.male, Gender.female, Gender.nonBinary],
            selectedOption: getIt<AppStateService>().currentUser.gender,
            onChanged: (value) {
              getIt<AppStateService>().currentUser = getIt<AppStateService>()
                  .currentUser
                  .copyWith(gender: value);
            },
          ),
          onPressed: () => onSelectInterestingGender(),
        ),
      ),
    );
  }
}
