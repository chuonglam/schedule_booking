import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:schedule_booking/screens/home/widgets/schedules_calendar.dart';
import 'package:schedule_booking/screens/home/widgets/schedules_list.dart';

class UserScheduleScreen extends StatelessWidget {
  const UserScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = context.isSmallScreen;
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SchedulesCalendar(),
            if (!isSmallScreen)
              const Expanded(
                child: SchedulesList(),
              )
          ],
        ),
        if (isSmallScreen)
          const Expanded(
            child: SchedulesList(),
          ),
      ],
    );
  }
}
