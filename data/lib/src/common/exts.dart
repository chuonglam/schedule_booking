extension DateTimeX on DateTime {
  DateTime startOfDay() {
    final DateTime startOfDay = DateTime(year, month, day, 0, 0, 0, 0);
    return startOfDay;
  }

  DateTime endOfDay() {
    final DateTime endOfDay = DateTime(year, month, day, 23, 59, 59, 999);
    return endOfDay;
  }
}
