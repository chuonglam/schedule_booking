import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:schedule_booking/screens/auth/login_screen.dart';
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
      page: () => const SignupScreen(),
    ),
  ];
}
