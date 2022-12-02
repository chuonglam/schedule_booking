import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_booking/common/exts.dart';
import 'package:schedule_booking/screens/create_schedule/create_schedule_controller.dart';

class TimeslotPicker extends StatelessWidget {
  const TimeslotPicker({
    super.key,
    this.onTap,
  });
  final void Function(int)? onTap;
  @override
  Widget build(BuildContext context) {
    final bool isMediumOrLargeScreen = !context.isSmallScreen;
    final int curHour = DateTime.now().hour;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMediumOrLargeScreen ? 4 : 1,
        childAspectRatio: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (c, i) =>
          GetX<CreateScheduleController>(builder: (controller) {
        final bool notAvailable =
            controller.selectedSchedule?.schedules.contains(i + curHour) ==
                    true ||
                curHour > (i + curHour);
        return Card(
          color: notAvailable ? const Color(0xffEAEAEA) : null,
          child: InkWell(
            onTap: notAvailable
                ? null
                : () {
                    onTap?.call(i + curHour);
                  },
            borderRadius: BorderRadius.circular(5),
            child: Center(
              child: Text('${(i + curHour).toString().padLeft(2, '0')}:00'),
            ),
          ),
        );
      }),
      itemCount: 24 - curHour,
    );
  }
}
