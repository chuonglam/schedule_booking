import 'package:data/data.dart';

class Schedule {
  final User user;
  final List<int> schedules;
  Schedule({
    required this.user,
    this.schedules = const [],
  });
}
