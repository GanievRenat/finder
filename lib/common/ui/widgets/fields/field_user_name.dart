import 'package:flirta/common/ui/theme/app_spacing.dart';
import 'package:flirta/common/ui/widgets/tips/main_tips.dart';
import 'package:flutter/material.dart';

class FieldUserName extends StatefulWidget {
  const FieldUserName({super.key, required this.onChange, this.initName = ''});

  final String initName;
  final Function(String name) onChange;

  @override
  State<FieldUserName> createState() => _FieldUserNameState();
}

class _FieldUserNameState extends State<FieldUserName> {
  late TextEditingController controller;

  bool isError = false;
  bool showTips = true;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.initName);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          controller: controller,
          textAlign: TextAlign.center,
          decoration: InputDecoration(hintText: 'Name'),
          validator: (value) {
            if ((value ?? '').isEmpty) {
              setState(() {
                isError = true;
                showTips = true;
              });
              return null;
            } else {
              setState(() {
                isError = false;
              });
              return value;
            }
          },
          onFieldSubmitted: (value) {
            if (value.isEmpty) {
              setState(() {
                isError = true;
                showTips = true;
              });
            }
          },
          onChanged: (value) {
            setState(() {
              showTips = value.isEmpty;
            });
          },
        ),
        AppSpacing.vertical.s5,
        if (showTips) MainTips(tips: 'Please enter your name'),
      ],
    );
  }
}
