import 'package:data/data.dart';

class Schedule {
  String objectId;
  DateTime startDate;
  DateTime endDate;
  User host;
  User participant;
  final String? _currentUserId;

  bool get own => _currentUserId != null && _currentUserId == host.id;

  Schedule({
    required this.objectId,
    required this.startDate,
    required this.endDate,
    required this.host,
    required this.participant,
    String? currentUserId,
  }) : _currentUserId = currentUserId;
}
