import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:schedule_booking/common/exts.dart';
import 'package:schedule_booking/common/styles.dart';
import 'package:schedule_booking/screens/auth/auth_controller.dart';
import 'package:schedule_booking/screens/auth/auth_screen.dart';
import 'package:schedule_booking/screens/create_schedule/create_schedule_screen.dart';
import 'package:schedule_booking/screens/home/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final bool isMediumOrLargeScreen = !context.isSmallScreen;
    final bool isLargeScreen = context.isLargeScreen;
    return Scaffold(
      appBar: AppBar(
        leading:
            isMediumOrLargeScreen ? null : const Center(child: CircleAvatar()),
        title: Text(DateTime.now().format(formatter: 'EEEE, MMM dd yyyy')),
        centerTitle: true,
        actions: [
          if (isMediumOrLargeScreen) const CircleAvatar(),
          const SizedBox(width: 16),
        ],
      ),
      backgroundColor: Colors.white,
      body: Row(
        children: [
          if (isMediumOrLargeScreen)
            NavigationRail(
              extended: isLargeScreen,
              elevation: 1,
              minExtendedWidth: 200,
              onDestinationSelected: (value) {
                setState(() {
                  _selectedIndex = value;
                });
              },
              destinations: [
                NavigationRailDestination(
                  icon: SvgPicture.asset(
                    "assets/svg/ic_overview.svg",
                    width: 20,
                    height: 20,
                  ),
                  label: const Text("Your schedule"),
                  selectedIcon: SvgPicture.asset(
                    "assets/svg/ic_overview.svg",
                    color: AppStyles.mainColor,
                    width: 20,
                    height: 20,
                  ),
                ),
                NavigationRailDestination(
                  icon: SvgPicture.asset(
                    "assets/svg/ic_schedule.svg",
                    width: 20,
                    height: 20,
                  ),
                  label: const Text("Create schedule"),
                  selectedIcon: SvgPicture.asset(
                    "assets/svg/ic_schedule.svg",
                    color: AppStyles.mainColor,
                    width: 20,
                    height: 20,
                  ),
                ),
              ],
              selectedIndex: _selectedIndex,
            ),
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
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
            ),
          ),
        ],
      ),
      bottomNavigationBar: isMediumOrLargeScreen
          ? null
          : BottomNavigationBar(
              currentIndex: _selectedIndex,
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
                setState(() {
                  _selectedIndex = value;
                });
              },
            ),
    );
  }

  void _createSchedule() {
    // Get.toNamed('$CreateScheduleScreen');
    // return;
    Get.defaultDialog(
      content: ConstrainedBox(
        constraints: BoxConstraints(
            maxWidth: 500, minWidth: 500, maxHeight: Get.height * 2 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(hintText: "Select schedule date"),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(hintText: "Select schedule date"),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text("Pick a user"),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(hintText: "Input name"),
                  ),
                ),
                Icon(Icons.filter),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
