import 'package:data/data.dart';
import 'package:flutter/material.dart';

abstract class UserRepository {
  Future<AppResult<User?>> getCurrentUser();
  Future<AppResult<List<User>>> getUsersList({
    required int durationInMins,
    String? nameSearch,
    DateTime? fromDate,
    TimeOfDay? fromTime,
    TimeOfDay? toTime,
  });
}
