import 'package:data/data.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ScheduleParams {
  final DateTime calendarDateTime;
  final Duration duration;
  final String? userNameInput;
  final User? selectedUser;

  ScheduleParams({
    required this.calendarDateTime,
    required this.duration,
    this.userNameInput,
    this.selectedUser,
  });

  TimeRegion toTimeRegion() {
    return TimeRegion(
        startTime: calendarDateTime, endTime: calendarDateTime.add(duration));
  }

  ScheduleParams copyWith({
    DateTime? calendarDateTime,
    Duration? duration,
    String? userNameInput,
    User? selectedUser,
  }) {
    return ScheduleParams(
      calendarDateTime: calendarDateTime ?? this.calendarDateTime,
      duration: duration ?? this.duration,
      userNameInput: userNameInput ?? this.userNameInput,
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
