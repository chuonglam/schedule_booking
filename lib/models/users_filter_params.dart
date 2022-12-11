import 'package:flutter/material.dart';

class UsersFilterParams {
  final String? userNameInput;
  final TimeOfDay? fromTime;
  final TimeOfDay? toTime;
  UsersFilterParams({
    this.userNameInput,
    this.fromTime,
    this.toTime,
  });
  UsersFilterParams copyWith({
    String? usernameInput,
    TimeOfDay? fromTime,
    TimeOfDay? toTime,
  }) {
    return UsersFilterParams(
      userNameInput: usernameInput ?? userNameInput,
      fromTime: fromTime ?? this.fromTime,
      toTime: toTime ?? this.toTime,
    );
  }
}
