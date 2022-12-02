import 'package:flutter/material.dart';

class Utils {
  static bool isLargeScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= 650;
}
