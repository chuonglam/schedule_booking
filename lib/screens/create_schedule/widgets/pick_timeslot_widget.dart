import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_booking/common/exts.dart';
import 'package:schedule_booking/common/styles.dart';
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
          dataSource: controller.appointment == null
              ? null
              : AppointmentDataSource([
                  controller.appointment!,
                ]),
          view: CalendarView.day,
          specialRegions:
              List<TimeRegion>.from(controller.busyAreas.map((e) => TimeRegion(
                    startTime: e.startDate,
                    endTime: e.endDate,
                    color: AppStyles.mainColor.withOpacity(0.5),
                    text:
                        "${e.startDate.format(formatter: 'HH:mm')} - ${e.endDate.format(formatter: 'HH:mm')}",
                    textStyle: AppStyles.regular,
                  ))),
          viewNavigationMode: ViewNavigationMode.none,
          showCurrentTimeIndicator: false,
          cellEndPadding: 0,
          timeSlotViewSettings: const TimeSlotViewSettings(
            minimumAppointmentDuration: Duration(minutes: 30),
          ),
          allowDragAndDrop: true,
          initialDisplayDate: controller.state.calendarDateTime,
          minDate: now,
          onDragEnd: (value) {
            if (value.droppingTime == null) {
              return;
            }
            DateTime selectedDate = value.droppingTime!;
            final Appointment? appointment = value.appointment as Appointment?;
            if (appointment == null) {
              return;
            }
            if (appointment.endTime.isToday() != true) {
              selectedDate = DateTime(selectedDate.year, selectedDate.month,
                      selectedDate.day, 23, 59, 59, 999)
                  .subtract(controller.state.duration);
            }
            controller.updateState(dateTime: selectedDate);
          },
        );
      },
    );
  }
}
