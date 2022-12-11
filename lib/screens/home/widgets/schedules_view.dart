import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_booking/common/widgets/empty_state.dart';
import 'package:schedule_booking/screens/home/user_schedule_controller.dart';
import 'package:schedule_booking/screens/home/widgets/schedule_card.dart';

class SchedulesView extends StatelessWidget {
  const SchedulesView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLargeScreen = context.isLargeScreen;
    final bool isMediumScreen = context.isMediumScreen;
    return GetX<UserScheduleController>(
      builder: (controller) {
        if (controller.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (controller.data.isEmpty) {
          return const EmptyState();
        }
        return GridView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: controller.data.length,
          shrinkWrap: true,
          itemBuilder: ((context, index) {
            return ScheduleCard(
              schedule: controller.data[index],
            );
          }),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isLargeScreen
                ? 3
                : isMediumScreen
                    ? 2
                    : 1,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 3.0,
          ),
        );
      },
    );
  }
}
