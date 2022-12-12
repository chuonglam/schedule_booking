import 'package:flutter/material.dart';

class UsersFilterParams {
  final String? userNameInput;
  final TimeOfDay? fromTime;
  final TimeOfDay? toTime;
  final bool isTimeSlotAscending;
  UsersFilterParams({
    this.userNameInput,
    this.fromTime,
    this.toTime,
    this.isTimeSlotAscending = true,
  });
  UsersFilterParams copyWith({
    String? usernameInput,
    TimeOfDay? fromTime,
    TimeOfDay? toTime,
    bool? isTimeSlotAscending,
  }) {
    return UsersFilterParams(
      userNameInput: usernameInput ?? userNameInput,
      fromTime: fromTime ?? this.fromTime,
      toTime: toTime ?? this.toTime,
      isTimeSlotAscending: isTimeSlotAscending ?? this.isTimeSlotAscending,
    );
  }
}
