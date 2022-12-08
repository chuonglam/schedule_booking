// ignore_for_file: use_build_context_synchronously

import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_booking/common/exts.dart';
import 'package:schedule_booking/common/widgets/empty_state.dart';
import 'package:schedule_booking/common/widgets/schedule_confirmation.dart';
import 'package:schedule_booking/common/styles.dart';
import 'package:schedule_booking/screens/create_schedule/create_schedule_controller.dart';
import 'package:schedule_booking/screens/create_schedule/widgets/create_schedule_form.dart';
import 'package:schedule_booking/screens/create_schedule/widgets/pick_timeslot_widget.dart';
import 'package:schedule_booking/screens/create_schedule/widgets/pick_user_widget.dart';
import 'package:schedule_booking/screens/main/main_screen.dart';

class CreateScheduleScreen extends GetView<CreateScheduleController> {
  const CreateScheduleScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final bool isMediumOrLargeScreen = !context.isSmallScreen;
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
                    CreateScheduleForm(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    Expanded(
                      child: PickUserWidget(
                        onTap: (user) {
                          _onTapUser(context, isMediumOrLargeScreen, user);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              if (isMediumOrLargeScreen) ...[
                const SizedBox(width: 16),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 16.0, 0, 8),
                        child: Text("Drag & drop to select start time"),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.topCenter,
                          margin: const EdgeInsets.only(bottom: 16),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Obx(() {
                                if (controller.state.selectedUser == null) {
                                  return Container(
                                    alignment: Alignment.center,
                                    child: const EmptyState(
                                      title: "Select a user to continue",
                                    ),
                                  );
                                }
                                return const PickTimeSlotWidget();
                              }),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Obx(() {
                          return ElevatedButton(
                            onPressed: controller.state.selectedUser == null
                                ? null
                                : () => _onClickCreateSchedule(context),
                            child: const Text("Create"),
                          );
                        }),
                      ),
                      const SizedBox(height: 16),
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

  void _onClickCreateSchedule(BuildContext context) async {
    final negative = await context.dialog(
      positiveText: 'Cancel',
      negativeText: 'Create',
      title: 'Confirmation',
      subtitle:
          'This is your schedule overview. Find your schedule details in the dashboard on our site after your confirmation',
      content: ScheduleConfirmation(
        data: controller.state,
      ),
    );
    if (negative != false) {
      return;
    }
    final String? errorMessage = await controller.createSchedule();
    if (errorMessage == null) {
      Get.offNamedUntil('/$MainScreen', (route) => true);
      return;
    }
    context.dialog(
      title: 'Error',
      content: Text(errorMessage),
    );
  }

  void _onTapUser(
      BuildContext context, bool isMediumOrLargeScreen, User schedule) {
    if (isMediumOrLargeScreen) {
      controller.updateState(selectedUser: schedule);
      return;
    }
    context.dialog(
      title: "Pick a time slot",
      negativeText: 'Create',
      positiveText: 'Cancel',
      content: const SizedBox(
        width: 500,
        height: 500,
        child: PickTimeSlotWidget(),
      ),
    );
  }
}
