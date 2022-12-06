import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:schedule_booking/common/exts.dart';
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
              horizontal: 8,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: schedule.endDate.isBefore(DateTime.now())
                  ? const Color(0xFFDEDEDE) // Color(0xFFC7B7EB)
                  : AppStyles.mainColor,
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
                      'assets/svg/ic_time.svg',
                      color: const Color(0xFF757575),
                      width: 15,
                    ),
                    const SizedBox(width: 8),
                    Text.rich(
                      TextSpan(
                        text: schedule.startDate.format(formatter: 'HH:mm'),
                        children: [
                          TextSpan(
                            text: ' - ',
                          ),
                          TextSpan(
                            text: schedule.endDate.format(formatter: 'HH:mm'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/ic_chat.svg',
                      width: 15,
                    ),
                    const SizedBox(width: 8),
                    Text(schedule.host.displayName +
                        "-" +
                        schedule.participant.displayName),
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
