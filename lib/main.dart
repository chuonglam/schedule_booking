import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_booking/common/styles.dart';
import 'package:schedule_booking/screens/app/app_router.dart';
import 'package:schedule_booking/screens/app/app_binding.dart';
import 'package:schedule_booking/screens/main/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Schedule booking',
      getPages: AppRouter.pages,
      initialBinding: AppBinding(),
      theme: AppStyles.theme(context),
      initialRoute: '$MainScreen',
    );
  }
}
