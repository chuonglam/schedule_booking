import 'package:data/data.dart';
import 'package:data/src/network/schedule_service.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ScheduleRepository)
class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleService _scheduleService;
  ScheduleRepositoryImpl({required ScheduleService scheduleService})
      : _scheduleService = scheduleService;

  @override
  Future<AppResult<String>> createSchedule({
    required DateTime startDate,
    required Duration duration,
    String? participantId,
  }) async {
    try {
      if (participantId == null) {
        return AppResult.error(UserNotPicked());
      }
      final res = await _scheduleService.createSchedule(
        startDate: startDate,
        endDate: startDate.add(duration),
        participantId: participantId,
      );
      //todo: handle results
      return AppResult.success(res);
    } on AppError catch (e) {
      return AppResult.error(e);
    } on Exception catch (e) {
      return AppResult.error(DefaultError(e.toString()));
    }
  }

  @override
  Future<AppResult<List<Schedule>>> getTimeSlots(String participantId) async {
    try {
      final res = await _scheduleService.getTimeSlots(participantId);
      return AppResult.success(res.map((e) => e.toSchedule()).toList());
    } on AppError catch (e) {
      //todo: handle exceptions
      return AppResult.error(e);
    } on Exception catch (e) {
      return AppResult.error(DefaultError());
    }
  }

  @override
  Future<AppResult<List<Schedule>>> getUserTimeSlots(
      {int limit = 0, int skip = 0}) async {
    try {
      final res =
          await _scheduleService.getUserTimeSlots(limit: limit, skip: skip);
      final List<Schedule> schedules = res.map((e) => e.toSchedule()).toList();
      schedules.sort((a, b) => a.endDate.compareTo(b.endDate));
      final now = DateTime.now();
      final idx =
          schedules.lastIndexWhere((element) => element.endDate.isBefore(now));
      final old = schedules.getRange(0, idx + 1);
      print('xxx old ${old.length}');
      schedules.addAll(old);
      schedules.removeRange(0, idx + 1);
      return AppResult.success(schedules);
    } on AppError catch (e) {
      return AppResult.error(e);
    } on Exception catch (e) {
      return AppResult.error(DefaultError());
    }
  }
}
