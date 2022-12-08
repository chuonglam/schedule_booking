import 'package:flutter/material.dart';
import 'package:schedule_booking/common/styles.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    this.title,
  });
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title ?? "No data found",
            style: AppStyles.medium.copyWith(
              fontSize: 18,
            ),
          ),
          Image.asset(
            'assets/img/empty.png',
            width: 150,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
