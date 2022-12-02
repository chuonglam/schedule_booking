import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DurationPicker extends StatefulWidget {
  const DurationPicker({
    super.key,
    this.onChanged,
  });
  final void Function(int)? onChanged;

  @override
  State<DurationPicker> createState() => _DurationPickerState();
}

class _DurationPickerState extends State<DurationPicker> {
  final TextEditingController _hourController = TextEditingController();
  int _hour = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 50,
          child: GestureDetector(
            onTap: () async {},
            child: TextField(
              controller: _hourController
                ..text = _hour.toString().padLeft(2, '0'),
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
                _hour = int.parse(value);
              },
            ),
          ),
        ),
        Column(
          children: [
            GestureDetector(
              onTap: _increase,
              child: const Icon(
                Icons.arrow_drop_up,
              ),
            ),
            Text(
              "hrs",
              style: Theme.of(context).textTheme.caption,
            ),
            GestureDetector(
              onTap: _decrease,
              child: const Icon(
                Icons.arrow_drop_down,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _increase() {
    setState(() {
      _hour += 1;
    });
    widget.onChanged?.call(_hour);
  }

  void _decrease() {
    if (_hour <= 1) {
      return;
    }
    setState(() {
      _hour--;
    });
    widget.onChanged?.call(_hour);
  }
}
