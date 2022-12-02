import 'package:flutter/material.dart';
import 'package:schedule_booking/common/exts.dart';

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
            const Icon(Icons.timeline),
            const SizedBox(width: 16),
            Text("${DateTime.now().format()} 00:00pm - 6:00pm"),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: const [
            Icon(Icons.people),
            SizedBox(width: 16),
            Text("User name 1"),
          ],
        )
      ],
    );
  }
}
