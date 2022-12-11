import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_booking/common/styles.dart';
import 'package:schedule_booking/screens/create_schedule/create_schedule_controller.dart';

class NameSearchField extends GetView<CreateScheduleController> {
  const NameSearchField({
    super.key,
    this.onFieldSubmitted,
  });
  final VoidCallback? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
      onSaved: (value) {
        controller.updateFilter(usernameInput: value);
      },
      onFieldSubmitted: (value) {
        onFieldSubmitted?.call();
      },
    );
  }
}
