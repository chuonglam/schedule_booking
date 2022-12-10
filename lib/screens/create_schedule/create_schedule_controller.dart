import 'package:data/data.dart';
import 'package:get/get.dart';
import 'package:schedule_booking/common/exts.dart';
import 'package:schedule_booking/common/loading_controller.dart';
import 'package:schedule_booking/common/styles.dart';
import 'package:schedule_booking/models/schedule_params.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CreateScheduleController extends GetxController with LoadingController {
  final ScheduleRepository _scheduleRepository;
  final UserRepository _userRepository;

  CreateScheduleController(
      {required ScheduleRepository scheduleRepository,
      required UserRepository userRepository})
      : _scheduleRepository = scheduleRepository,
        _userRepository = userRepository;

  final Rx<ScheduleParams> _rxState = Rx(ScheduleParams(
    calendarDateTime: DateTime.now(),
    duration: const Duration(hours: 1),
  ));

  ScheduleParams get state => _rxState.value;

  final RxList<User> _users = RxList([]);

  List<User> get users => _users;

  final RxList<Schedule> _rxBusyAreas = RxList([]);

  List<Schedule> get busyAreas => _rxBusyAreas;

  final Rxn<Appointment> _appointment = Rxn();

  Appointment? get appointment => _appointment.value;

  Worker? _onStateChanged;
  @override
  void onInit() {
    super.onInit();
    _initAppointment();
    _registerWorkers();
  }

  void _initAppointment() {
    final DateTime start = state.calendarDateTime;
    final DateTime end = start.add(state.duration);
    _appointment.value = Appointment(
      startTime: start,
      endTime: end,
      subject:
          '${start.format(formatter: 'HH:mm')} - ${end.format(formatter: "HH:mm")}',
      color: AppStyles.mainColor,
    );
  }

  @override
  void dispose() {
    _disposeWorkers();
    super.dispose();
  }

  void _registerWorkers() {
    _onStateChanged = ever<ScheduleParams>(_rxState, (value) {
      _appointment.update((val) {
        final now = DateTime.now();
        val?.startTime =
            now.isAfter(value.calendarDateTime) ? now : value.calendarDateTime;
        val?.endTime = val.startTime.add(value.duration);
        val?.subject =
            '${val.startTime.format(formatter: 'HH:mm')} - ${val.endTime.format(formatter: 'HH:mm')}';
      });
    });
  }

  void _disposeWorkers() {
    if (_onStateChanged?.disposed == false) {
      _onStateChanged?.dispose();
    }
  }

  void updateState({
    Duration? duration,
    User? selectedUser,
    DateTime? dateTime,
    String? userNameInput,
  }) {
    _rxState.value = _rxState.value.copyWith(
      calendarDateTime: dateTime,
      duration: duration,
      userNameInput: userNameInput,
      selectedUser: selectedUser,
    );
    if (selectedUser != null) {
      _clearBusyAreas();
      _getTimeSlots(selectedUser.id);
    }
  }

  void _clearBusyAreas() {
    _rxBusyAreas.clear();
  }

  void _getTimeSlots(String participantId) async {
    final result = await _scheduleRepository.getTimeSlots(participantId);
    if (result.success) {
      _rxBusyAreas.assignAll(result.data ?? []);
    }
  }

  bool _isScheduleOverlapsed(TimeRegion selectedRegion) {
    return selectedRegion.isOverlapsed(busyAreas
        .map((e) => TimeRegion(startTime: e.startDate, endTime: e.endDate))
        .toList());
  }

  Future<String?> createSchedule() async {
    if (_isScheduleOverlapsed(state.toTimeRegion())) {
      return Future.delayed(const Duration(milliseconds: 300), () {
        return Future.value('Time overlaps');
      });
    }
    final result = await _scheduleRepository.createSchedule(
      startDate: state.calendarDateTime,
      duration: state.duration,
      participantId: state.selectedUser?.id,
    );
    if (result.success) {
      return null;
    }
    return result.error?.message;
  }

  void _resetData() {
    _rxState.value = _rxState.value.reset();
  }

  void search() async {
    if (isLoading) {
      return;
    }
    final String? searchByName = state.userNameInput;
    final int durationInMins = state.duration.inMinutes;
    final DateTime selectedDate = state.calendarDateTime;
    _users.clear();
    _resetData();
    isLoading = true;
    final result = await _userRepository.getUsersList(
      durationInMins: durationInMins,
      nameSearch: searchByName,
      fromDate: selectedDate,
    );
    isLoading = false;
    if (result.success) {
      _users.assignAll(result.data ?? []);
    }
  }
}
