import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_booking/screens/auth/login_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text("Ops! Please login!"),
        onPressed: () {
          Get.toNamed('/$LoginScreen');
        },
      ),
    );
  }
}
