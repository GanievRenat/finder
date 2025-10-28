import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/foundation.dart';

@immutable
class DeleteAccountDialog extends AlertDialogModel<bool> {
  DeleteAccountDialog()
    : super(
        title: LocaleKeys.properties_dialogs_delete_account_title.tr(),
        message: LocaleKeys.properties_dialogs_delete_account_message.tr(),
        buttons: [
          AlertDialogButton(
            type: TypeAlertDialogButton.red,
            title: LocaleKeys.properties_dialogs_delete_account_button_delete
                .tr(),
            value: true,
          ),
          AlertDialogButton(
            type: TypeAlertDialogButton.second,
            title: LocaleKeys.properties_dialogs_delete_account_button_cancel
                .tr(),
            value: false,
          ),
        ],
      );
}
