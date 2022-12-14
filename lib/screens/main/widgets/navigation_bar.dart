import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_booking/screens/main/main_controller.dart';

class MainNavigationBar extends GetView<MainController> {
  const MainNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return BottomNavigationBar(
          currentIndex: controller.selectedIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Your schedule",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: "Create schedule",
            ),
          ],
          onTap: (value) {
            controller.selectedIndex = value;
          },
        );
      },
    );
  }
}
