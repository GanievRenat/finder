import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/generated/locale_keys.g.dart';
import 'package:flutter/foundation.dart';

import 'alert_dialog.dart';

@immutable
class AgeValidateDialog extends AlertDialogModel<bool> {
  AgeValidateDialog()
    : super(
        title: LocaleKeys.auth_not_old_enough_error_title.tr(),
        message: LocaleKeys.auth_not_old_enough_error_subtitle.tr(),
        buttons: [
          AlertDialogButton(
            type: TypeAlertDialogButton.second,
            title: LocaleKeys.auth_not_old_enough_error_button_terms.tr(),
            value: true,
          ),
          AlertDialogButton(
            type: TypeAlertDialogButton.main,
            title: LocaleKeys.auth_not_old_enough_error_button_got_it.tr(),
            value: false,
          ),
        ],
      );
}
