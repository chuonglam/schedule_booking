import 'package:data/data.dart';

class Schedule {
  String objectId;
  DateTime startDate;
  DateTime endDate;
  User host;
  User participant;

  Schedule({
    required this.objectId,
    required this.startDate,
    required this.endDate,
    required this.host,
    required this.participant,
  });
}
