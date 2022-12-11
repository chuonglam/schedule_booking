import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  String format({String? formatter}) {
    final format = DateFormat(formatter ?? 'MM-dd-yyyy');
    return format.format(this);
  }

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

  DateTime setTime(TimeOfDay tod) {
    return DateTime(year, month, day, tod.hour, tod.minute, 0, 0, 0);
  }
}

extension DurationX on Duration {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String toHourFormat() {
    String hours = (inMinutes ~/ 60).toString().padLeft(2, "0");
    String minutes = (inMinutes % 60).toString().padLeft(2, "0");
    return "$hours:$minutes";
  }
}

extension BuildContextX on BuildContext {
  bool get isSmallScreen => MediaQuery.of(this).size.width < 650;

  bool get isMediumScreen {
    final width = MediaQuery.of(this).size.width;
    return width >= 650 && width < 1000;
  }

  bool get isLargeScreen {
    return MediaQuery.of(this).size.width >= 1000;
  }

  Future<bool?> dialog({
    String? title,
    String? subtitle,
    bool barrierDismissible = true,
    Widget? content,
    Widget? icon,
    String? negativeText,
    String? positiveText,
  }) async {
    return showDialog<bool>(
      context: this,
      barrierDismissible: barrierDismissible,
      builder: (ctx) {
        return AlertDialog(
          actionsPadding: const EdgeInsets.all(16),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          content: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 500,
              minWidth: 450,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) icon,
                const SizedBox(height: 8),
                Text(
                  title ?? "Alert",
                  style: Theme.of(this).textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                if (subtitle != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "This is your schedule overview. Find your schedule details in the dashboard on our site after your confirmation",
                      textAlign: TextAlign.center,
                      style: Theme.of(this).textTheme.caption?.copyWith(
                            fontSize: 14,
                          ),
                    ),
                  ),
                const SizedBox(height: 16),
                if (content != null) content,
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text(positiveText ?? "OK"),
              onPressed: () {
                Navigator.of(ctx).pop(true);
              },
            ),
            if (negativeText != null)
              ElevatedButton(
                child: Text(negativeText),
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
              ),
          ],
        );
      },
    );
  }
}

extension StringX on String {
  bool isValidUsername() {
    final regex = RegExp(r"^[A-Za-z][A-Za-z0-9_]{4,16}$");
    return regex.hasMatch(this);
  }

  bool isValidEmail() {
    final regex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    return regex.hasMatch(this);
  }

  String get imgPath => "assets/img/$this";

  String get svgPath => "assets/svg/$this";
}
