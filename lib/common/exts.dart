import 'package:syncfusion_flutter_calendar/calendar.dart';

extension TimeRegionX on TimeRegion {
  bool isOverlapped(List<TimeRegion> busyAreas) {
    return busyAreas.any((timeRegion) => _dateRangeOverlaps(this, timeRegion));
  }

  bool _dateRangeOverlaps(TimeRegion a, TimeRegion b) {
    if (!a.startTime.isAfter(b.startTime) && b.startTime.isBefore(a.endTime)) {
      return true;
    }
    if (a.startTime.isBefore(b.endTime) && !b.endTime.isAfter(a.endTime)) {
      return true;
    }
    if (b.startTime.isBefore(a.startTime) && a.endTime.isBefore(b.endTime)) {
      return true;
    }
    return false;
  }
}
