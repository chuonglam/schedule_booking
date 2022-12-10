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
  final int _minimumDurationInMinute = 30;
  final int _stepInMinute = 15;

  @override
  void initState() {
    super.initState();
    _hourController = TextEditingController()
      ..text = 1.toString().padLeft(2, '0');
    _minuteController = TextEditingController()
      ..text = 0.toString().padLeft(2, "0");
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
            controller: _hourController,
            textAlign: TextAlign.center,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            maxLength: 2,
            decoration: const InputDecoration(
              counterText: '',
              contentPadding: EdgeInsets.symmetric(vertical: 16),
            ),
            onChanged: (_) => _onChanged(),
          ),
        ),
        const Text(":"),
        SizedBox(
          width: 50,
          child: TextFormField(
            controller: _minuteController,
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
      (int.tryParse(_minuteController?.text ?? '') ?? _minimumDurationInMinute);

  int get _hour => int.tryParse(_hourController?.text ?? '') ?? 0;
  int get _minute =>
      int.tryParse(_minuteController?.text ?? '') ?? _minimumDurationInMinute;

  void _onChanged() {
    widget.onChanged?.call(Duration(hours: _hour, minutes: _minute));
  }

  void _increase() {
    int hours = _hour;
    int minutes = _minute + _stepInMinute;

    if (minutes >= Duration.minutesPerHour) {
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
    if (hours == 0 && minutes <= _minimumDurationInMinute) {
      return;
    }
    minutes -= _stepInMinute;
    if (minutes < 0) {
      minutes = Duration.minutesPerHour - _stepInMinute;
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
