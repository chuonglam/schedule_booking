import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:common/common.dart';
import 'package:schedule_booking/screens/create_schedule/widgets/search_name_widget.dart';
import 'package:schedule_booking/screens/create_schedule/widgets/filter_form.dart';
import 'package:schedule_booking/common/widgets/logo.dart';
import 'package:schedule_booking/screens/create_schedule/create_schedule_controller.dart';
import 'package:schedule_booking/screens/create_schedule/widgets/pick_date_widget.dart';
import 'package:schedule_booking/screens/create_schedule/widgets/pick_duration_widget.dart';
import 'package:schedule_booking/screens/create_schedule/widgets/filter_button.dart';

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
            Row(
              children: [
                Expanded(
                  child: PickDateWidget(
                    context: context,
                    onSaved: (value) {
                      controller.updateState(dateTime: value);
                    },
                  ),
                ),
                const SizedBox(width: 6),
                PickDurationWidget(
                  onChanged: (hour) => controller.updateState(duration: hour),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: SearchNameWidget(
                    onFieldSubmitted: _submitForm,
                  ),
                ),
                Obx(() => FilterButton(
                      onTap: () => _showFilterPopup(context),
                      hasData: controller.filter != null,
                    )),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Icon(Icons.search),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterPopup(BuildContext context) async {
    final isOkTapped = await context.dialog(
        icon: const AppLogo(),
        barrierDismissible: false,
        content: const FilterForm(),
        positiveText: "Clear",
        negativeText: "OK");
    if (isOkTapped == false) {
      return;
    }
    controller.clearFilter();
  }

  void _submitForm() {
    _formKey.currentState?.save();
    controller.searchUsers();
  }
}
