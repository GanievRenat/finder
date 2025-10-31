import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/router/toastification.dart';
import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flirta/featuries/profile/pages/profile/state/profile_cubit.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class DeleteProfileButton extends StatefulWidget {
  const DeleteProfileButton({
    super.key,
    required this.onSuccess,
    required this.onDialogDeleteProfile,
  });
  final Function onSuccess;
  final Future<bool?> Function() onDialogDeleteProfile;

  @override
  State<DeleteProfileButton> createState() => _DeleteProfileButtonState();
}

class _DeleteProfileButtonState extends State<DeleteProfileButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MainButton.red(
      title: LocaleKeys.user_profile_menu_your_profile_button_delete_account
          .tr(),
      onPressed: () async {
        var result = await widget.onDialogDeleteProfile() ?? false;
        if (result) {
          setState(() {
            isLoading = true;
          });
          var resultDelete = await getIt<ProfileCubit>().deleteProfile();
          if (resultDelete.isRight) {
            Future.delayed(
              Duration(milliseconds: 100),
              () => widget.onSuccess(),
            );
          } else {
            if (context.mounted) {
              getIt<AppToast>().show(
                context: context,
                message: resultDelete.left.errorText,
              );
            }
          }
          setState(() {
            isLoading = false;
          });
        }
      },
    );
  }
}
