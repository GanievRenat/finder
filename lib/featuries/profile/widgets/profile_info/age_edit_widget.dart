import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flirta/featuries/profile/pages/profile/state/profile_cubit.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class AgeEditWidget extends StatefulWidget {
  const AgeEditWidget({
    super.key,
    required this.initAge,
    required this.onComplited,
  });

  final int initAge;
  final Function onComplited;

  @override
  State<AgeEditWidget> createState() => _AgeEditWidgetState();
}

class _AgeEditWidgetState extends State<AgeEditWidget> {
  int ageValue = 25;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    ageValue = widget.initAge;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SelectAge(
            beginAge: 18,
            endAge: 99,
            initAge: widget.initAge,
            onChange: (age) {
              setState(() {
                ageValue = age;
              });
            },
          ),
        ),
        MainButton(
          title: LocaleKeys.properties_buttons_save.tr(),
          isLoading: isLoading,
          onPressed: ageValue > 17
              ? () async {
                  setState(() {
                    isLoading = true;
                  });
                  getIt<ProfileCubit>().updateAge(ageValue);
                  setState(() {
                    isLoading = false;
                  });
                  widget.onComplited();
                }
              : null,
        ),
      ],
    );
  }
}
