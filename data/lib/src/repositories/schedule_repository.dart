import 'package:data/data.dart';

abstract class ScheduleRepository {
  Future<void> createSchedule({
    required DateTime startDate,
    required Duration duration,
    required String participantId,
  });

  Future<AppResult<List<Schedule>>> getTimeSlots(String participantId);
}
