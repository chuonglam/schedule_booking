import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  String format({String? formatter}) {
    final format = DateFormat(formatter ?? 'MM-dd-yyyy');
    return format.format(this);
  }
}

extension BuildContextX on BuildContext {
  bool get isSmallScreen => MediaQuery.of(this).size.width < 650;

  bool get isMediumScreen {
    final width = MediaQuery.of(this).size.width;
    return width >= 650 && width < 1000;
  }

  bool get isLargeScreen {
    return MediaQuery.of(this).size.width >= 1000;
  }
}

extension StringX on String {
  bool isValidUsername() {
    final regex = RegExp(r"^[A-Za-z][A-Za-z0-9_]{4,16}$");
    return regex.hasMatch(this);
  }

  bool isValidEmail() {
    final regex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    return regex.hasMatch(this);
  }
}
