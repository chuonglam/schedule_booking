import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DurationPicker extends StatefulWidget {
  const DurationPicker({
    super.key,
    this.onChanged,
  });
  final void Function(Duration)? onChanged;
  @override
  State<DurationPicker> createState() => _DurationPickerState();
}

class _DurationPickerState extends State<DurationPicker> {
  TextEditingController? hourController;
  TextEditingController? minuteController;

  @override
  void initState() {
    super.initState();
    hourController = TextEditingController();
    minuteController = TextEditingController();
  }

  @override
  void dispose() {
    hourController?.dispose();
    minuteController?.dispose();
    super.dispose();
  }

  int _minutes = 60;

  @override
  Widget build(BuildContext context) {
    final int hour = _minutes ~/ 60;
    final int minutes = _minutes % 60;
    return Row(
      children: [
        SizedBox(
          width: 50,
          child: TextFormField(
            controller: hourController?..text = hour.toString().padLeft(2, '0'),
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
              setState(() {
                _minutes = 60;
              });
            },
          ),
        ),
        const Text(" : "),
        SizedBox(
          width: 50,
          child: TextFormField(
            controller: minuteController
              ?..text = minutes.toString().padLeft(2, '0'),
            textAlign: TextAlign.center,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            maxLength: 2,
            enabled: false,
            decoration: const InputDecoration(
              counterText: '',
              contentPadding: EdgeInsets.symmetric(vertical: 16),
            ),
            onChanged: (value) {
              final num = int.tryParse(value);
              if (num == null) {
                return;
              }
              setState(() {
                _minutes = num;
              });
            },
          ),
        ),
        Column(
          children: [
            GestureDetector(
              onTap: () {
                final int newValue = _minutes + 15;
                setState(() {
                  _minutes = newValue;
                });
                widget.onChanged?.call(Duration(minutes: _minutes));
                // onChanged?.call(newValue);
              },
              child: const Icon(
                Icons.arrow_drop_up,
              ),
            ),
            const Text(
              "min",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            GestureDetector(
              onTap: () {
                if (_minutes <= 30) {
                  return;
                }
                final int newValue = _minutes - 15;
                setState(() {
                  _minutes = newValue;
                });
                widget.onChanged?.call(Duration(minutes: _minutes));
              },
              child: const Icon(
                Icons.arrow_drop_down,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class DurationFormField extends FormField<int> {
  DurationFormField({
    FormFieldSetter<int>? onSaved,
    FormFieldSetter<int>? onChanged,
    FormFieldValidator<int>? validator,
    int initialValue = 60,
    bool autovalidate = false,
    super.key,
  }) : super(
          onSaved: onSaved,
          initialValue: initialValue,
          builder: (FormFieldState<int> state) {
            final TextEditingController hourController =
                TextEditingController();
            final TextEditingController minuteController =
                TextEditingController();
            final int hour = (state.value ?? 60) ~/ 60;
            final int minute = (state.value ?? 60) % 60;
            return Row(
              children: [
                SizedBox(
                  width: 50,
                  child: TextFormField(
                    initialValue: hour.toString().padLeft(2, '0'),
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
                const Text(":"),
                SizedBox(
                  width: 50,
                  child: TextFormField(
                    initialValue: minute.toString().padLeft(2, '0'),
                    textAlign: TextAlign.center,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    maxLength: 2,
                    enabled: false,
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
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        final int newValue = (state.value ?? 0) + 15;
                        state.didChange(newValue);
                        onChanged?.call(newValue);
                      },
                      child: const Icon(
                        Icons.arrow_drop_up,
                      ),
                    ),
                    const Text(
                      "min",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if ((state.value ?? 0) <= 30) {
                          return;
                        }
                        final int newValue = state.value! - 15;
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
