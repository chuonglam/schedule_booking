import 'package:get/get.dart';
import 'package:schedule_booking/screens/auth/auth_controller.dart';
import 'package:schedule_booking/screens/create_schedule/create_schedule_controller.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => CreateScheduleController(), fenix: true);
  }
}
