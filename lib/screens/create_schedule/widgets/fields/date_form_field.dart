import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:common/common.dart';
import 'package:schedule_booking/common/date_text_formatter.dart';

class DateFormField extends FormField<DateTime> {
  DateFormField({
    required BuildContext context,
    FormFieldSetter<DateTime>? onSaved,
    FormFieldValidator<DateTime>? validator,
    DateTime? initialValue,
    bool autovalidate = false,
    super.key,
  }) : super(
          onSaved: onSaved,
          initialValue: initialValue ?? DateTime.now(),
          builder: (FormFieldState<DateTime> state) {
            final TextEditingController textController =
                TextEditingController();
            return TextFormField(
              controller: textController..text = state.value?.format() ?? '',
              inputFormatters: <TextInputFormatter>[
                DateTextFormatter(),
              ],
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: SvgPicture.asset(
                    'assets/svg/ic_calendar.svg',
                    color: Theme.of(context).textTheme.caption?.color,
                  ),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onPressed: () async {
                    final DateTime now = DateTime.now();
                    final value = await showDatePicker(
                      context: context,
                      initialDate: state.value ?? now,
                      firstDate: now,
                      lastDate: now.add(const Duration(days: 31)),
                    );
                    if (value == null) {
                      return;
                    }
                    state.didChange(value);
                  },
                ),
                hintText: "MM-dd-yyyy",
              ),
              onTap: () {},
            );
          },
        );
}
