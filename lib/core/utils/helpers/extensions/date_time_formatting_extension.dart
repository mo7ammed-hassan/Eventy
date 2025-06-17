import 'package:intl/intl.dart';

extension DateTimeFormattingExtension on DateTime {
  String get formattedDate =>
      "${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/$year";

  String toFormattedFullDate() {
    final DateFormat formatter = DateFormat('d, MMMM yyyy');
    return formatter.format(this);
  }

  String toFormattedMonthAndYear() {
    final DateFormat formatter = DateFormat('MMMM yyyy');
    return formatter.format(this);
  }
}
