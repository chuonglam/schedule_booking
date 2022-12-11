import 'package:common/common.dart';
import 'package:data/data.dart';
import 'package:get/get.dart';
import 'package:schedule_booking/common/load_more_controller.dart';

class UserScheduleController extends GetxController
    with LoadMoreController<Schedule> {
  final ScheduleRepository _scheduleRepository;
  UserScheduleController({
    required ScheduleRepository scheduleRepository,
  }) : _scheduleRepository = scheduleRepository;

  static UserScheduleController? get instance {
    try {
      return Get.find<UserScheduleController>();
    } catch (e) {
      return null;
    }
  }

  final Rx<DateTime> _rxSelectedDate = Rx<DateTime>(DateTime.now());
  DateTime get selectedDate => _rxSelectedDate.value;
  set selectedDate(DateTime value) => _rxSelectedDate.value = value;

  Worker? _selectedDateChanges;

  @override
  void onInit() {
    super.onInit();
    _registerWorkers();
  }

  @override
  void dispose() {
    _disposeWorkers();
    super.dispose();
  }

  void _registerWorkers() {
    _selectedDateChanges = ever<DateTime>(
      _rxSelectedDate,
      (value) {
        doRefreshData();
      },
    );
  }

  void _disposeWorkers() {
    if (_selectedDateChanges?.disposed == true) {
      return;
    }
    _selectedDateChanges?.dispose();
  }

  @override
  Future<AppResult<List<Schedule>>> loadData(
      [int skip = 0, int limit = pageSize]) {
    return _scheduleRepository.getUserTimeSlots(
      limit: limit,
      skip: skip,
      date: selectedDate,
    );
  }
}
