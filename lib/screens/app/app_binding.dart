import 'package:get/get.dart';
import 'package:schedule_booking/di/sl.dart';
import 'package:schedule_booking/screens/auth/auth_controller.dart';
import 'package:schedule_booking/screens/create_schedule/create_schedule_controller.dart';
import 'package:schedule_booking/screens/home/user_schedule_controller.dart';
import 'package:schedule_booking/screens/main/main_controller.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => AuthController(
        authRepository: sl(),
        userRepository: sl(),
      ),
      fenix: true,
    );
    Get.lazyPut(
      () => MainController(),
      fenix: true,
    );
    Get.lazyPut(
      () => CreateScheduleController(
        scheduleRepository: sl(),
        userRepository: sl(),
      ),
      fenix: true,
    );
    Get.lazyPut(
      () => UserScheduleController(
        scheduleRepository: sl(),
      ),
      fenix: true,
    );
  }
}
