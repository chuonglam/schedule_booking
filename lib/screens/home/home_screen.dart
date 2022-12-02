import 'package:flutter/material.dart';
import 'package:schedule_booking/common/exts.dart';

class UserScheduleScreen extends StatelessWidget {
  const UserScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMediumOrLargeScreen = !context.isSmallScreen;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isMediumOrLargeScreen ? 4 : 1,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: isMediumOrLargeScreen ? 2.0 : 3.0,
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
