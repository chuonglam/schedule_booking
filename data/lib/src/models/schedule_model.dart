import 'package:data/data.dart';

class ScheduleModel {
  String objectId;
  DateTime startDate;
  DateTime endDate;

  ScheduleModel({
    required this.objectId,
    required this.startDate,
    required this.endDate,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      objectId: json['objectId'],
      startDate: DateTime.parse(json['startDate']['iso']).toLocal(),
      endDate: DateTime.parse(json['endDate']['iso']).toLocal(),
    );
  }

  Schedule toSchedule() => Schedule(
        objectId: objectId,
        startDate: startDate,
        endDate: endDate,
      );
}
