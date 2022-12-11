import 'package:common/common.dart';
import 'package:data/data.dart';
import 'package:data/src/network/schedule_service.dart';
import 'package:data/src/network/user_service.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ScheduleRepository)
class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleService _scheduleService;
  final UserService _userService;
  ScheduleRepositoryImpl({
    required ScheduleService scheduleService,
    required UserService userService,
  })  : _scheduleService = scheduleService,
        _userService = userService;

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
      return AppResult.success(res);
    } on AppError catch (e) {
      return AppResult.error(e);
    } on Exception catch (e) {
      return AppResult.error(DefaultError(e.toString()));
    }
  }

  @override
  Future<AppResult<List<Schedule>>> getTimeSlots(
    String participantId,
    DateTime? fromDate,
  ) async {
    try {
      fromDate = (fromDate ?? DateTime.now()).beginningOfDay();
      final res = await _scheduleService.getTimeSlots(
          participantId: participantId, fromDate: fromDate);
      final user = await _userService.currentUser();
      return AppResult.success(List<Schedule>.from(
          res.map((e) => e.toSchedule(currentUserId: user?.id))));
    } on AppError catch (e) {
      return AppResult.error(e);
    } on Exception catch (e) {
      return AppResult.error(DefaultError(e.toString()));
    }
  }

  @override
  Future<AppResult<List<Schedule>>> getUserTimeSlots(
      {int limit = 0, int skip = 0, DateTime? date}) async {
    try {
      date = (date ?? DateTime.now()).beginningOfDay();

      final res = await _scheduleService.getUserTimeSlots(fromDate: date);
      final List<Schedule> schedules = res.map((e) => e.toSchedule()).toList();
      return AppResult.success(schedules);
    } on AppError catch (e) {
      return AppResult.error(e);
    } on Exception catch (e) {
      return AppResult.error(DefaultError(e.toString()));
    }
  }
}
