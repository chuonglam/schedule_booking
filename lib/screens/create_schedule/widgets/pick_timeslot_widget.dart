import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_booking/screens/create_schedule/create_schedule_controller.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class PickTimeSlotWidget extends StatelessWidget {
  const PickTimeSlotWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<CreateScheduleController>(
      builder: (controller) {
        final DateTime now = DateTime.now();
        return SfCalendar(
          dataSource: controller.source,
          view: CalendarView.day,
          specialRegions: controller.regions
              .map((e) => TimeRegion(
                    startTime: e.startDate,
                    endTime: e.endDate,
                    color: Colors.redAccent,
                  ))
              .toList(),
          viewNavigationMode: ViewNavigationMode.none,
          cellEndPadding: 0,
          timeSlotViewSettings: const TimeSlotViewSettings(
              // startHour: DateTime.now().hour.toDouble(),
              ),
          allowDragAndDrop: true,
          initialDisplayDate: controller.selectedDate,
          minDate: now,
          onDragEnd: (value) {
            if (value.droppingTime == null) {
              return;
            }
            controller.selectedDate = value.droppingTime!;
          },
        );
      },
    );
  }
}

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
