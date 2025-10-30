import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/enums/enums.dart';
import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flirta/featuries/profile/pages/profile/state/profile_cubit.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class GenderEditWidget extends StatefulWidget {
  const GenderEditWidget({
    super.key,
    required this.initGender,
    required this.onComplited,
  });

  final Gender initGender;
  final Function onComplited;

  @override
  State<GenderEditWidget> createState() => _GenderEditWidgetState();
}

class _GenderEditWidgetState extends State<GenderEditWidget> {
  Gender genderValue = Gender.none;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    genderValue = widget.initGender;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GenderOptionsGroup<Gender>(
            options: [Gender.male, Gender.female, Gender.nonBinary],
            selectedOption: genderValue,
            onChanged: (value) {
              genderValue = value;
            },
          ),
        ),
        MainButton(
          title: LocaleKeys.properties_buttons_save.tr(),
          isLoading: isLoading,
          onPressed: () async {
            setState(() {
              isLoading = true;
            });
            getIt<ProfileCubit>().updateGender(genderValue);
            setState(() {
              isLoading = false;
            });
            widget.onComplited();
          },
        ),
      ],
    );
  }
}
