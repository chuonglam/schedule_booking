import 'package:data/data.dart';
import 'package:get/get.dart';
import 'package:schedule_booking/common/constants.dart';
import 'package:schedule_booking/common/load_more_controller.dart';

class UserScheduleController extends GetxController
    with LoadMoreController<Schedule> {
  final ScheduleRepository _scheduleRepository;
  UserScheduleController({
    required ScheduleRepository scheduleRepository,
  }) : _scheduleRepository = scheduleRepository;

  @override
  Future<AppResult<List<Schedule>>> loadData(
      [int skip = 0, int limit = pageSize]) {
    return _scheduleRepository.getUserTimeSlots(limit: limit, skip: skip);
  }
}
