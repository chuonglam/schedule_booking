import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_booking/common/widgets/logo.dart';
import 'package:schedule_booking/common/widgets/user_menu.dart';
import 'package:schedule_booking/screens/main/main_controller.dart';
import 'package:schedule_booking/screens/main/widgets/main_body.dart';
import 'package:schedule_booking/screens/main/widgets/navigation_bar.dart';
import 'package:schedule_booking/screens/main/widgets/navigation_rails.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMediumOrLargeScreen = !context.isSmallScreen;
    final bool isLargeScreen = context.isLargeScreen;
    return Scaffold(
      appBar: AppBar(
        leading: const AppLogo(size: 60),
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
            MainNavigationRails(
              expanded: isLargeScreen,
            ),
          const Expanded(
            child: MainBody(),
          ),
        ],
      ),
      bottomNavigationBar:
          isMediumOrLargeScreen ? null : const MainNavigationBar(),
    );
  }
}
