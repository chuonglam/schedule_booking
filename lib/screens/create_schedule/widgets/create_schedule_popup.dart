import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:common/common.dart';

class CreateSchedulePopup extends StatelessWidget {
  const CreateSchedulePopup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              'assets/svg/ic_calendar.svg',
              color: Color(0xff757575),
            ),
            const SizedBox(width: 16),
            Text(DateTime.now().format()),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            SvgPicture.asset(
              'assets/svg/ic_time.svg',
              color: const Color(0xff757575),
            ),
            const SizedBox(width: 16),
            Text("00:00pm - 6:00pm"),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            SvgPicture.asset('assets/svg/ic_chat.svg'),
            SizedBox(width: 16),
            Text("User name 1"),
          ],
        )
      ],
    );
  }
}
