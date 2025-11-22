import 'dart:ui';

// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String toFormatMMMddyyyy(Locale currentLocale) {
    return DateFormat('MMM dd, yyyy', currentLocale.languageCode).format(this);
  }

  String toFormatHHmm() {
    return DateFormat('HH:mm').format(this);
  }

  String toFormatNameOfDayWeek(Locale currentLocale) =>
      DateFormat('EEEE', currentLocale.languageCode).format(this);

  DateTime combineWithTime(DateTime time) =>
      DateTime(year, month, day, time.hour, time.minute);

  bool toDay() {
    return (day == DateTime.now().day &&
        month == DateTime.now().month &&
        year == DateTime.now().year);
  }
}
