import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  String format({String? formatter}) {
    final format = DateFormat(formatter ?? 'MM-dd-yyyy');
    return format.format(this);
  }
}
