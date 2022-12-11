import 'package:data/data.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ScheduleParams {
  final DateTime calendarDateTime;
  final Duration duration;
  final User? selectedUser;

  ScheduleParams({
    required this.calendarDateTime,
    required this.duration,
    this.selectedUser,
  });

  TimeRegion toTimeRegion() {
    return TimeRegion(
        startTime: calendarDateTime, endTime: calendarDateTime.add(duration));
  }

  ScheduleParams copyWith({
    DateTime? calendarDateTime,
    Duration? duration,
    User? selectedUser,
  }) {
    return ScheduleParams(
      calendarDateTime: calendarDateTime ?? this.calendarDateTime,
      duration: duration ?? this.duration,
      selectedUser: selectedUser ?? this.selectedUser,
    );
  }

  ScheduleParams reset() {
    return ScheduleParams(
      calendarDateTime: calendarDateTime,
      duration: duration,
      selectedUser: null,
    );
  }
}
