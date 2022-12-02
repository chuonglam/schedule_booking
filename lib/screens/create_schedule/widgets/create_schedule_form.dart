import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_booking/screens/create_schedule/widgets/pick_date_widget.dart';
import 'package:schedule_booking/screens/create_schedule/create_schedule_controller.dart';

class CreateScheduleForm extends GetView<CreateScheduleController> {
  const CreateScheduleForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Select a date and duration in hour"),
          MyDateTimePicker(),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
