import 'package:flutter/material.dart';

class FilterPopup extends StatelessWidget {
  const FilterPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              TextButton(
                onPressed: () {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay(hour: 9, minute: 0),
                  );
                },
                child: Text("ABC"),
              ),
              TextButton(
                onPressed: () {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay(hour: 9, minute: 0),
                  );
                },
                child: Text("ABC"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
