import 'package:common/common.dart';
import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:schedule_booking/common/styles.dart';

class ScheduleCard extends StatelessWidget {
  final Schedule schedule;
  const ScheduleCard({
    super.key,
    required this.schedule,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 6,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: schedule.endDate.isBefore(DateTime.now())
                  ? const Color(0xFFDEDEDE)
                  : (schedule.startDate.isToday())
                      ? AppStyles.mainColor
                      : const Color(0xFFC7B7EB),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  schedule.startDate.format(formatter: "EEE"),
                  style: AppStyles.medium.copyWith(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  schedule.startDate.format(formatter: "dd"),
                  style: AppStyles.medium.copyWith(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'ic_time.svg'.svgPath,
                      color: const Color(0xFF757575),
                      width: 13,
                    ),
                    const SizedBox(width: 6),
                    Text.rich(
                      TextSpan(
                        text: schedule.startDate.format(formatter: 'HH:mm'),
                        children: [
                          const TextSpan(
                            text: ' - ',
                          ),
                          TextSpan(
                            text: schedule.endDate.format(formatter: 'HH:mm'),
                          ),
                        ],
                      ),
                      style: AppStyles.medium,
                    )
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    SvgPicture.asset(
                      'ic_chat.svg'.svgPath,
                      width: 13,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      schedule.participant.displayName,
                      style: AppStyles.regular,
                    ),
                  ],
                ),
                const SizedBox(height: 6),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
