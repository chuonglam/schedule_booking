import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_booking/common/styles.dart';
import 'package:schedule_booking/screens/auth/auth_controller.dart';
import 'package:schedule_booking/screens/auth/signup_screen.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.topCenter,
        child: _LoginForm(controller: controller),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final AuthController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 350),
      padding: const EdgeInsets.all(8),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                ),
                Text(
                  "Login",
                  style: AppStyles.bold.copyWith(fontSize: 24),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              "Welcome back, please enter your details",
              style: Theme.of(context).textTheme.caption,
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: "Username",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: "Password",
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    controller.login();
                    Get.back();
                  },
                  child: const Text("Login"),
                ),
                Expanded(
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        Get.toNamed('$SignupScreen');
                      },
                      child: const Text("Sign up"),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
