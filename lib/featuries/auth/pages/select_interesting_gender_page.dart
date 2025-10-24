import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flirta/featuries/auth/widgets/auth_widgets.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:go_router/go_router.dart';

class SelectInterestingGenderPage extends StatelessWidget {
  const SelectInterestingGenderPage({
    super.key,
    required this.onFinishRegistration,
  });

  final Function onFinishRegistration;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthAppBar(
        totalSteps: 4,
        currentStep: 4,
        onBack: () {
          context.pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: BodyStepPage(
          title: LocaleKeys.auth_interested_title.tr(),
          content: InterestedGenderOptionsGroup(
            selectedOption: null,
            onChanged: (value) {},
          ),
          onPressed: () => onFinishRegistration(),
        ),
      ),
    );
  }
}
