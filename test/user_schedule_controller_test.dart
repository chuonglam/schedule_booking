import 'package:common/common.dart';
import 'package:data/data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:schedule_booking/screens/home/user_schedule_controller.dart';

import 'mocks/mocks.dart';

void main() {
  late ScheduleRepository scheduleRepository;
  late UserScheduleController scheduleController;

  setUp(() {
    scheduleRepository = MockScheduleRepository();
    scheduleController =
        UserScheduleController(scheduleRepository: scheduleRepository);
  });

  tearDown(() {
    scheduleController.dispose();
    Get.delete<UserScheduleController>();
  });

  test(
    'should return data if success',
    () async {
      final result = MockListSchedulesAppResult();
      final List<MockSchedule> data =
          List.generate(pageSize, (idx) => MockSchedule());
      when(() => result.data).thenReturn(data);
      when(() => result.success).thenReturn(true);
      when(() => result.error).thenReturn(null);
      when(() => scheduleRepository.getUserTimeSlots(
            limit: any<int>(named: 'limit'),
            skip: any<int>(named: 'skip'),
            date: any<DateTime>(named: 'date'),
          )).thenAnswer((_) async => result);

      Get.put(scheduleController);
      verify(
        () => scheduleRepository.getUserTimeSlots(
          limit: any<int>(named: 'limit'),
          skip: any<int>(named: 'skip'),
          date: any<DateTime>(named: 'date'),
        ),
      ).called(1);
      await Future.delayed(const Duration(seconds: 1));
      expect(scheduleController.data.length, data.length);
      await scheduleController.doRefreshData();
      expect(scheduleController.data.length, data.length);
    },
  );

  test(
    'should be able to load more if data result is >= pageSize',
    () async {
      final result = MockListSchedulesAppResult();
      final List<MockSchedule> data =
          List.generate(pageSize, (idx) => MockSchedule());
      when(() => result.data).thenReturn(data);
      when(() => result.success).thenReturn(true);
      when(() => result.error).thenReturn(null);
      when(() => scheduleRepository.getUserTimeSlots(
            limit: any<int>(named: 'limit'),
            skip: any<int>(named: 'skip'),
            date: any<DateTime>(named: 'date'),
          )).thenAnswer((_) async => result);

      Get.put(scheduleController);
      verify(
        () => scheduleRepository.getUserTimeSlots(
          limit: any<int>(named: 'limit'),
          skip: any<int>(named: 'skip'),
          date: any<DateTime>(named: 'date'),
        ),
      ).called(1);
      await Future.delayed(const Duration(seconds: 1));
      expect(scheduleController.data.length, data.length);
      await scheduleController.loadMore(data.length);
      expect(scheduleController.data.length, data.length * 2);
    },
  );

  test(
    'should not be able to load more if data result is < pageSize',
    () async {
      final result = MockListSchedulesAppResult();
      final List<MockSchedule> data =
          List.generate(pageSize - 1, (idx) => MockSchedule());
      when(() => result.data).thenReturn(data);
      when(() => result.success).thenReturn(true);
      when(() => result.error).thenReturn(null);
      when(() => scheduleRepository.getUserTimeSlots(
            limit: any<int>(named: 'limit'),
            skip: any<int>(named: 'skip'),
            date: any<DateTime>(named: 'date'),
          )).thenAnswer((_) async => result);

      Get.put(scheduleController);
      verify(
        () => scheduleRepository.getUserTimeSlots(
          limit: any<int>(named: 'limit'),
          skip: any<int>(named: 'skip'),
          date: any<DateTime>(named: 'date'),
        ),
      ).called(1);
      await Future.delayed(const Duration(seconds: 1));
      expect(scheduleController.data.length, data.length);
      await scheduleController.loadMore(data.length);
      expect(scheduleController.data.length, data.length);
    },
  );

  test(
    'should be able to retry if error occurs',
    () async {
      final AppError error = DefaultError();
      final result = MockListSchedulesAppResult();
      when(() => result.data).thenReturn(null);
      when(() => result.success).thenReturn(false);
      when(() => result.error).thenReturn(error);
      when(() => scheduleRepository.getUserTimeSlots(
            limit: any<int>(named: 'limit'),
            skip: any<int>(named: 'skip'),
            date: any<DateTime>(named: 'date'),
          )).thenAnswer((_) async => result);

      Get.put(scheduleController);
      expect(scheduleController.retry, false);
      verify(
        () => scheduleRepository.getUserTimeSlots(
          limit: any<int>(named: 'limit'),
          skip: any<int>(named: 'skip'),
          date: any<DateTime>(named: 'date'),
        ),
      ).called(1);
      await Future.delayed(const Duration(seconds: 1));
      expect(scheduleController.retry, true);
    },
  );

  test(
    'should be able to reload if select another date',
    () async {
      final result = MockListSchedulesAppResult();
      final List<MockSchedule> data =
          List.generate(pageSize - 1, (idx) => MockSchedule());
      when(() => result.data).thenReturn(data);
      when(() => result.success).thenReturn(true);
      when(() => result.error).thenReturn(null);
      when(() => scheduleRepository.getUserTimeSlots(
            limit: any<int>(named: 'limit'),
            skip: any<int>(named: 'skip'),
            date: any<DateTime>(named: 'date'),
          )).thenAnswer((_) async => result);

      Get.put(scheduleController);
      verify(
        () => scheduleRepository.getUserTimeSlots(
          limit: any<int>(named: 'limit'),
          skip: any<int>(named: 'skip'),
          date: any<DateTime>(named: 'date'),
        ),
      ).called(1);
      await Future.delayed(const Duration(seconds: 1));
      expect(scheduleController.data.length, data.length);
      await scheduleController.loadMore(data.length);
      expect(scheduleController.data.length, data.length);

      scheduleController.clear();
      expect(scheduleController.data.length, 0);

      scheduleController.selectedDate =
          DateTime.now().add(const Duration(days: 1));
      await Future.delayed(const Duration(seconds: 1));
      expect(scheduleController.data.length, data.length);
    },
  );
}
