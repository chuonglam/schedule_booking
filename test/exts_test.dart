import 'package:flutter_test/flutter_test.dart';
import 'package:schedule_booking/common/exts.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() {
  group(
    'TimeRegionX',
    () {
      test(
        'should not be overlapped if data is correct',
        () {
          final now = DateTime.now();
          final TimeRegion data = TimeRegion(
            startTime: now,
            endTime: now.add(
              const Duration(hours: 1),
            ),
          );
          final List<TimeRegion> schedules = List<TimeRegion>.generate(
            10,
            (index) => TimeRegion(
                startTime: now.add(Duration(hours: index + 2)),
                endTime: now.add(Duration(hours: index + 3))),
          );
          final isOverlapped = data.isOverlapped(schedules);
          expect(isOverlapped, false);
        },
      );

      test(
        'should be overlapped if data is incorrect',
        () {
          final now = DateTime.now();
          final TimeRegion data = TimeRegion(
            startTime: now,
            endTime: now.add(
              const Duration(hours: 1, minutes: 2),
            ),
          );
          final List<TimeRegion> schedules = List<TimeRegion>.generate(
            10,
            (index) => TimeRegion(
                startTime: now.add(Duration(hours: index + 1)),
                endTime: now.add(Duration(hours: index + 2))),
          );
          final isOverlapped = data.isOverlapped(schedules);
          expect(isOverlapped, true);
        },
      );
    },
  );
}
