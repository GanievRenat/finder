import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flirta/featuries/profile/pages/profile/state/profile_cubit.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class NameEditWidget extends StatefulWidget {
  const NameEditWidget({
    super.key,
    required this.initName,
    required this.onComplited,
  });

  final String initName;
  final Function onComplited;

  @override
  State<NameEditWidget> createState() => _NameEditWidgetState();
}

class _NameEditWidgetState extends State<NameEditWidget> {
  String nameValue = '';
  bool isLoading = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameValue = widget.initName;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Form(
            key: formKey,
            child: FieldUserName(
              initName: nameValue,
              onChange: (name) {
                nameValue = name;
              },
              onFieldSubmitted: () {
                checkContinue();
              },
            ),
          ),
        ),
        MainButton(
          title: LocaleKeys.properties_buttons_save.tr(),
          isLoading: isLoading,
          onPressed: () async {
            checkContinue();
          },
        ),
      ],
    );
  }

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

      setState(() {
        isLoading = true;
      });
      getIt<ProfileCubit>().updateName(nameValue);
      setState(() {
        isLoading = false;
      });
      widget.onComplited();
    }
  }
}
