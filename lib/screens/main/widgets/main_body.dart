import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:schedule_booking/screens/auth/auth_controller.dart';
import 'package:schedule_booking/screens/auth/auth_screen.dart';
import 'package:schedule_booking/screens/create_schedule/create_schedule_screen.dart';
import 'package:schedule_booking/screens/home/user_schedule_screen.dart';
import 'package:schedule_booking/screens/main/main_controller.dart';

class MainBody extends GetView<MainController> {
  const MainBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => IndexedStack(
          index: controller.selectedIndex,
          children: [
            GetX<AuthController>(
              builder: (authController) {
                if (authController.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (authController.currentUser != null) {
                  return const UserScheduleScreen();
                }
                return const AuthScreen();
              },
            ),
            const CreateScheduleScreen(),
          ],
        ));
  }
}
