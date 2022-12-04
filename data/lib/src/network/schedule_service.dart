import 'package:data/src/models/schedule_model.dart';
import 'package:injectable/injectable.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

@Singleton()
class ScheduleService {
  Future<void> createSchedule({
    required DateTime startDate,
    required DateTime endDate,
    required String participantId,
  }) async {
    //todo: convert startDate from local timezone to the selected timezone
    final newDate = startDate;
    final func = ParseCloudFunction("createSchedule");
    final res = await func.executeObjectFunction(parameters: {
      'startDate': newDate.toUtc().toString(),
      'endDate': endDate.toUtc().toString(),
      'participantId': participantId,
    });
  }

  Future<List<ScheduleModel>> getTimeSlots(String participantId) async {
    final func = ParseCloudFunction("getTimeSlots");
    final res = await func.executeObjectFunction(parameters: {
      'participantId': participantId,
    });
    if (res.success) {
      return (res.result['result'] as List<dynamic>)
          .map((e) =>
              ScheduleModel.fromJson((e as ParseObject).toJson(full: true)))
          .toList();
    }
    return [];
  }
}
