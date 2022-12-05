import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_booking/common/styles.dart';
import 'package:schedule_booking/screens/create_schedule/widgets/fields/date_form_field.dart';
import 'package:schedule_booking/screens/create_schedule/widgets/fields/duration_form_field.dart';
import 'package:schedule_booking/screens/create_schedule/create_schedule_controller.dart';

class CreateScheduleForm extends GetView<CreateScheduleController> {
  final EdgeInsets padding;
  final GlobalKey<FormState> _formKey = GlobalKey();
  CreateScheduleForm({
    Key? key,
    this.padding = const EdgeInsets.all(16),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text("Select a date and duration in hour"),
            const SizedBox(height: 6),
            DateFormField(
              context: context,
              onSaved: (value) {
                controller.updateState(dateTime: value);
              },
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    borderRadius: BorderRadius.circular(2),
                    decoration: const InputDecoration(),
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: Text("abc"),
                        ),
                      ),
                    ],
                    onSaved: (value) {},
                    onChanged: (value) {},
                  ),
                ),
                const SizedBox(width: 16),
                GetBuilder<CreateScheduleController>(
                  builder: (controller) {
                    return DurationFormField(
                      onChanged: (hour) {
                        controller.updateState(
                            duration: Duration(hours: hour ?? 1));
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Input user's name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xffEAEAEA),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppStyles.mainColor,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xffEAEAEA),
                        ),
                      ),
                    ),
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      submitForm();
                    },
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    submitForm();
                  },
                  child: const Text("Search"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void submitForm() {
    _formKey.currentState?.save();
    controller.search();
  }
}
