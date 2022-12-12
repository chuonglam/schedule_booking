import 'package:common/common.dart';
import 'package:data/data.dart';
import 'package:data/src/models/user_model.dart';
import 'package:data/src/network/user_service.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserService _userService;
  UserRepositoryImpl({
    required UserService userService,
  }) : _userService = userService;

  @override
  Future<AppResult<User?>> getCurrentUser() async {
    try {
      final UserModel? user = await _userService.currentUser();
      return AppResult.success(user?.toUser());
    } catch (e) {
      //todo: handle exceptions
      return AppResult.error(DefaultError());
    }
  }

  @override
  Future<AppResult<List<User>>> getUsersList({
    required int durationInMins,
    String? nameSearch,
    DateTime? fromDate,
    TimeOfDay? fromTime,
    TimeOfDay? toTime,
    bool? sortAscending,
  }) async {
    try {
      if (fromDate != null) {
        if (fromTime != null) {}
        fromDate =
            fromDate.isToday() ? DateTime.now() : fromDate.beginningOfDay();
      }
      fromDate ??= DateTime.now();

      final data = await _userService.getUsersList(
        durationInMins: durationInMins,
        sorting: (sortAscending ?? true) ? 'ascending' : 'descending',
        nameSearch: nameSearch,
        fromDateTime:
            (fromTime == null) ? fromDate : fromDate.setTime(fromTime),
        toDateTime:
            (toTime == null) ? fromDate.endOfDay() : fromDate.setTime(toTime),
      );
      return AppResult.success(data.map((e) => e.toUser()).toList());
    } catch (e) {
      //todo: handle exceptions
      return AppResult.error(DefaultError());
    }
  }
}
