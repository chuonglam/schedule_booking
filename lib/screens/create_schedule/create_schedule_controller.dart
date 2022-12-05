import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_booking/common/exts.dart';
import 'package:schedule_booking/common/loading_controller.dart';
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

  final Rx<Appointment> _appointment = Rx(Appointment(
    startTime: DateTime.now(),
    endTime: DateTime.now().add(const Duration(hours: 1)),
    subject: 'Meeting',
    startTimeZone: '',
    endTimeZone: '',
  ));

  Appointment get appointment => _appointment.value;

  @override
  void onInit() {
    super.onInit();
    ever<ScheduleParams>(_rxState, (value) {
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
      _rxBusyAreas.clear();
      getTimeSlots(selectedUser.id);
    }
  }

  void getTimeSlots(String participantId) async {
    final result = await _scheduleRepository.getTimeSlots(participantId);
    if (result.success) {
      _rxBusyAreas.assignAll(result.data ?? []);
    }
  }

  Future<void> createSchedule() async {
    if (state.selectedUser == null) {
      return;
    }
    final result = await _scheduleRepository.createSchedule(
      startDate: state.calendarDateTime,
      duration: state.duration,
      participantId: state.selectedUser!.id,
    );
  }

  void resetData() {
    _rxState.value = _rxState.value.reset();
    _users.clear();
  }

  void search() async {
    try {
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
    } catch (e, trace) {
      debugPrintStack(stackTrace: trace);
    }
  }
}
