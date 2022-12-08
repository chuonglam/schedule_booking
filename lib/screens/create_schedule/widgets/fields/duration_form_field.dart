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
  TextEditingController? _hourController;
  TextEditingController? _minuteController;
  final int _minimumDurationInMin = 30;
  final int _stepInMin = 15;
  @override
  void initState() {
    super.initState();
    _hourController = TextEditingController();
    _minuteController = TextEditingController();
  }

  @override
  void dispose() {
    _hourController?.dispose();
    _minuteController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 50,
          child: TextFormField(
            controller: _hourController?..text = 0.toString().padLeft(2, '0'),
            textAlign: TextAlign.center,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            maxLength: 2,
            decoration: const InputDecoration(
              counterText: '',
              contentPadding: EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
        const Text(":"),
        SizedBox(
          width: 50,
          child: TextFormField(
            controller: _minuteController
              ?..text = 30.toString().padLeft(2, '0'),
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
          ),
        ),
        Column(
          children: [
            GestureDetector(
              onTap: () {
                _increase();
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
                _decrease();
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

  int get totalMinutes =>
      (int.tryParse(_hourController?.text ?? '') ?? 0) +
      (int.tryParse(_minuteController?.text ?? '') ?? _minimumDurationInMin);

  int get _hour => int.tryParse(_hourController?.text ?? '') ?? 0;
  int get _minute =>
      int.tryParse(_minuteController?.text ?? '') ?? _minimumDurationInMin;

  void _increase() {
    int minutes = _minute + _stepInMin;
    int hours = _hour;
    if (minutes >= 60) {
      minutes = 0;
      hours++;
    }
    _minuteController?.text = minutes.toString().padLeft(2, '0');
    _hourController?.text = hours.toString().padLeft(2, '0');
    widget.onChanged?.call(Duration(hours: hours, minutes: minutes));
  }

  void _decrease() {
    int minutes = _minute;
    int hours = _hour;
    if (hours == 0 && minutes <= _minimumDurationInMin) {
      return;
    }
    minutes -= _stepInMin;
    if (minutes < 0) {
      minutes = 60 - _stepInMin;
      hours--;
      if (hours <= 0) {
        hours = 0;
      }
    }
    _minuteController?.text = minutes.toString().padLeft(2, '0');
    _hourController?.text = hours.toString().padLeft(2, '0');
    widget.onChanged?.call(Duration(hours: hours, minutes: minutes));
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
