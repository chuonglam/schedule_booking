import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DurationFormField extends FormField<int> {
  DurationFormField({
    FormFieldSetter<int>? onSaved,
    FormFieldSetter<int>? onChanged,
    FormFieldValidator<int>? validator,
    int initialValue = 1,
    bool autovalidate = false,
    super.key,
  }) : super(
          onSaved: onSaved,
          initialValue: initialValue,
          builder: (FormFieldState<int> state) {
            final TextEditingController hourController =
                TextEditingController();
            return Row(
              children: [
                SizedBox(
                  width: 50,
                  child: GestureDetector(
                    onTap: () async {},
                    child: TextField(
                      controller: hourController
                        ..text = state.value?.toString().padLeft(2, '0') ?? '1',
                      textAlign: TextAlign.center,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      maxLength: 2,
                      decoration: const InputDecoration(
                        counterText: '',
                        contentPadding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      onChanged: (value) {
                        final num = int.tryParse(value);
                        if (num == null) {
                          return;
                        }
                        state.didChange(num);
                      },
                    ),
                  ),
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        final int newValue = (state.value ?? 0) + 1;
                        state.didChange(newValue);
                        onChanged?.call(newValue);
                      },
                      child: const Icon(
                        Icons.arrow_drop_up,
                      ),
                    ),
                    const Text(
                      "hrs",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if ((state.value ?? 0) <= 1) {
                          return;
                        }
                        final int newValue = state.value! - 1;
                        state.didChange(newValue);
                        onChanged?.call(newValue);
                      },
                      child: const Icon(
                        Icons.arrow_drop_down,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
}
