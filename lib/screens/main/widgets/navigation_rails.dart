import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:schedule_booking/common/styles.dart';
import 'package:schedule_booking/screens/main/main_controller.dart';

class MainNavigationRails extends GetView<MainController> {
  const MainNavigationRails({super.key, required this.expanded});
  final bool expanded;
  @override
  Widget build(BuildContext context) {
    return Obx(() => NavigationRail(
          extended: expanded,
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
        ));
  }
}
