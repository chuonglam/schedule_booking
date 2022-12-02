import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_booking/common/exts.dart';
import 'package:schedule_booking/screens/auth/auth_controller.dart';
import 'package:schedule_booking/screens/auth/auth_screen.dart';
import 'package:schedule_booking/screens/create_schedule/create_schedule_screen.dart';
import 'package:schedule_booking/screens/home/home_screen.dart';
import 'package:schedule_booking/common/utils.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    final bool isLargeScreen = Utils.isLargeScreen(context);
    return Scaffold(
      appBar: AppBar(
        leading: isLargeScreen ? null : const Center(child: CircleAvatar()),
        title: Text(DateTime.now().format(formatter: 'EEEE, MMM dd yyyy')),
        centerTitle: true,
        actions: [
          if (isLargeScreen) const CircleAvatar(),
          const SizedBox(width: 16),
        ],
      ),
      backgroundColor: Colors.white,
      body: Row(
        children: [
          if (isLargeScreen)
            NavigationRail(
              extended: isLargeScreen,
              elevation: 1,
              minExtendedWidth: 200,
              onDestinationSelected: (value) {
                setState(() {
                  _selectedIndex = value;
                });
              },
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text(
                    "Your schedule",
                  ),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.add),
                  label: Text("Create schedule"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.settings),
                  label: Text("Setting"),
                ),
              ],
              selectedIndex: _selectedIndex,
            ),
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: [
                GetX<AuthController>(builder: (controller) {
                  if (controller.isLoggedIn) {
                    return const UserScheduleScreen();
                  }
                  return const AuthScreen();
                }),
                CreateScheduleScreen(),
                Container(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: isLargeScreen
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
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: "Settings",
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
