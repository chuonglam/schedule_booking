import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schedule_booking/common/date_text_formatter.dart';
import 'package:schedule_booking/screens/create_schedule/widgets/pick_duration_widget.dart';
import 'package:schedule_booking/common/exts.dart';

class MyDateTimePicker extends StatefulWidget {
  const MyDateTimePicker({super.key});

  @override
  State<MyDateTimePicker> createState() => _DateTimePickState();
}

class _DateTimePickState extends State<MyDateTimePicker> {
  TextEditingController? textController;
  @override
  void initState() {
    super.initState();
    textController = TextEditingController()..text = DateTime.now().format();
  }

  @override
  void dispose() {
    textController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: textController,
                inputFormatters: <TextInputFormatter>[
                  DateTextFormatter(),
                ],
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_month),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onPressed: () async {
                      final value = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 2)),
                      );
                      textController?.text =
                          value?.format() ?? DateTime.now().format();
                    },
                  ),
                  hintText: "MM-dd-yyyy",
                ),
                onTap: () {},
              ),
            ),
            const SizedBox(width: 16),
            DurationPicker(
              onChanged: (hour) {},
            ),
          ],
        ),
      ],
    );
  }
}
