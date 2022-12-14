import 'package:get/get.dart';
import 'package:schedule_booking/di/sl.dart';
import 'package:schedule_booking/screens/auth/login_screen.dart';
import 'package:schedule_booking/screens/auth/signup_controller.dart';
import 'package:schedule_booking/screens/main/main_screen.dart';
import 'package:schedule_booking/screens/auth/signup_screen.dart';

class AppRouter {
  static final pages = <GetPage>[
    GetPage(
      name: '/$MainScreen',
      page: () => const MainScreen(),
    ),
    GetPage(
      name: '/$LoginScreen',
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: '/$SignupScreen',
      binding: BindingsBuilder(() => Get.lazyPut(() => SignUpController(
            authRepository: sl(),
          ))),
      page: () => const SignupScreen(),
    ),
  ];
}
