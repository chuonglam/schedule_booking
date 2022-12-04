import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:schedule_booking/screens/create_schedule/create_schedule_controller.dart';

class UsersList extends StatelessWidget {
  const UsersList({
    Key? key,
    this.onTap,
  }) : super(key: key);
  final void Function(User)? onTap;
  @override
  Widget build(BuildContext context) {
    return GetX<CreateScheduleController>(
      builder: (controller) {
        if (controller.isLoading && controller.users.isEmpty) {
          return Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.only(top: 16),
          itemBuilder: (context, index) => ListTile(
            contentPadding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
            onTap: () {
              onTap?.call(controller.users[index]);
            },
            leading: const CircleAvatar(),
            title: Text(controller.users[index].username),
            // selected: controller.selectedUser?.id == controller.users[index].id,
            hoverColor: Theme.of(context).dividerColor,
            trailing: const Icon(Icons.keyboard_arrow_right),
          ),
          itemCount: controller.users.length,
        );
      },
    );
  }
}
