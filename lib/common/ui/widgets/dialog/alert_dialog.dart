import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flirta/common/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';

enum TypeAlertDialogButton { main, black, second, red }

class AlertDialogButton<T> {
  final TypeAlertDialogButton type;
  final String title;
  final T value;

  AlertDialogButton({
    required this.type,
    required this.title,
    required this.value,
  });
}

extension PresentAlertButton<T> on AlertDialogButton<T> {
  Widget present(BuildContext context) {
    if (type == TypeAlertDialogButton.second) {
      return SecondButton.small(
        title: title,
        onPressed: () => Navigator.of(context).pop(value),
      );
    } else if (type == TypeAlertDialogButton.black) {
      return BlackButton(
        title: title,
        onPressed: () => Navigator.of(context).pop(value),
      );
    } else if (type == TypeAlertDialogButton.red) {
      return MainButton.redSmall(
        title: title,
        onPressed: () => Navigator.of(context).pop(value),
      );
    } else {
      return MainButton.small(
        title: title,
        onPressed: () => Navigator.of(context).pop(value),
      );
    }
  }
}

@immutable
class AlertDialogModel<T> {
  final String title;
  final String message;
  final List<AlertDialogButton<T>> buttons;

  const AlertDialogModel({
    required this.title,
    required this.message,
    required this.buttons,
  });
}

extension Present<T> on AlertDialogModel<T> {
  Future<T?> present(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
          backgroundColor: AppTheme.of(context).color.background,
          insetPadding: const EdgeInsets.all(16),
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: AppTheme.of(context).textStyle.header3,
          ),
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: AppTheme.of(context).textStyle.bodyM.copyWith(
              color: AppTheme.of(context).color.neutralDarkLight,
            ),
          ),
          actions: [
            Row(
              children: buttons
                  .map(
                    (e) => Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: (e == buttons.first) ? 0 : 8.0,
                        ),
                        child: e.present(context),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        );
      },
    );
  }
}
