import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_booking/common/styles.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.topCenter,
        child: _SignupForm(),
      ),
    );
  }
}

class _SignupForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 350),
      padding: const EdgeInsets.all(8),
      child: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.keyboard_arrow_left),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                ),
                Text(
                  "Create an account",
                  style: AppStyles.bold.copyWith(fontSize: 24),
                ),
                const Spacer(),
              ],
            ),
            Text(
              "Welcome back, please enter your details",
              style: Theme.of(context).textTheme.caption,
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(hintText: "Username"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(hintText: "Display name"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: "Password",
                ),
                obscureText: true,
                obscuringCharacter: "*",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(hintText: "Confirm password"),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Sign up"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
