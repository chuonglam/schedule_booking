import 'package:flutter/material.dart';
import 'package:schedule_booking/common/exts.dart';
import 'package:schedule_booking/common/widgets/logo.dart';
import 'package:schedule_booking/common/styles.dart';
import 'package:schedule_booking/models/schedule_params.dart';

class ScheduleConfirmation extends StatelessWidget {
  const ScheduleConfirmation({super.key, required this.data});
  final ScheduleParams data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "Guest",
                        style: AppStyles.regular.copyWith(
                          color: AppStyles.mainColor,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        data.selectedUser?.displayName ?? '',
                        style: AppStyles.bold.copyWith(
                          color: AppStyles.mainColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "Date",
                        style: AppStyles.regular.copyWith(
                          color: AppStyles.mainColor,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        data.calendarDateTime
                            .format(formatter: 'MMM dd, HH:mm'),
                        style: AppStyles.bold.copyWith(
                          color: AppStyles.mainColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "Time (hr)",
                        style: AppStyles.regular.copyWith(
                          color: AppStyles.mainColor,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        data.duration.toHourFormat(),
                        style: AppStyles.bold.copyWith(
                          color: AppStyles.mainColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
