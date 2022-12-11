import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:schedule_booking/screens/home/user_schedule_controller.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class SchedulesCalendar extends GetView<UserScheduleController> {
  const SchedulesCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        constraints: const BoxConstraints(maxWidth: 250),
        child: SfCalendar(
          view: CalendarView.month,
          cellBorderColor: Colors.transparent,
          headerDateFormat: "MMMM",
          initialSelectedDate: null,
          onSelectionChanged: (calendarSelectionDetails) {
            if (calendarSelectionDetails.date == null) {
              return;
            }
            controller.selectedDate = calendarSelectionDetails.date!;
          },
        ),
      ),
    );
  }
}
