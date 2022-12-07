import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:schedule_booking/common/widgets/logo.dart';
import 'package:schedule_booking/common/styles.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

extension DateTimeX on DateTime {
  String format({String? formatter}) {
    final format = DateFormat(formatter ?? 'MM-dd-yyyy');
    return format.format(this);
  }
}

extension TimeRegionX on TimeRegion {
  bool isOverlapsed(List<TimeRegion> busyAreas) {
    return busyAreas.any((timeRegion) => _dateRangeOverlaps(this, timeRegion));
  }

  bool _dateRangeOverlaps(TimeRegion a, TimeRegion b) {
    if (!a.startTime.isAfter(b.startTime) && b.startTime.isBefore(a.endTime)) {
      return true;
    }
    if (a.startTime.isBefore(b.endTime) && !b.endTime.isAfter(a.endTime)) {
      return true;
    }
    if (b.startTime.isBefore(a.startTime) && a.endTime.isBefore(b.endTime)) {
      return true;
    }
    return false;
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
    Widget? content,
    Widget? icon,
    String? negativeText,
    String? positiveText,
  }) async {
    return showDialog<bool>(
      context: this,
      barrierDismissible: true,
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
                icon ?? const AppLogo(),
                const SizedBox(height: 8),
                Text(
                  title ?? "Alert",
                  style: AppStyles.medium.copyWith(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 16),
                if (subtitle != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "This is your schedule overview. Find your schedule details in the dashboard on our site after your confirmation",
                      textAlign: TextAlign.center,
                      style: AppStyles.regular.copyWith(
                        fontSize: 14,
                        color: Theme.of(this).textTheme.caption?.color,
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
}
