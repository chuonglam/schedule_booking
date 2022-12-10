import 'package:flutter/material.dart';

extension DateTimeX on DateTime {
  DateTime beginningOfDay() {
    final DateTime startOfDay = DateTime(year, month, day, 0, 0, 0, 0);
    return startOfDay;
  }

  DateTime endOfDay() {
    final DateTime endOfDay = DateTime(year, month, day, 23, 59, 59, 999);
    return endOfDay;
  }

  bool isToday() {
    final DateTime now = DateTime.now();
    return (now.day == day && now.month == month && now.year == year);
  }
}
