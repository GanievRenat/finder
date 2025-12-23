import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/router/toastification.dart';
import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class FieldUserName extends StatefulWidget {
  const FieldUserName({
    super.key,
    required this.onChange,
    required this.onFieldSubmitted,
    this.initName = '',
  });

  final String initName;
  final Function(String name) onChange;
  final Function onFieldSubmitted;

  @override
  State<FieldUserName> createState() => _FieldUserNameState();
}

class _FieldUserNameState extends State<FieldUserName> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          initialValue: widget.initName,
          textAlign: TextAlign.center,
          errorBuilder: (context, errorText) => const SizedBox.shrink(),
          decoration: InputDecoration(
            hintText: LocaleKeys.auth_your_name_hint.tr(),
            errorStyle: TextStyle(height: 0, fontSize: 0),
          ),
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.sentences,
          style: AppTheme.of(context).textStyle.bodyXL,
          textInputAction: TextInputAction.next,
          maxLength: 25,
          validator: (value) {
            if ((value ?? '').trim().isEmpty) {
              getIt<AppToast>().show(
                context: context,
                message: LocaleKeys.auth_please_enter_you_name.tr(),
              );
              return '';
            }
            return null;
          },
          onChanged: (value) => widget.onChange(value),
          onFieldSubmitted: (value) => widget.onFieldSubmitted(),
        ),
      ],
    );
  }
}
