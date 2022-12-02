import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_booking/common/styles.dart';
import 'package:schedule_booking/common/utils.dart';
import 'package:schedule_booking/screens/create_schedule/create_schedule_controller.dart';
import 'package:schedule_booking/screens/create_schedule/widgets/create_schedule_popup.dart';
import 'package:schedule_booking/screens/create_schedule/widgets/create_schedule_form.dart';
import 'package:schedule_booking/screens/create_schedule/widgets/pick_timeslot_widget.dart';
import 'package:schedule_booking/screens/create_schedule/widgets/users_picker.dart';

class CreateScheduleScreen extends GetView<CreateScheduleController> {
  final GlobalKey _key = GlobalKey();
  CreateScheduleScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final bool isLargeScreen = Utils.isLargeScreen(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Create a schedule",
            style: AppStyles.semiBold.copyWith(fontSize: 28.5),
          ),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CreateScheduleForm(),
                    Expanded(
                      child: UsersPicker(
                        key: _key,
                        onTap: (schedule) {
                          if (isLargeScreen) {
                            controller.selectSchedule(schedule);
                            return;
                          }
                          _onTap(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              if (isLargeScreen) ...[
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      const Text("What time do you want to start?"),
                      const SizedBox(height: 8),
                      Expanded(
                        child: TimeslotPicker(
                          onTap: (startHour) {
                            showDialog(
                              context: context,
                              builder: (ctx) {
                                return AlertDialog(
                                  title: const Text("Confirmation"),
                                  content: const CreateSchedulePopup(),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {},
                                      child: const Text("Create"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
              ]
            ],
          ),
        ),
      ],
    );
  }

  void _onTap(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => const AlertDialog(
        title: Text("Pick a time slot"),
        content: SizedBox(
          width: 300,
          child: TimeslotPicker(),
        ),
      ),
    );
  }
}
