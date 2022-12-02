import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:schedule_booking/common/styles.dart';
import 'package:schedule_booking/screens/create_schedule/create_schedule_controller.dart';

class UsersPicker extends GetView<CreateScheduleController> {
  const UsersPicker({
    Key? key,
    this.onTap,
  }) : super(key: key);
  final void Function(Schedule)? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      controller.search();
                    },
                  ),
                  hintText: "Input user's name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Color(0xffEAEAEA),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppStyles.mainColor,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Color(0xffEAEAEA),
                    ),
                  ),
                ),
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  controller.search();
                },
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
        Expanded(
          child: controller.obx(
            (state) {
              if (state?.isNotEmpty != true) {
                return const Center(
                  child: Text("No results"),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.only(top: 16),
                itemBuilder: (context, index) => Obx(() {
                  return ListTile(
                    contentPadding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
                    leading: Radio<String>(
                      value: 'null',
                      onChanged: (value) {},
                      groupValue: null,
                    ),
                    onTap: () {
                      controller.selectSchedule(state[index]);
                      onTap?.call(state[index]);
                    },
                    title: Row(
                      children: [
                        const CircleAvatar(),
                        Text(state![index].user.username),
                      ],
                    ),
                    selected: controller.selectedSchedule?.user.id ==
                        state[index].user.id,
                    hoverColor: Theme.of(context).dividerColor,
                    trailing: const Icon(Icons.keyboard_arrow_right),
                  );
                }),
                itemCount: state?.length ?? 0,
              );
            },
            onEmpty: const Center(
              child: Text("No results"),
            ),
            onLoading: const Center(
              child: CircularProgressIndicator(),
            ),
            onError: (error) => Center(
              child: Text(
                'Error: $error',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
