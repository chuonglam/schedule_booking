import 'package:flutter/material.dart';
import 'package:schedule_booking/common/utils.dart';

class UserScheduleScreen extends StatelessWidget {
  const UserScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLargeScreen = Utils.isLargeScreen(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isLargeScreen ? 4 : 1,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: isLargeScreen ? 2.0 : 3.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => Card(
                  child: Center(child: Text("$index")),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
