import 'package:data/data.dart';
import 'package:get/get.dart';
import 'package:schedule_booking/common/loading_controller.dart';
import 'package:schedule_booking/screens/create_schedule/widgets/pick_timeslot_widget_v2.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CreateScheduleController extends GetxController with LoadingController {
  final ScheduleRepository _scheduleRepository;
  final UserRepository _userRepository;

  CreateScheduleController(
      {required ScheduleRepository scheduleRepository,
      required UserRepository userRepository})
      : _scheduleRepository = scheduleRepository,
        _userRepository = userRepository;

  final RxList<User> _users = RxList([]);

  List<User> get users => _users;

  final Rx<Duration> _rxDuration = const Duration(hours: 1).obs;

  Duration get duration => _rxDuration.value;

  set duration(Duration value) => _rxDuration.value = value;

  final Rxn<User> _rxSelectedUser = Rxn();

  User? get selectedUser => _rxSelectedUser.value;

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  set selectedDate(DateTime value) => _selectedDate = value;

  final RxList<Schedule> _rxRegions = RxList([]);

  List<Schedule> get regions => _rxRegions;

  final Rx<AppointmentDataSource> _source = Rx(AppointmentDataSource([
    Appointment(
      startTime: DateTime.now(),
      endTime: DateTime.now().add(const Duration(hours: 1)),
      subject: 'Meeting',
      startTimeZone: '',
      endTimeZone: '',
    )
  ]));

  AppointmentDataSource get source => _source.value;

  @override
  void onInit() {
    super.onInit();
    ever<Duration>(_rxDuration, (value) {
      _source.value = AppointmentDataSource([
        Appointment(
          startTime: DateTime.now(),
          endTime: DateTime.now().add(value),
          subject: 'Meeting',
          startTimeZone: '',
          endTimeZone: '',
        )
      ]);
    });
  }

  void selectUser(User schedule) {
    _rxSelectedUser.value = schedule;
    _rxRegions.clear();
    getTimeSlots(schedule.id);
  }

  void getTimeSlots(String participantId) async {
    final result = await _scheduleRepository.getTimeSlots(participantId);
    if (result.success) {
      _rxRegions.assignAll(result.data ?? []);
    }
  }

  Future<void> createSchedule() async {
    if (selectedUser == null) {
      return;
    }
    final res = await _scheduleRepository.createSchedule(
      startDate: _selectedDate,
      duration: duration,
      participantId: selectedUser!.id,
    );
  }

  void resetData() {
    _rxSelectedUser.value = null;
    _users.clear();
  }

  void search() async {
    if (isLoading) {
      return;
    }
    resetData();
    isLoading = true;
    final result = await _userRepository.getUsersList();
    if (result.success) {
      _users.assignAll(result.data ?? []);
    }
    isLoading = false;
  }
}
