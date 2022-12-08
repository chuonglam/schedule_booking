import 'package:data/data.dart';

abstract class ScheduleRepository {
  Future<AppResult<String>> createSchedule({
    required DateTime startDate,
    required Duration duration,
    String? participantId,
  });

  Future<AppResult<List<Schedule>>> getTimeSlots(String participantId);

  Future<AppResult<List<Schedule>>> getUserTimeSlots(
      {int limit = 0, int skip = 0, DateTime? date});
}
