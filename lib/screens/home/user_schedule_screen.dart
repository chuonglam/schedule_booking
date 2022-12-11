import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:common/common.dart';
import 'package:schedule_booking/screens/home/user_schedule_controller.dart';
import 'package:schedule_booking/screens/home/widgets/schedules_calendar.dart';
import 'package:schedule_booking/screens/home/widgets/schedules_list.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class UserScheduleScreen extends StatelessWidget {
  const UserScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = context.isSmallScreen;
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
