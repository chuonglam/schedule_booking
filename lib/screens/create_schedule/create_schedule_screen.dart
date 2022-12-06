import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_booking/common/exts.dart';
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
                        onTap: (schedule) {
                          if (isMediumOrLargeScreen) {
                            controller.updateState(selectedUser: schedule);
                            return;
                          }
                          _onTapUser(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              if (isMediumOrLargeScreen) ...[
                const SizedBox(width: 16),
                Container(
                  alignment: Alignment.center,
                  child: const Icon(Icons.arrow_right),
                ),
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
                            color: const Color(0xffF1EEF6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Obx(() {
                                if (controller.state.selectedUser == null) {
                                  return Container(
                                      alignment: Alignment.center,
                                      child: const Text("Please pick a user"));
                                }
                                return const PickTimeSlotWidget();
                              }),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () => _onClickCreateSchedule(context),
                          child: const Text("Create"),
                        ),
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
    final String? errorMessage = await controller.createSchedule();
    if (errorMessage == null) {
      Get.offNamedUntil('/$MainScreen', (route) => true);
      return;
    }
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Create schedule failed"),
        content: SizedBox(
          width: 300,
          child: Text(errorMessage),
        ),
      ),
    );
  }

  void _onTapUser(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => const AlertDialog(
        title: Text("Pick a time slot"),
        content: SizedBox(
          width: 300,
          child: PickTimeSlotWidget(),
        ),
      ),
    );
  }
}
