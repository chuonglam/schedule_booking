// ignore_for_file: invalid_use_of_protected_member

import 'package:data/data.dart';
import 'package:data/src/models/schedule_model.dart';
import 'package:injectable/injectable.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

@Singleton()
class ScheduleService {
  DateTime _getStartOfDay({DateTime? specifiedDate}) {
    final DateTime now = specifiedDate ?? DateTime.now();
    final DateTime startOfDay =
        DateTime(now.year, now.month, now.day, 0, 0, 0, 0);
    return startOfDay;
  }

  Future<String> createSchedule({
    required DateTime startDate,
    required DateTime endDate,
    required String participantId,
  }) async {
    final user = await ParseUser.currentUser() as ParseUser?;
    if (user == null) {
      throw UserNotLoggedIn();
    }
    if (user.objectId == participantId) {
      throw ParticipantIsHost();
    }
    final DateTime startOfDay = _getStartOfDay();
    final func = ParseCloudFunction("createSchedule");
    final res = await func.executeObjectFunction(parameters: {
      'startDate': startDate.toUtc().toString(),
      'endDate': endDate.toUtc().toString(),
      'participantId': participantId,
      'clientStartOfDay': startOfDay.toUtc().toString(),
    });
    if (res.success) {
      return 'success';
    }
    if (res.error?.code == 400) {
      throw ParticipantIsHost();
    }
    if (res.error?.code == 401) {
      throw UserNotLoggedIn();
    }
    if (res.error?.code == 403) {
      throw TimeOverlapped();
    }
    throw DefaultError();
  }

  Future<List<ScheduleModel>> getTimeSlots(String participantId) async {
    final DateTime startOfDay = _getStartOfDay();
    final func = ParseCloudFunction("getTimeSlots");
    final res = await func.executeObjectFunction(parameters: {
      'participantId': participantId,
      'clientStartOfDay': startOfDay.toUtc().toString(),
    });
    if (res.success) {
      return (res.result['result'] as List<dynamic>)
          .map((e) =>
              ScheduleModel.fromJson((e as ParseObject).toJson(full: true)))
          .toList();
    }
    if (res.error?.code == 400) {
      throw MissingArguments(res.error?.message ?? '');
    }
    if (res.error?.code == 401) {
      throw UserNotLoggedIn();
    }
    throw DefaultError(res.error?.message ?? '');
  }

  Future<List<ScheduleModel>> getUserTimeSlots({
    required int limit,
    required int skip,
    DateTime? date,
  }) async {
    final DateTime startOfDay = _getStartOfDay(specifiedDate: date);
    final func = ParseCloudFunction("getUserTimeSlots");
    final res = await func.executeObjectFunction(parameters: {
      'limit': limit,
      'skip': skip,
      'clientStartOfDay': startOfDay.toUtc().toString(),
    });
    if (res.success) {
      return (res.result['result'] as List<dynamic>)
          .map((e) =>
              ScheduleModel.fromJson((e as ParseObject).toJson(full: true)))
          .toList();
    }
    if (res.error?.code == 401) {
      throw UserNotLoggedIn();
    }
    throw DefaultError(res.error?.message ?? '');
  }
}
