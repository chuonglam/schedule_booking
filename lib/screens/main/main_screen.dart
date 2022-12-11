import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:common/common.dart';
import 'package:schedule_booking/common/styles.dart';
import 'package:schedule_booking/common/widgets/user_menu.dart';
import 'package:schedule_booking/screens/auth/auth_controller.dart';
import 'package:schedule_booking/screens/auth/auth_screen.dart';
import 'package:schedule_booking/screens/create_schedule/create_schedule_screen.dart';
import 'package:schedule_booking/screens/home/user_schedule_screen.dart';
import 'package:schedule_booking/screens/main/main_controller.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMediumOrLargeScreen = !context.isSmallScreen;
    final bool isLargeScreen = context.isLargeScreen;
    return Scaffold(
      appBar: AppBar(
        leading: Center(child: SvgPicture.asset('assets/svg/ic_logo.svg')),
        title: Text(DateTime.now().format(formatter: 'EEEE, MMM dd yyyy')),
        centerTitle: true,
        actions: [
          if (isMediumOrLargeScreen) const UserMenu(),
          const SizedBox(width: 16),
        ],
      ),
      backgroundColor: Colors.white,
      body: Row(
        children: [
          if (isMediumOrLargeScreen)
            Obx(() => NavigationRail(
                  extended: isLargeScreen,
                  elevation: 1,
                  minExtendedWidth: 200,
                  onDestinationSelected: (value) {
                    controller.selectedIndex = value;
                  },
                  destinations: [
                    NavigationRailDestination(
                      icon: SvgPicture.asset(
                        "ic_overview.svg".svgPath,
                        width: 20,
                        height: 20,
                      ),
                      label: const Text("Your schedule"),
                      selectedIcon: SvgPicture.asset(
                        "ic_overview.svg".svgPath,
                        color: AppStyles.mainColor,
                        width: 20,
                        height: 20,
                      ),
                    ),
                    NavigationRailDestination(
                      icon: SvgPicture.asset(
                        "ic_schedule.svg".svgPath,
                        width: 20,
                        height: 20,
                      ),
                      label: const Text("Create schedule"),
                      selectedIcon: SvgPicture.asset(
                        "ic_schedule.svg".svgPath,
                        color: AppStyles.mainColor,
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ],
                  selectedIndex: controller.selectedIndex,
                )),
          Expanded(
            child: Obx(() => IndexedStack(
                  index: controller.selectedIndex,
                  children: [
                    GetX<AuthController>(
                      builder: (authController) {
                        if (authController.currentUser != null) {
                          return const UserScheduleScreen();
                        }
                        return const AuthScreen();
                      },
                    ),
                    const CreateScheduleScreen(),
                  ],
                )),
          ),
        ],
      ),
      bottomNavigationBar: isMediumOrLargeScreen
          ? null
          : Obx(() {
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
            }),
    );
  }
}
