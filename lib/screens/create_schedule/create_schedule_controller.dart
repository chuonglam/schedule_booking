import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:common/common.dart';
import 'package:schedule_booking/common/exts.dart';
import 'package:schedule_booking/common/loading_controller.dart';
import 'package:schedule_booking/common/styles.dart';
import 'package:schedule_booking/models/schedule_params.dart';
import 'package:schedule_booking/models/users_filter_params.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CreateScheduleController extends GetxController with LoadingController {
  final ScheduleRepository _scheduleRepository;
  final UserRepository _userRepository;

  static CreateScheduleController? get instance {
    try {
      return Get.find<CreateScheduleController>();
    } catch (_) {
      return null;
    }
  }

  CreateScheduleController(
      {required ScheduleRepository scheduleRepository,
      required UserRepository userRepository})
      : _scheduleRepository = scheduleRepository,
        _userRepository = userRepository;

  final Rx<ScheduleParams> _rxState = Rx(ScheduleParams(
    calendarDateTime: DateTime.now(),
    duration: const Duration(minutes: defaultBookingScheduleTimeInMins),
  ));
  ScheduleParams get state => _rxState.value;

  final Rxn<UsersFilterParams> _rxFilter = Rxn();
  UsersFilterParams? get filter => _rxFilter.value;

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
  }) {
    _rxState.value = _rxState.value.copyWith(
      calendarDateTime: dateTime,
      duration: duration,
      selectedUser: selectedUser,
    );
    if (selectedUser != null) {
      _clearBusyAreas();
      _getTimeSlots(selectedUser.id);
    }
  }

  String? updateFilter({
    String? usernameInput,
    TimeOfDay? fromTime,
    TimeOfDay? toTime,
    bool? isTimeSlotAscending,
  }) {
    final UsersFilterParams value = (filter ?? UsersFilterParams()).copyWith(
      usernameInput: usernameInput,
      fromTime: fromTime,
      toTime: toTime,
      isTimeSlotAscending: isTimeSlotAscending,
    );
    if (value.fromTime != null && value.toTime != null) {
      final DateTime now = DateTime.now();
      if (now.setTime(value.toTime!).isBefore(now.setTime(value.fromTime!))) {
        return '`to time` cannot be before `from time` in the same day';
      }
    }
    if (value.userNameInput?.isEmpty != false &&
        value.fromTime == null &&
        value.toTime == null &&
        value.isTimeSlotAscending) {
      clearFilter();
      return null;
    }
    _rxFilter.value = value;
    return null;
  }

  void _clearBusyAreas() {
    _rxBusyAreas.clear();
  }

  void _getTimeSlots(String participantId) async {
    final result = await _scheduleRepository.getTimeSlots(
        participantId, state.calendarDateTime);
    if (result.success) {
      _rxBusyAreas.assignAll(result.data ?? []);
    }
  }

  bool _isScheduleOverlapsed(TimeRegion selectedRegion) {
    return selectedRegion.isOverlapped(busyAreas
        .map((e) => TimeRegion(startTime: e.startDate, endTime: e.endDate))
        .toList());
  }

  Future<void> createSchedule() async {
    error = null;
    if (_isScheduleOverlapsed(state.toTimeRegion())) {
      return Future.delayed(const Duration(milliseconds: 300), () {
        error = 'Time overlaps';
        return;
      });
    }
    final result = await _scheduleRepository.createSchedule(
      startDate: state.calendarDateTime,
      duration: state.duration,
      participantId: state.selectedUser?.id,
    );
    if (result.success) {
      error = null;
      return;
    }
    error = result.error?.message;
  }

  void _resetState() {
    _rxState.value = _rxState.value.reset();
  }

  void resetAll() {
    _resetState();
    clearFilter();
    _initAppointment();
    _rxBusyAreas.clear();
  }

  void clearFilter() {
    _rxFilter.value = null;
  }

  Future<void> searchUsers() async {
    if (isLoading) {
      return;
    }
    final int durationInMins = state.duration.inMinutes;
    final DateTime selectedDate = state.calendarDateTime;
    final String? searchByName = filter?.userNameInput;
    final TimeOfDay? fromTime = filter?.fromTime, toTime = filter?.toTime;
    final bool sortingAscending = filter?.isTimeSlotAscending ?? true;
    _users.clear();
    _resetState();
    isLoading = true;
    final result = await _userRepository.getUsersList(
      durationInMins: durationInMins,
      nameSearch: searchByName,
      fromDate: selectedDate,
      fromTime: fromTime,
      toTime: toTime,
      sortAscending: sortingAscending,
    );
    isLoading = false;
    if (result.success) {
      _users.assignAll(result.data ?? []);
    }
  }
}
