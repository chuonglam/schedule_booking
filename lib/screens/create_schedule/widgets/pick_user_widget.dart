import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:schedule_booking/common/widgets/empty_state.dart';
import 'package:schedule_booking/screens/create_schedule/create_schedule_controller.dart';

class PickUserWidget extends GetView<CreateScheduleController> {
  const PickUserWidget({
    Key? key,
    this.onTap,
  }) : super(key: key);
  final void Function(User)? onTap;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading && controller.users.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (controller.users.isEmpty) {
        return const Center(
          child: EmptyState(
            title: "No users found",
          ),
        );
      }
      return ListView.builder(
        padding: const EdgeInsets.only(top: 16),
        itemBuilder: (context, index) {
          final user = controller.users[index];
          return ListTile(
            contentPadding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
            onTap: () {
              onTap?.call(user);
            },
            leading: CircleAvatar(
              child: Text(user.nameChar),
            ),
            title: Text(user.displayName),
            hoverColor: Theme.of(context).dividerColor,
            trailing: user.id == controller.state.selectedUser?.id
                ? const Icon(Icons.keyboard_arrow_right)
                : null,
          );
        },
        itemCount: controller.users.length,
      );
    });
  }
}
