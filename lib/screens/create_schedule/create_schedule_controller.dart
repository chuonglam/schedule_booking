import 'package:data/data.dart';
import 'package:get/get.dart';

class CreateScheduleController extends GetxController
    with StateMixin<List<Schedule>> {
  final Rxn<Schedule> _selectedSchedule = Rxn();
  Schedule? get selectedSchedule => _selectedSchedule.value;
  @override
  void onInit() {
    super.onInit();
    change([], status: RxStatus.empty());
  }

  void selectSchedule(Schedule schedule) => _selectedSchedule(schedule);

  void search() async {
    try {
      change([], status: RxStatus.loading());
      await Future.delayed(const Duration(seconds: 2));
      change(
        [
          Schedule(
            user: User(id: '1', username: '1', email: ''),
            schedules: [15],
          ),
          Schedule(
            user: User(id: '2', username: '2', email: ''),
            schedules: [1, 3],
          ),
        ],
        status: RxStatus.success(),
      );
    } catch (_) {}
  }
}
