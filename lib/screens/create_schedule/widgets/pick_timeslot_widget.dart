import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_booking/screens/create_schedule/create_schedule_controller.dart';
import 'package:schedule_booking/models/appointment_data_source.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class PickTimeSlotWidget extends StatelessWidget {
  const PickTimeSlotWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<CreateScheduleController>(
      builder: (controller) {
        final DateTime now = DateTime.now();
        return SfCalendar(
          dataSource: AppointmentDataSource([
            controller.appointment,
          ]),
          view: CalendarView.day,
          specialRegions: controller.busyAreas
              .map((e) => TimeRegion(
                    startTime: e.startDate,
                    endTime: e.endDate,
                    iconData: Icons.stop,
                    color: const Color(0xFFDDDDDD),
                  ))
              .toList(),
          viewNavigationMode: ViewNavigationMode.none,
          cellEndPadding: 0,
          timeSlotViewSettings: const TimeSlotViewSettings(),
          allowDragAndDrop: true,
          initialDisplayDate: controller.state.calendarDateTime,
          minDate: now,
          onDragEnd: (value) {
            if (value.droppingTime == null) {
              return;
            }
            controller.updateState(dateTime: value.droppingTime);
          },
        );
      },
    );
  }
}
