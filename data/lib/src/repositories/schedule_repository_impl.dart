import 'package:data/data.dart';
import 'package:data/src/network/schedule_service.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ScheduleRepository)
class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleService _scheduleService;
  ScheduleRepositoryImpl({required ScheduleService scheduleService})
      : _scheduleService = scheduleService;

  @override
  Future<void> createSchedule({
    required DateTime startDate,
    required Duration duration,
    required String participantId,
  }) async {
    await _scheduleService.createSchedule(
      startDate: startDate,
      endDate: startDate.add(duration),
      participantId: participantId,
    );
  }

  @override
  Future<AppResult<List<Schedule>>> getTimeSlots(String participantId) async {
    try {
      final res = await _scheduleService.getTimeSlots(participantId);
      return AppResult.success(res.map((e) => e.toSchedule()).toList());
    } catch (e) {
      //todo: handle exceptions
      return AppResult.error(DefaultError(e.toString()));
    }
  }
}
