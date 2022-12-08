import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_booking/common/exts.dart';
import 'package:schedule_booking/screens/home/user_schedule_controller.dart';
import 'package:schedule_booking/screens/home/widgets/schedules_view.dart';
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
            Card(
              margin: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                constraints: const BoxConstraints(maxWidth: 250),
                child: GetBuilder<UserScheduleController>(
                  builder: (controller) {
                    return SfCalendar(
                      view: CalendarView.month,
                      cellBorderColor: Colors.transparent,
                      headerDateFormat: "MMMM",
                      initialSelectedDate: null,
                      onSelectionChanged: (calendarSelectionDetails) {
                        if (calendarSelectionDetails.date == null) {
                          return;
                        }
                        controller.selectedDate =
                            calendarSelectionDetails.date!;
                      },
                    );
                  },
                ),
              ),
            ),
            if (!isSmallScreen)
              const Expanded(
                child: SchedulesView(),
              )
          ],
        ),
        if (isSmallScreen)
          const Expanded(
            child: SchedulesView(),
          )
      ],
    );
  }
}
