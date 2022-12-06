import 'package:data/data.dart';
import 'package:data/src/models/user_model.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class ScheduleModel {
  String objectId;
  DateTime startDate;
  DateTime endDate;
  UserModel host;
  UserModel participant;

  ScheduleModel({
    required this.objectId,
    required this.startDate,
    required this.endDate,
    required this.host,
    required this.participant,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      objectId: json['objectId'],
      startDate: DateTime.parse(json['startDate']['iso']).toLocal(),
      endDate: DateTime.parse(json['endDate']['iso']).toLocal(),
      host: UserModel.fromJson(json['host']),
      participant: UserModel.fromJson(json['participant']),
    );
  }

  Schedule toSchedule() => Schedule(
        objectId: objectId,
        startDate: startDate,
        endDate: endDate,
        host: host.toUser(),
        participant: participant.toUser(),
      );
}
