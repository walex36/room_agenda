import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String hourMinutes() {
    final format = DateFormat('HH:mm');
    return format.format(this);
  }

  String dayMonthYear() {
    final format = DateFormat('dd/MM/yyyy');
    return format.format(this);
  }
}
