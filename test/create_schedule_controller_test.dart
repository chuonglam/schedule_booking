import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:schedule_booking/screens/create_schedule/create_schedule_controller.dart';
import 'mocks/mocks.dart';

void main() {
  late ScheduleRepository scheduleRepository;
  late UserRepository userRepository;
  late CreateScheduleController scheduleController;

  setUp(() {
    userRepository = MockUserRepository();
    scheduleRepository = MockScheduleRepository();
    scheduleController = CreateScheduleController(
      scheduleRepository: scheduleRepository,
      userRepository: userRepository,
    );
  });

  tearDown(() {
    Get.delete<CreateScheduleController>();
  });

  group(
    'searchUsers()',
    () {
      test(
        'should return data if success',
        () async {
          final MockListUsersAppResult result = MockListUsersAppResult();
          final List<MockUser> data = List.generate(10, (_) => MockUser());
          when(() => result.data).thenReturn(data);
          when(() => result.success).thenReturn(true);
          when(() => result.error).thenReturn(null);
          when(() => userRepository.getUsersList(
                durationInMins: any<int>(named: 'durationInMins'),
                nameSearch: any<String?>(named: 'nameSearch'),
                fromDate: any<DateTime?>(named: 'fromDate'),
                fromTime: any<TimeOfDay?>(named: 'fromTime'),
                toTime: any<TimeOfDay?>(named: 'toTime'),
                sortAscending: any<bool?>(named: 'sortAscending'),
              )).thenAnswer((invocation) async => result);
          await scheduleController.searchUsers();
          expect(scheduleController.users.length, data.length);
        },
      );

      test(
        'should return empty list if result fails',
        () async {
          final MockListUsersAppResult result = MockListUsersAppResult();
          when(() => result.data).thenReturn([]);
          when(() => result.success).thenReturn(false);
          when(() => result.error).thenReturn(DefaultError());
          when(() => userRepository.getUsersList(
                durationInMins: any<int>(named: 'durationInMins'),
                nameSearch: any<String?>(named: 'nameSearch'),
                fromDate: any<DateTime?>(named: 'fromDate'),
                fromTime: any<TimeOfDay?>(named: 'fromTime'),
                toTime: any<TimeOfDay?>(named: 'toTime'),
                sortAscending: any<bool?>(named: 'sortAscending'),
              )).thenAnswer((invocation) async => result);
          await scheduleController.searchUsers();
          expect(scheduleController.users.length, 0);
        },
      );
    },
  );

  group(
    'createSchedule()',
    () {
      final DateTime now = DateTime.now();

      //this list starts from now
      final timeSlots = List.generate(5, (idx) {
        MockSchedule schedule = MockSchedule();
        when(() => schedule.startDate)
            .thenReturn(now.add(Duration(hours: idx)));
        when(() => schedule.endDate)
            .thenReturn(now.add(Duration(hours: idx + 1)));
        return schedule;
      });

      test(
        'should be success if selected time slot doesn`t overlaps',
        () async {
          final user = MockUser();
          final MockListSchedulesAppResult appResultSchedulesList =
              MockListSchedulesAppResult();
          final MockCreateScheduleAppResult appResultCreateSchedule =
              MockCreateScheduleAppResult();

          when(() => user.id).thenReturn('id');
          when(() => appResultSchedulesList.data).thenReturn(timeSlots);
          when(() => appResultSchedulesList.error).thenReturn(null);
          when(() => appResultSchedulesList.success).thenReturn(true);
          when(() => scheduleRepository.getTimeSlots(
                  any<String>(), any<DateTime?>()))
              .thenAnswer((invocation) async => appResultSchedulesList);

          const Duration createScheduleInputDuration = Duration(hours: 1);
          final DateTime createScheduleInputStartTime =
              now.subtract(const Duration(hours: 1));
          when(() => appResultCreateSchedule.success).thenReturn(true);
          when(() => appResultCreateSchedule.error).thenReturn(null);
          when(() => appResultCreateSchedule.data).thenReturn(true);
          when(() => scheduleRepository.createSchedule(
                startDate: createScheduleInputStartTime,
                duration: createScheduleInputDuration,
                participantId: any<String?>(named: 'participantId'),
              )).thenAnswer((invocation) async => appResultCreateSchedule);

          Get.put(scheduleController);

          scheduleController.updateState(
            duration: createScheduleInputDuration,
            selectedUser: user,
            dateTime: createScheduleInputStartTime,
          );
          await Future.delayed(const Duration(milliseconds: 300));
          expect(scheduleController.busyAreas.length, timeSlots.length);
          await scheduleController.createSchedule();
          expect(scheduleController.error, isNull);
        },
      );

      test(
        'should have `Time overlaps` error if selected time slot overlaps',
        () async {
          final user = MockUser();
          final appResultSchedulesList = MockListSchedulesAppResult();

          when(() => user.id).thenReturn('id');
          when(() => appResultSchedulesList.data).thenReturn(timeSlots);
          when(() => appResultSchedulesList.error).thenReturn(null);
          when(() => appResultSchedulesList.success).thenReturn(true);
          when(() => scheduleRepository.getTimeSlots(
                  any<String>(), any<DateTime>()))
              .thenAnswer((invocation) async => appResultSchedulesList);

          Get.put(scheduleController);

          scheduleController.updateState(
            duration: const Duration(hours: 1),
            selectedUser: user,
            dateTime: now,
          );
          await Future.delayed(const Duration(milliseconds: 300));
          expect(scheduleController.busyAreas.length, timeSlots.length);
          await scheduleController.createSchedule();
          expect(scheduleController.error, 'Time overlaps');
        },
      );

      test(
        'should have error if a participant is not selected',
        () async {
          final user = MockUser();
          final MockListSchedulesAppResult appResultSchedulesList =
              MockListSchedulesAppResult();
          final MockCreateScheduleAppResult appResultCreateSchedule =
              MockCreateScheduleAppResult();

          when(() => user.id).thenReturn('id');
          when(() => appResultSchedulesList.data).thenReturn(timeSlots);
          when(() => appResultSchedulesList.error).thenReturn(null);
          when(() => appResultSchedulesList.success).thenReturn(true);
          when(() => scheduleRepository.getTimeSlots(
                  any<String>(), any<DateTime?>()))
              .thenAnswer((invocation) async => appResultSchedulesList);

          const Duration createScheduleInputDuration = Duration(hours: 1);
          final DateTime createScheduleInputStartTime =
              now.subtract(const Duration(hours: 1));

          when(() => appResultCreateSchedule.success).thenReturn(false);
          when(() => appResultCreateSchedule.error).thenReturn(UserNotPicked());
          when(() => appResultCreateSchedule.data).thenReturn(null);
          when(() => scheduleRepository.createSchedule(
                startDate: createScheduleInputStartTime,
                duration: createScheduleInputDuration,
                participantId: null,
              )).thenAnswer((invocation) async => appResultCreateSchedule);
          Get.put(scheduleController);

          scheduleController.updateState(
            duration: createScheduleInputDuration,
            selectedUser: null,
            dateTime: createScheduleInputStartTime,
          );
          await Future.delayed(const Duration(milliseconds: 300));
          expect(scheduleController.busyAreas.length, 0);
          await scheduleController.createSchedule();
          expect(scheduleController.error, UserNotPicked().message);
        },
      );
    },
  );
}
