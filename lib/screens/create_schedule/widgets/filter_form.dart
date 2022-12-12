import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_booking/common/styles.dart';
import 'package:schedule_booking/screens/create_schedule/create_schedule_controller.dart';

class FilterForm extends GetView<CreateScheduleController> {
  const FilterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    return Card(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Filter available users by selecting a time range",
              style: AppStyles.medium,
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    showTimePicker(
                      context: context,
                      initialTime: controller.filter?.fromTime ??
                          TimeOfDay.fromDateTime(now),
                    ).then((value) {
                      _updateFilter(context, fromTime: value);
                    });
                  },
                  child: Obx(() => Text(
                        controller.filter?.fromTime?.format(context) ?? 'from',
                      )),
                ),
                TextButton(
                  onPressed: () {
                    showTimePicker(
                      context: context,
                      initialTime: controller.filter?.toTime ??
                          TimeOfDay.fromDateTime(now.add(const Duration(
                              minutes: defaultBookingScheduleTimeInMins))),
                    ).then((value) {
                      _updateFilter(context, toTime: value);
                    });
                  },
                  child: Obx(() => Text(
                        controller.filter?.toTime?.format(context) ?? 'to',
                      )),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              "Sort users list by available time slots",
              style: AppStyles.medium,
            ),
            const SizedBox(height: 6),
            TextButton(
              onPressed: () {
                _updateFilter(context,
                    isTimeSlotAscending:
                        !(controller.filter?.isTimeSlotAscending ?? true));
              },
              child: Obx(() => Text(
                    (controller.filter?.isTimeSlotAscending ?? true)
                        ? "Ascending"
                        : "Descending",
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void _updateFilter(
    BuildContext context, {
    TimeOfDay? fromTime,
    TimeOfDay? toTime,
    bool? isTimeSlotAscending,
  }) {
    String? errorMessage = controller.updateFilter(
      fromTime: fromTime,
      toTime: toTime,
      isTimeSlotAscending: isTimeSlotAscending,
    );
    if (errorMessage == null) {
      return;
    }
    context.dialog(
      content: Text(errorMessage),
    );
  }
}
